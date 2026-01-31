# serverpod_cos

[English](README.md)

Serverpod 的腾讯云 COS 辅助工具包（从 passwords.yaml 读取配置 → 生成预签名 URL）。

## 功能
- 从 `passwords.yaml` 读取 COS 配置
- 一行代码调用 `session.cosSigner()`
- 可选的通用端点

```yaml
dependencies:
  serverpod_cos: ^0.1.0
```

## passwords.yaml 配置

```yaml
shared:
  tencentCosSecretId: '<TENCENT_SECRET_ID>'
  tencentCosSecretKey: '<TENCENT_SECRET_KEY>'
  tencentCosBucket: '<COS_BUCKET_NAME>'
  tencentCosRegion: '<COS_REGION>'
  tencentCosCustomDomain: 'https://my-cdn.example.com' # 可选
```

## 官方存储兼容

本包使用 **预签名 URL + 自定义端点**。
如需官方 `CloudStorage` API 兼容，请使用：

```yaml
dependencies:
  serverpod_cloud_storage_cos: ^0.1.0
```

## 使用方法

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

## 自定义密钥名称

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

## 可选端点

```dart
class CosEndpoint extends ServerpodCosEndpoint {}
```

## 维护
- 可选/高级包；不计划功能扩展
- 版本：SemVer
- 反馈：issue / PR（不保证及时响应）
