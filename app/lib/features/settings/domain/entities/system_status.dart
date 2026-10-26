class SystemStatus {
  const SystemStatus({
    required this.backendStatus,
    required this.backendName,
    required this.backendVersion,
    required this.authenticationEnabled,
    required this.authenticated,
    required this.openAiConfigured,
  });

  final String backendStatus;
  final String backendName;
  final String backendVersion;
  final bool authenticationEnabled;
  final bool authenticated;
  final bool openAiConfigured;

  bool get backendOnline => backendStatus == 'online';

  factory SystemStatus.fromJson(Map<String, dynamic> json) {
    final backend = json['backend'] as Map<String, dynamic>;
    final authentication = json['authentication'] as Map<String, dynamic>;
    final openAi = json['openai'] as Map<String, dynamic>;

    return SystemStatus(
      backendStatus: backend['status'] as String,
      backendName: backend['name'] as String,
      backendVersion: backend['version'] as String,
      authenticationEnabled: authentication['enabled'] as bool,
      authenticated: authentication['authenticated'] as bool,
      openAiConfigured: openAi['configured'] as bool,
    );
  }
}
