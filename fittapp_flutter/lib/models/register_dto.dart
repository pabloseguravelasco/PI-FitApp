class RegisterDto {
  RegisterDto({
    required this.nombre,
    required this.nickname,
    required this.email,
    required this.password,

   
  });
  late final String nombre;
  late final String nickname;
  late final String email;
  late final String password;
  

  
  RegisterDto.fromJson(Map<String, dynamic> json){
    nombre = json['nombre'];
    nickname = json['nickname'];
    email = json['email'];
    password = json['password'];
    

  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['nombre'] = nombre;
    _data['nick'] = nickname;
    _data['email'] = email;
    _data['password'] = password;
    return _data;
  }
}