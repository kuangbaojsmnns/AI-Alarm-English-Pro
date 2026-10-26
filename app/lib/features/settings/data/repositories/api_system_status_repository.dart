import 'package:dio/dio.dart';

import '../../domain/entities/system_status.dart';
import '../../domain/repositories/system_status_repository.dart';

class ApiSystemStatusRepository implements SystemStatusRepository {
  const ApiSystemStatusRepository(this._dio);

  final Dio _dio;

  @override
  Future<SystemStatus> fetchStatus() async {
    final response = await _dio.get<Object?>('/status');
    final payload = response.data;

    if (payload is! Map<String, dynamic>) {
      throw const FormatException('Unexpected system status response.');
    }

    return SystemStatus.fromJson(payload);
  }
}
