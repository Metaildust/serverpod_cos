# serverpod_cloud_storage_cos

[中文文档](README.zh.md)

Tencent COS adapter for Serverpod `CloudStorage`.

Compatible with Serverpod's official upload flow
(`createDirectFileUploadDescription` / `FileUploader`).

```yaml
dependencies:
  serverpod_cloud_storage_cos: ^0.1.5
```

## Configuration

### Recommended: Separate Sensitive and Non-sensitive Config

**passwords.yaml** (credentials only):

```yaml
shared:
  tencentCosSecretId: '<TENCENT_SECRET_ID>'
  tencentCosSecretKey: '<TENCENT_SECRET_KEY>'
```

**server.dart** (non-sensitive config passed directly):

```dart
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_cloud_storage_cos/serverpod_cloud_storage_cos.dart'
    as cos;

void run(List<String> args) async {
  final pod = Serverpod(args, Protocol(), Endpoints());

  pod.addCloudStorage(
    cos.CosCloudStorage(
      serverpod: pod,
      storageId: 'public',
      public: true,
      bucket: 'my-bucket',                    // Direct value
      region: 'ap-guangzhou',                 // Direct value
      customDomain: 'https://cdn.example.com', // Direct value (optional)
    ),
  );

  cos.registerCosCloudStorageEndpoint(pod);

  await pod.start();
}
```

### Legacy: All in passwords.yaml (still supported)

```yaml
shared:
  tencentCosSecretId: '<TENCENT_SECRET_ID>'
  tencentCosSecretKey: '<TENCENT_SECRET_KEY>'
  tencentCosBucket: '<COS_BUCKET_NAME>'
  tencentCosRegion: '<COS_REGION>'
  tencentCosCustomDomain: 'https://my-cdn.example.com' # optional
```

```dart
final cosBucket = pod.getPassword('tencentCosBucket')!;

pod.addCloudStorage(
  cos.CosCloudStorage(
    serverpod: pod,
    storageId: 'public',
    public: true,
    bucket: cosBucket,
    region: pod.getPassword('tencentCosRegion') ?? 'ap-guangzhou',
    customDomain: pod.getPassword('tencentCosCustomDomain'),
  ),
);
```

## Client usage

```dart
final desc = await client.myEndpoint.getUploadDescription('path/to/file.png');
if (desc != null) {
  final uploader = FileUploader(desc);
  await uploader.uploadByteData(byteData);
  await client.myEndpoint.verifyUpload('path/to/file.png');
}
```

## API Reference

### CosPasswordKeys

Customize credential keys:

```dart
CosCloudStorage(
  serverpod: pod,
  storageId: 'public',
  public: true,
  bucket: 'my-bucket',
  region: 'ap-guangzhou',
  passwordKeys: CosPasswordKeys(
    secretId: 'mySecretIdKey',   // Default: tencentCosSecretId
    secretKey: 'mySecretKeyKey', // Default: tencentCosSecretKey
  ),
)
```

## Notes
- Uses Serverpod `CloudStorage` API.
- Upload goes through a Serverpod upload endpoint, then to COS.

## Maintenance
- Versioning: SemVer
- Feedback: issue / PR

## Reference
- https://docs.serverpod.dev/concepts/file-uploads
