import 'package:serverpod/serverpod.dart';

import 'session_cos_config_extension.dart';

class ServerpodCosEndpoint extends Endpoint {
  Future<String> createPresignedUrl(
    Session session, {
    required String method,
    required String objectKey,
    int expires = 1800,
    Map<String, String>? queryParams,
    Map<String, String>? headers,
  }) async {
    final signer = session.cosSigner();
    return signer.generatePresignedUrl(
      method,
      objectKey,
      expires: expires,
      queryParams: queryParams,
      headers: headers,
    );
  }
}
