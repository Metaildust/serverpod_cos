# serverpod_cos

[中文文档](README.zh.md)

Tencent COS helper for Serverpod (passwords.yaml -> presigned URL).

## Features
- Read COS config from `passwords.yaml`
- `session.cosSigner()` in one line
- Optional generic endpoint

```yaml
dependencies:
  serverpod_cos: ^0.1.4
```

## passwords.yaml

```yaml
shared:
  tencentCosSecretId: '<TENCENT_SECRET_ID>'
  tencentCosSecretKey: '<TENCENT_SECRET_KEY>'
  tencentCosBucket: '<COS_BUCKET_NAME>'
  tencentCosRegion: '<COS_REGION>'
  tencentCosCustomDomain: 'https://my-cdn.example.com' # optional
```

## Official storage compatibility

This package uses **presigned URLs + custom endpoints**.
For official `CloudStorage` API compatibility, use:

```yaml
dependencies:
  serverpod_cloud_storage_cos: ^0.1.0
```

## Usage

```dart
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_cos/serverpod_cos.dart';

class MyEndpoint extends Endpoint {
  Future<String> createUploadUrl(Session session, String objectKey) async {
    final signer = session.cosSigner();
    return signer.generatePresignedUrl(
      'PUT',
      objectKey,
      expires: 3600,
    );
  }
}
```

## Custom password keys

```dart
final signer = session.cosSigner(
  keys: const CosPasswordKeys(
    secretId: 'myCosSecretId',
    secretKey: 'myCosSecretKey',
    bucket: 'myCosBucket',
    region: 'myCosRegion',
    customDomain: 'myCosCustomDomain',
  ),
);
```

## Optional endpoint

```dart
class CosEndpoint extends ServerpodCosEndpoint {}
```

## Maintenance
- Optional/advanced package; no feature expansion planned.
- Versioning: SemVer
- Feedback: issue / PR (not guaranteed timely)
