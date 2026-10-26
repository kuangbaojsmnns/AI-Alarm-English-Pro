import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_client.dart';
import '../data/repositories/api_system_status_repository.dart';
import '../domain/entities/system_status.dart';
import '../domain/repositories/system_status_repository.dart';

final systemStatusRepositoryProvider = Provider<SystemStatusRepository>((ref) {
  return ApiSystemStatusRepository(ref.watch(apiClientProvider));
});

final systemStatusProvider = FutureProvider<SystemStatus>((ref) {
  return ref.watch(systemStatusRepositoryProvider).fetchStatus();
});
