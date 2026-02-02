## 0.1.5
- **Breaking**: Separate sensitive and non-sensitive configuration
  - Add `CosAppConfig` for non-sensitive config (required)
  - `CosPasswordKeys` now only contains credential keys (secretId, secretKey)
  - `cosSigner()` now requires `appConfig` parameter
- Removed `cosConfigFromPasswords()`, `cosSignerWithConfig()`, and `CosLegacyPasswordKeys`
- Only credentials should be in passwords.yaml

## 0.1.4
- Fix README: separate English and Chinese versions properly

## 0.1.3
- Switch README to English as default, Chinese as README.zh.md

## 0.1.2

- Update repository URL.

## 0.1.1

- Update README to bilingual (ZH/EN).

## 0.1.0

- Initial release: read COS config from Serverpod passwords and generate presigned URLs.
