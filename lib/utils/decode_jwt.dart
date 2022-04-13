import 'dart:convert';

Map<String, dynamic>? parseJwt(String? token) {
  if (token == null) return null;

  final parts = token.split('.');
  if (parts.length != 3) {
    throw Exception('invalid token');
  }

  final payload = _decodeBase64(parts[1]);
  final payloadMap = json.decode(payload);
  if (payloadMap is! Map<String, dynamic>) {
    throw Exception('invalid payload');
  }

  return payloadMap;
}

bool validToken(String? token, bool isLogin) {
  if (token == null || token.isEmpty || !isLogin) {
    return false;
  }

  try {
    Map<String, dynamic>? result = parseJwt(token);
    if (result is Map<String, dynamic>) {
      DateTime time = DateTime.now();
      if (result['exp'] < (time.millisecondsSinceEpoch / 1000)) {
        return false;
      }

      return true;
    }

    return false;
  } catch (e) {
    return false;
  }
}

String _decodeBase64(String str) {
  String output = str.replaceAll('-', '+').replaceAll('_', '/');

  switch (output.length % 4) {
    case 0:
      break;
    case 2:
      output += '==';
      break;
    case 3:
      output += '=';
      break;
    default:
      throw Exception('Illegal base64url string!"');
  }

  return utf8.decode(base64Url.decode(output));
}
