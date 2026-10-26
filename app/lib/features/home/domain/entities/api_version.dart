class ApiVersion {
  const ApiVersion({
    required this.name,
    required this.version,
  });

  final String name;
  final String version;

  factory ApiVersion.fromJson(Map<String, dynamic> json) {
    return ApiVersion(
      name: json['name'] as String,
      version: json['version'] as String,
    );
  }
}
