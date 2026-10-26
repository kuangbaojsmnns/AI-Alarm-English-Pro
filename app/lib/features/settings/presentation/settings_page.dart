import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_constants.dart';
import '../application/system_status_providers.dart';
import '../domain/entities/system_status.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = ref.watch(systemStatusProvider);
    final colors = Theme.of(context).colorScheme;

    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () => ref.refresh(systemStatusProvider.future),
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: context.pop,
                  icon: const Icon(Icons.arrow_back_rounded),
                  tooltip: 'Back',
                ),
                const SizedBox(width: 4),
                Text('Settings & status', style: Theme.of(context).textTheme.titleLarge),
              ],
            ),
            const SizedBox(height: 18),
            Text(
              'SERVICE STATUS',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    letterSpacing: 1.1,
                  ),
            ),
            const SizedBox(height: 10),
            status.when(
              loading: () => const _StatusCard(
                icon: Icons.cloud_sync_outlined,
                title: 'Backend',
                value: 'Checking…',
                detail: 'Requesting the live service status.',
              ),
              error: (error, stackTrace) => _StatusCard(
                icon: Icons.cloud_off_outlined,
                title: 'Backend',
                value: 'Unavailable',
                detail: 'Could not reach ${AppConstants.apiBaseUrl}.',
                color: colors.error,
                action: TextButton(
                  onPressed: () => ref.invalidate(systemStatusProvider),
                  child: const Text('Retry'),
                ),
              ),
              data: (value) => _BackendStatusCard(status: value),
            ),
            const SizedBox(height: 10),
            status.when(
              loading: () => const _StatusCard(
                icon: Icons.person_outline_rounded,
                title: 'Login status',
                value: 'Checking…',
                detail: 'Waiting for the backend.',
              ),
              error: (error, stackTrace) => const _StatusCard(
                icon: Icons.person_outline_rounded,
                title: 'Login status',
                value: 'Unknown',
                detail: 'Reconnect to the backend to read authentication status.',
              ),
              data: (value) => _LoginStatusCard(status: value),
            ),
            const SizedBox(height: 10),
            status.when(
              loading: () => const _StatusCard(
                icon: Icons.key_outlined,
                title: 'OpenAI configuration',
                value: 'Checking…',
                detail: 'Waiting for the backend.',
              ),
              error: (error, stackTrace) => const _StatusCard(
                icon: Icons.key_outlined,
                title: 'OpenAI configuration',
                value: 'Unknown',
                detail: 'Reconnect to the backend to read configuration status.',
              ),
              data: (value) => _OpenAiStatusCard(status: value),
            ),
            const SizedBox(height: 24),
            Text(
              'CONNECTION',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    letterSpacing: 1.1,
                  ),
            ),
            const SizedBox(height: 10),
            _StatusCard(
              icon: Icons.link_rounded,
              title: 'API base URL',
              value: AppConstants.apiBaseUrl,
              detail: 'Override with --dart-define=API_BASE_URL=<url>.',
            ),
            const SizedBox(height: 20),
            OutlinedButton.icon(
              onPressed: () => ref.invalidate(systemStatusProvider),
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Refresh status'),
            ),
            const SizedBox(height: 8),
            Text(
              'OpenAI credentials stay on the server. The app only receives whether a key is configured.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: colors.onSurfaceVariant,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BackendStatusCard extends StatelessWidget {
  const _BackendStatusCard({required this.status});

  final SystemStatus status;

  @override
  Widget build(BuildContext context) {
    final online = status.backendOnline;
    final colors = Theme.of(context).colorScheme;

    return _StatusCard(
      icon: online ? Icons.cloud_done_outlined : Icons.cloud_off_outlined,
      title: 'Backend',
      value: online ? 'Online · v${status.backendVersion}' : 'Offline',
      detail: status.backendName,
      color: online ? colors.primary : colors.error,
    );
  }
}

class _LoginStatusCard extends StatelessWidget {
  const _LoginStatusCard({required this.status});

  final SystemStatus status;

  @override
  Widget build(BuildContext context) {
    final title = !status.authenticationEnabled
        ? 'Not connected'
        : status.authenticated
            ? 'Signed in'
            : 'Signed out';
    final detail = !status.authenticationEnabled
        ? 'Authentication is not enabled on this backend yet.'
        : status.authenticated
            ? 'An authenticated session is active.'
            : 'Sign in to access your account.';

    return _StatusCard(
      icon: status.authenticated
          ? Icons.person_rounded
          : Icons.person_outline_rounded,
      title: 'Login status',
      value: title,
      detail: detail,
    );
  }
}

class _OpenAiStatusCard extends StatelessWidget {
  const _OpenAiStatusCard({required this.status});

  final SystemStatus status;

  @override
  Widget build(BuildContext context) {
    return _StatusCard(
      icon: status.openAiConfigured ? Icons.key_rounded : Icons.key_off_rounded,
      title: 'OpenAI configuration',
      value: status.openAiConfigured ? 'Configured' : 'Not configured',
      detail: status.openAiConfigured
          ? 'OPENAI_API_KEY is present on the server.'
          : 'Set OPENAI_API_KEY on the server to enable AI features.',
    );
  }
}

class _StatusCard extends StatelessWidget {
  const _StatusCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.detail,
    this.color,
    this.action,
  });

  final IconData icon;
  final String title;
  final String value;
  final String detail;
  final Color? color;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color ?? colors.primary),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: Theme.of(context).textTheme.labelLarge),
                  const SizedBox(height: 4),
                  Text(value, style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 4),
                  Text(
                    detail,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: colors.onSurfaceVariant,
                        ),
                  ),
                ],
              ),
            ),
            if (action != null) action!,
          ],
        ),
      ),
    );
  }
}
