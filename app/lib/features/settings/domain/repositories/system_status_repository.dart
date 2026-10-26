import '../entities/system_status.dart';

abstract interface class SystemStatusRepository {
  Future<SystemStatus> fetchStatus();
}
