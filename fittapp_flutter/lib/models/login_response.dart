class LoginResponse {
  LoginResponse({
    required this.nickname,
    required this.email,
    required this.avatar,
    required this.token,
    required this.role,
  });
  late final String nickname;
  late final String email;
  late final String avatar;
  late final String token;
  late final String role;

  LoginResponse.fromJson(Map<String, dynamic> json) {
    nickname = json['nickname'];
    email = json['email'];
    avatar = json['avatar'];
    token = json['token'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['nickname'] = nickname;
    _data['email'] = email;
    _data['avatar'] = avatar;
    _data['token'] = token;
    _data['role'] = role;
    return _data;
  }
}
