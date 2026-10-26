import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_client.dart';
import '../data/repositories/api_version_repository.dart';
import '../domain/entities/api_version.dart';
import '../domain/repositories/version_repository.dart';

final versionRepositoryProvider = Provider<VersionRepository>((ref) {
  return ApiVersionRepository(ref.watch(apiClientProvider));
});

final apiVersionProvider = FutureProvider<ApiVersion>((ref) {
  return ref.watch(versionRepositoryProvider).fetchVersion();
});
