import 'package:serverpod/serverpod.dart';
import 'package:serverpod_cos/serverpod_cos.dart';

class MyEndpoint extends Endpoint {
  Future<String> createUploadUrl(Session session, String objectKey) async {
    final signer = session.cosSigner();
    return signer.generatePresignedUrl('PUT', objectKey, expires: 3600);
  }
}

void main() {
  // This file is a usage example for server-side code.
}
