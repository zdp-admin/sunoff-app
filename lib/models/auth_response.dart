class AuthResponse {
  String accessToken;
  String tokenType;
  String? expiresIn;

  AuthResponse({this.accessToken = '', this.tokenType = '', this.expiresIn});

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
        accessToken: json['access_token'] ?? '',
        tokenType: json['token_type'] ?? '',
        expiresIn: json['token_type'] ?? '');
  }
}
