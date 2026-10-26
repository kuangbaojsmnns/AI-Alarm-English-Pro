import 'package:dio/dio.dart';

import '../../domain/entities/api_version.dart';
import '../../domain/repositories/version_repository.dart';

class ApiVersionRepository implements VersionRepository {
  const ApiVersionRepository(this._dio);

  final Dio _dio;

  @override
  Future<ApiVersion> fetchVersion() async {
    final response = await _dio.get<Object?>('/version');
    final payload = response.data;

    if (payload is! Map<String, dynamic>) {
      throw const FormatException('Unexpected API version response.');
    }

    return ApiVersion.fromJson(payload);
  }
}
