import '../entities/api_version.dart';

abstract interface class VersionRepository {
  Future<ApiVersion> fetchVersion();
}
