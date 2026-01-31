import 'package:serverpod/serverpod.dart';
import 'package:tencent_cos_dart/tencent_cos_dart.dart';

class CosPasswordKeys {
  final String secretId;
  final String secretKey;
  final String bucket;
  final String region;
  final String customDomain;

  const CosPasswordKeys({
    this.secretId = 'tencentCosSecretId',
    this.secretKey = 'tencentCosSecretKey',
    this.bucket = 'tencentCosBucket',
    this.region = 'tencentCosRegion',
    this.customDomain = 'tencentCosCustomDomain',
  });
}

extension CosSessionExtension on Session {
  CosConfig cosConfigFromPasswords({
    CosPasswordKeys keys = const CosPasswordKeys(),
  }) {
    return CosConfig(
      secretId: serverpod.getPassword(keys.secretId)!,
      secretKey: serverpod.getPassword(keys.secretKey)!,
      bucket: serverpod.getPassword(keys.bucket)!,
      region: serverpod.getPassword(keys.region)!,
      customDomain: serverpod.getPassword(keys.customDomain),
    );
  }

  CosSigner cosSigner({CosPasswordKeys keys = const CosPasswordKeys()}) {
    return CosSigner.fromConfig(cosConfigFromPasswords(keys: keys));
  }
}
