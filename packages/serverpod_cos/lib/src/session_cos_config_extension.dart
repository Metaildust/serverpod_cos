import 'package:serverpod/serverpod.dart';
import 'package:tencent_cos_dart/tencent_cos_dart.dart';

/// Keys for COS credentials in passwords.yaml.
class CosPasswordKeys {
  /// Key for Tencent Cloud Secret ID.
  final String secretId;

  /// Key for Tencent Cloud Secret Key.
  final String secretKey;

  const CosPasswordKeys({
    this.secretId = 'tencentCosSecretId',
    this.secretKey = 'tencentCosSecretKey',
  });
}

/// Non-sensitive COS configuration.
///
/// Pass these directly in code instead of putting in passwords.yaml.
class CosAppConfig {
  /// COS bucket name.
  final String bucket;

  /// COS region (e.g., 'ap-guangzhou').
  final String region;

  /// Optional custom domain for public URL generation.
  final String? customDomain;

  const CosAppConfig({
    required this.bucket,
    required this.region,
    this.customDomain,
  });
}

extension CosSessionExtension on Session {
  /// Creates COS config.
  ///
  /// Credentials from passwords.yaml, other config passed directly.
  ///
  /// ```dart
  /// final config = session.cosConfig(
  ///   appConfig: CosAppConfig(
  ///     bucket: 'my-bucket',
  ///     region: 'ap-guangzhou',
  ///     customDomain: 'https://cdn.example.com',
  ///   ),
  /// );
  /// ```
  CosConfig cosConfig({
    required CosAppConfig appConfig,
    CosPasswordKeys passwordKeys = const CosPasswordKeys(),
  }) {
    return CosConfig(
      secretId: serverpod.getPassword(passwordKeys.secretId)!,
      secretKey: serverpod.getPassword(passwordKeys.secretKey)!,
      bucket: appConfig.bucket,
      region: appConfig.region,
      customDomain: appConfig.customDomain,
    );
  }

  /// Creates a COS signer.
  ///
  /// ```dart
  /// final signer = session.cosSigner(
  ///   appConfig: CosAppConfig(
  ///     bucket: 'my-bucket',
  ///     region: 'ap-guangzhou',
  ///   ),
  /// );
  /// ```
  CosSigner cosSigner({
    required CosAppConfig appConfig,
    CosPasswordKeys passwordKeys = const CosPasswordKeys(),
  }) {
    return CosSigner.fromConfig(
      cosConfig(appConfig: appConfig, passwordKeys: passwordKeys),
    );
  }
}
