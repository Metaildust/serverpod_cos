# serverpod_cos

Tencent COS helper for Serverpod (passwords.yaml -> presigned URL).
给 Serverpod 服务端使用的 Tencent COS 辅助包：从 `passwords.yaml` 读取 COS 配置，并生成预签名 URL。

## Features / 功能
- Read COS config from `passwords.yaml`
- `session.cosSigner()` in one line
- Optional generic endpoint
- 从 `passwords.yaml` 读取 COS 配置
- 一行代码拿到 `CosSigner`：`session.cosSigner()`
- 提供通用的 Endpoint（可选）

```yaml
dependencies:
  serverpod_cos: ^0.1.0
```

## passwords.yaml / 配置

```yaml
shared:
  tencentCosSecretId: '<TENCENT_SECRET_ID>'
  tencentCosSecretKey: '<TENCENT_SECRET_KEY>'
  tencentCosBucket: '<COS_BUCKET_NAME>'
  tencentCosRegion: '<COS_REGION>'
  tencentCosCustomDomain: 'https://my-cdn.example.com' # optional / 可选
```

## Official storage compatibility / 官方内建存储

This package uses **presigned URLs + custom endpoints**.
For official `CloudStorage` API compatibility, use:
本包使用 **预签名 URL + 自定义端点**。
如需官方 `CloudStorage` 兼容，请使用：

```yaml
dependencies:
  serverpod_cloud_storage_cos: ^0.1.0
```

## Usage / 使用

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

## Custom password keys / 自定义 key 名

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

## Optional endpoint / 可选 Endpoint

```dart
class CosEndpoint extends ServerpodCosEndpoint {}
```

## Maintenance / 维护
- Optional/advanced package; no feature expansion planned.
- Versioning: SemVer
- Feedback: issue / PR (not guaranteed timely)
