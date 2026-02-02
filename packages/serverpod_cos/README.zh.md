# serverpod_cos

[English](README.md)

Serverpod 的腾讯云 COS 辅助工具包（生成预签名 URL）。

## 功能
- 从 `passwords.yaml` 读取凭据，其他配置直接传入
- 使用 `session.cosSigner()` 轻松生成预签名 URL

```yaml
dependencies:
  serverpod_cos: ^0.1.5
```

## 配置

### passwords.yaml（仅凭据）

```yaml
shared:
  tencentCosSecretId: '<TENCENT_SECRET_ID>'
  tencentCosSecretKey: '<TENCENT_SECRET_KEY>'
```

### 代码（非敏感配置）

```dart
final signer = session.cosSigner(
  appConfig: CosAppConfig(
    bucket: 'my-bucket',
    region: 'ap-guangzhou',
    customDomain: 'https://my-cdn.example.com',
  ),
);
```

## 官方存储兼容

本包使用 **预签名 URL + 自定义端点**。
如需官方 `CloudStorage` API 兼容，请使用：

```yaml
dependencies:
  serverpod_cloud_storage_cos: ^0.1.5
```

## 使用方法

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

## API 参考

### CosAppConfig

非敏感配置：

```dart
CosAppConfig(
  bucket: 'my-bucket',           // 必填
  region: 'ap-guangzhou',        // 必填
  customDomain: 'https://cdn.example.com', // 可选
)
```

### CosPasswordKeys

自定义凭据键名：

```dart
CosPasswordKeys(
  secretId: 'mySecretIdKey',   // 默认: tencentCosSecretId
  secretKey: 'mySecretKeyKey', // 默认: tencentCosSecretKey
)
```

## 维护
- 版本：SemVer
- 反馈：issue / PR
