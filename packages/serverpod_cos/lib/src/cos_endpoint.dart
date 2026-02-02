import 'package:serverpod/serverpod.dart';

import 'session_cos_config_extension.dart';

/// Base endpoint for COS presigned URL generation.
///
/// Subclass this and override [appConfig] to use:
///
/// ```dart
/// class MyCosEndpoint extends ServerpodCosEndpoint {
///   @override
///   CosAppConfig get appConfig => CosAppConfig(
///     bucket: 'my-bucket',
///     region: 'ap-guangzhou',
///   );
/// }
/// ```
abstract class ServerpodCosEndpoint extends Endpoint {
  /// Override this to provide COS configuration.
  CosAppConfig get appConfig;

  /// Override this to customize password keys.
  CosPasswordKeys get passwordKeys => const CosPasswordKeys();

  Future<String> createPresignedUrl(
    Session session, {
    required String method,
    required String objectKey,
    int expires = 1800,
    Map<String, String>? queryParams,
    Map<String, String>? headers,
  }) async {
    final signer = session.cosSigner(
      appConfig: appConfig,
      passwordKeys: passwordKeys,
    );
    return signer.generatePresignedUrl(
      method,
      objectKey,
      expires: expires,
      queryParams: queryParams,
      headers: headers,
    );
  }
}
