class RegisterResponse {
  RegisterResponse({
    required this.id,
    required this.nickname,
    required this.fechaNacimiento,
    required this.email,
    required this.role,
    required this.password,
    required this.avatar,
    required this.listFavDiets,
    required this.listFavExercises,
  });
  late final String id;
  late final String nickname;
  late final String fechaNacimiento;
  late final String email;
  late final String role;
  late final String password;
  late final String avatar;
  late final List<dynamic> listFavDiets;
  late final List<dynamic> listFavExercises;

  RegisterResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nickname = json['nickname'];
    fechaNacimiento = json['fechaNacimiento'];
    email = json['email'];
    role = json['role'];
    password = json['password'];
    avatar = json['avatar'];
    listFavDiets = List.castFrom<dynamic, dynamic>(json['listFavDiets']);
    listFavExercises =
        List.castFrom<dynamic, dynamic>(json['listFavExercises']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['nickname'] = nickname;
    _data['fechaNacimiento'] = fechaNacimiento;
    _data['email'] = email;
    _data['role'] = role;
    _data['password'] = password;
    _data['avatar'] = avatar;
    _data['listFavDiets'] = listFavDiets;
    _data['listFavExercises'] = listFavExercises;
    return _data;
  }
}
