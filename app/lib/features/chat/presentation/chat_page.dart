import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<_Conversation> _conversations = [
    _Conversation(
      id: 'morning',
      title: 'Morning warm-up',
      messages: [
        _ChatMessage(
          text: 'Good morning! What is one thing you are looking forward to today?',
          isFromUser: false,
        ),
      ],
    ),
    _Conversation(
      id: 'coffee',
      title: 'At the coffee shop',
      messages: [
        _ChatMessage(
          text: 'Let’s practice ordering your usual coffee in English.',
          isFromUser: false,
        ),
        _ChatMessage(
          text: 'Could I get a latte, please?',
          isFromUser: true,
        ),
      ],
    ),
    _Conversation(
      id: 'weekend',
      title: 'Weekend plans',
      messages: [
        _ChatMessage(
          text: 'Tell me about your weekend plans. I can help you make them sound natural.',
          isFromUser: false,
        ),
      ],
    ),
  ];
  String _activeConversationId = 'morning';
  bool _assistantIsTyping = false;

  _Conversation get _activeConversation => _conversations.firstWhere(
        (conversation) => conversation.id == _activeConversationId,
      );

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.sizeOf(context).width >= 760;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: context.pop,
          icon: const Icon(Icons.arrow_back_rounded),
          tooltip: 'Back',
        ),
        title: Text(
          _activeConversation.title,
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          if (!isWide)
            IconButton(
              onPressed: _showConversations,
              icon: const Icon(Icons.forum_outlined),
              tooltip: 'Conversations',
            ),
          IconButton(
            onPressed: _startConversation,
            icon: const Icon(Icons.add_comment_outlined),
            tooltip: 'New conversation',
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Row(
        children: [
          if (isWide)
            SizedBox(
              width: 280,
              child: _ConversationList(
                conversations: _conversations,
                activeId: _activeConversationId,
                onSelect: _selectConversation,
                onNewConversation: _startConversation,
              ),
            ),
          Expanded(child: _chatBody),
        ],
      ),
    );
  }

  Widget get _chatBody {
    final conversation = _activeConversation;

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
            itemCount: conversation.messages.length + (_assistantIsTyping ? 1 : 0),
            itemBuilder: (context, index) {
              if (index >= conversation.messages.length) {
                return const _MessageBubble(
                  text: 'Thinking…',
                  isFromUser: false,
                );
              }

              final message = conversation.messages[index];
              return _MessageBubble(
                text: message.text,
                isFromUser: message.isFromUser,
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: TextField(
                  controller: _messageController,
                  minLines: 1,
                  maxLines: 4,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: const InputDecoration(
                    hintText: 'Write a message…',
                    border: OutlineInputBorder(),
                  ),
                  onSubmitted: (_) => _sendMessage(),
                ),
              ),
              const SizedBox(width: 8),
              IconButton.filled(
                onPressed: _assistantIsTyping ? null : _sendMessage,
                icon: const Icon(Icons.send_rounded),
                tooltip: 'Send message',
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(
            'Demo replies are local sample data; OpenAI is not connected.',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      ],
    );
  }

  Future<void> _showConversations() {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (sheetContext) => SafeArea(
        child: SizedBox(
          height: MediaQuery.sizeOf(sheetContext).height * 0.65,
          child: _ConversationList(
            conversations: _conversations,
            activeId: _activeConversationId,
            onSelect: (conversation) {
              _selectConversation(conversation);
              Navigator.of(sheetContext).pop();
            },
            onNewConversation: () {
              _startConversation();
              Navigator.of(sheetContext).pop();
            },
          ),
        ),
      ),
    );
  }

  void _selectConversation(_Conversation conversation) {
    setState(() {
      _activeConversationId = conversation.id;
      _assistantIsTyping = false;
    });
    _scrollToBottom();
  }

  void _startConversation() {
    final conversation = _Conversation(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      title: 'New conversation',
      messages: [
        _ChatMessage(
          text: 'Hi! I’m ready to practice English with you. What would you like to talk about?',
          isFromUser: false,
        ),
      ],
    );
    setState(() {
      _conversations.insert(0, conversation);
      _activeConversationId = conversation.id;
      _assistantIsTyping = false;
    });
  }

  Future<void> _sendMessage() async {
    final text = _messageController.text.trim();
    if (text.isEmpty || _assistantIsTyping) return;

    final conversation = _activeConversation;
    setState(() {
      conversation.messages.add(_ChatMessage(text: text, isFromUser: true));
      if (conversation.title == 'New conversation') {
        conversation.title = text.length > 28 ? '${text.substring(0, 28)}…' : text;
      }
      _assistantIsTyping = true;
    });
    _messageController.clear();
    _scrollToBottom();

    await Future<void>.delayed(const Duration(milliseconds: 550));
    if (!mounted || conversation.id != _activeConversationId) return;

    setState(() {
      conversation.messages.add(
        _ChatMessage(
          text: 'Nice start! Here is a more natural way to say it: “$text.” '
              'What would you like to say next?',
          isFromUser: false,
        ),
      );
      _assistantIsTyping = false;
    });
    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) return;
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
      );
    });
  }
}

class _ConversationList extends StatelessWidget {
  const _ConversationList({
    required this.conversations,
    required this.activeId,
    required this.onSelect,
    required this.onNewConversation,
  });

  final List<_Conversation> conversations;
  final String activeId;
  final ValueChanged<_Conversation> onSelect;
  final VoidCallback onNewConversation;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 8, 8),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'CONVERSATIONS',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
              IconButton(
                onPressed: onNewConversation,
                icon: const Icon(Icons.add_rounded),
                tooltip: 'New conversation',
              ),
            ],
          ),
        ),
        const Divider(height: 1),
        Expanded(
          child: ListView.builder(
            itemCount: conversations.length,
            itemBuilder: (context, index) {
              final conversation = conversations[index];
              return ListTile(
                selected: conversation.id == activeId,
                leading: const Icon(Icons.chat_bubble_outline_rounded),
                title: Text(
                  conversation.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  conversation.messages.last.text,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                onTap: () => onSelect(conversation),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _MessageBubble extends StatelessWidget {
  const _MessageBubble({
    required this.text,
    required this.isFromUser,
  });

  final String text;
  final bool isFromUser;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final alignment = isFromUser ? Alignment.centerRight : Alignment.centerLeft;
    final background = isFromUser ? colors.primary : colors.surfaceContainerHighest;
    final foreground = isFromUser ? colors.onPrimary : colors.onSurface;

    return Align(
      alignment: alignment,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 560),
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Text(text, style: TextStyle(color: foreground)),
        ),
      ),
    );
  }
}

class _Conversation {
  _Conversation({
    required this.id,
    required this.title,
    required this.messages,
  });

  final String id;
  String title;
  final List<_ChatMessage> messages;
}

class _ChatMessage {
  const _ChatMessage({
    required this.text,
    required this.isFromUser,
  });

  final String text;
  final bool isFromUser;
}
