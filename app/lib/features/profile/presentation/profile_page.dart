import 'package:flutter/material.dart';
import '../../../core/widgets/page_header.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const PageHeader(
            title: 'Your profile',
            subtitle: 'Make your learning experience yours.',
          ),
          const SizedBox(height: 24),
          const Card(
            child: ListTile(
              leading: CircleAvatar(child: Text('J')),
              title: Text('Jamie'),
              subtitle: Text('English level · A2'),
              trailing: Icon(Icons.chevron_right_rounded),
            ),
          ),
          const SizedBox(height: 12),
          const Card(
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.language_rounded),
                  title: Text('Learning language'),
                  subtitle: Text('English'),
                  trailing: Icon(Icons.chevron_right_rounded),
                ),
                Divider(height: 1, indent: 64),
                ListTile(
                  leading: Icon(Icons.notifications_outlined),
                  title: Text('Notifications'),
                  trailing: Icon(Icons.chevron_right_rounded),
                ),
                Divider(height: 1, indent: 64),
                ListTile(
                  leading: Icon(Icons.settings_outlined),
                  title: Text('App settings'),
                  trailing: Icon(Icons.chevron_right_rounded),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
