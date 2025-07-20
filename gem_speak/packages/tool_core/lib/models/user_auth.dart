class UserAuth {
  final String id;
  final String email;
  final String accessToken;
  final String refreshToken;
  final DateTime? createdAt;

  UserAuth({
    required this.id,
    required this.email,
    required this.accessToken,
    required this.refreshToken,
    this.createdAt,
  });

  factory UserAuth.fromJson(Map<String, dynamic> json) {
    return UserAuth(
      id: json['user']['id'] as String,
      email: json['user']['email'] as String,
      accessToken: json['access_token'] as String,
      refreshToken: json['refresh_token'] as String,
      createdAt:
          json['user']['created_at'] != null
              ? DateTime.parse(json['user']['created_at'] as String)
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': {'id': id, 'email': email, 'created_at': createdAt.toString()},
      'access_token': accessToken,
      'refresh_token': refreshToken,
    };
  }

  UserAuth copyWith({
    String? id,
    String? email,
    String? accessToken,
    String? refreshToken,
    DateTime? createdAt,
  }) {
    return UserAuth(
      id: id ?? this.id,
      email: email ?? this.email,
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
