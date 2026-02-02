# serverpod_cos

[中文文档](README.zh.md)

Tencent COS helper for Serverpod (presigned URL generation).

## Features
- Read credentials from `passwords.yaml`, pass other config directly
- `session.cosSigner()` for easy presigned URL generation

```yaml
dependencies:
  serverpod_cos: ^0.1.5
```

## Configuration

### passwords.yaml (credentials only)

```yaml
shared:
  tencentCosSecretId: '<TENCENT_SECRET_ID>'
  tencentCosSecretKey: '<TENCENT_SECRET_KEY>'
```

### Code (non-sensitive config)

```dart
final signer = session.cosSigner(
  appConfig: CosAppConfig(
    bucket: 'my-bucket',
    region: 'ap-guangzhou',
    customDomain: 'https://my-cdn.example.com',
  ),
);
```

## Official storage compatibility

This package uses **presigned URLs + custom endpoints**.
For official `CloudStorage` API compatibility, use:

```yaml
dependencies:
  serverpod_cloud_storage_cos: ^0.1.5
```

## Usage

```dart
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_cos/serverpod_cos.dart';

class MyEndpoint extends Endpoint {
  Future<String> createUploadUrl(Session session, String objectKey) async {
    final signer = session.cosSigner(
      appConfig: CosAppConfig(
        bucket: 'my-bucket',
        region: 'ap-guangzhou',
      ),
    );
    return signer.generatePresignedUrl(
      'PUT',
      objectKey,
      expires: 3600,
    );
  }
}
```

## API Reference

### CosAppConfig

Non-sensitive configuration:

```dart
CosAppConfig(
  bucket: 'my-bucket',           // Required
  region: 'ap-guangzhou',        // Required
  customDomain: 'https://cdn.example.com', // Optional
)
```

### CosPasswordKeys

Customize credential keys:

```dart
CosPasswordKeys(
  secretId: 'mySecretIdKey',   // Default: tencentCosSecretId
  secretKey: 'mySecretKeyKey', // Default: tencentCosSecretKey
)
```

## Maintenance
- Versioning: SemVer
- Feedback: issue / PR
