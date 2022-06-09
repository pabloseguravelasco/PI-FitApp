class RegisterDto {
  RegisterDto({
    required this.nombre,
    required this.nickname,
    required this.email,
    required this.password,
    required this.fechaNacimiento,
   
  });
  late final String nombre;
  late final String nickname;
  late final String email;
  late final String password;
  late final String fechaNacimiento;

  
  RegisterDto.fromJson(Map<String, dynamic> json){
    nombre = json['nombre'];
    nickname = json['nickname'];
    email = json['email'];
    password = json['password'];
    fechaNacimiento = json['fechaNacimiento'];

  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['nombre'] = nombre;
    _data['nick'] = nickname;
    _data['email'] = email;
    _data['password'] = password;
    _data['fechaNacimiento'] = fechaNacimiento;
    return _data;
  }
}