class UsuarioDTO {
  UsuarioDTO({
    required this.id,
    required this.nickname,
    required this.email,
    required this.role,
    required this.password,
    required this.avatar,
    required this.listFavDiets,
    required this.listFavExercises,
  });
  late final String id;
  late final String nickname;
  late final String email;
  late final String role;
  late final String password;
  late final String avatar;
  late final List<ListFavDiets> listFavDiets;
  late final List<ListFavExercises> listFavExercises;
  
  UsuarioDTO.fromJson(Map<String, dynamic> json){
    id = json['id'];
    nickname = json['nickname'];
    email = json['email'];
    role = json['role'];
    password = json['password'];
    avatar = json['avatar'];
    listFavDiets = List.from(json['listFavDiets']).map((e)=>ListFavDiets.fromJson(e)).toList();
    listFavExercises = List.from(json['listFavExercises']).map((e)=>ListFavExercises.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['nickname'] = nickname;
    _data['email'] = email;
    _data['role'] = role;
    _data['password'] = password;
    _data['avatar'] = avatar;
    _data['listFavDiets'] = listFavDiets.map((e)=>e.toJson()).toList();
    _data['listFavExercises'] = listFavExercises.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class ListFavDiets {
  ListFavDiets({
    required this.id,
    required this.title,
    required this.ingredient,
    required this.calories,
    required this.imagen,
  });
  late final int id;
  late final String title;
  late final String ingredient;
  late final String calories;
  late final String imagen;
  
  ListFavDiets.fromJson(Map<String, dynamic> json){
    id = json['id'];
    title = json['title'];
    ingredient = json['ingredient'];
    calories = json['calories'];
    imagen = json['imagen'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['title'] = title;
    _data['ingredient'] = ingredient;
    _data['calories'] = calories;
    _data['imagen'] = imagen;
    return _data;
  }
}

class ListFavExercises {
  ListFavExercises({
    required this.id,
    required this.title,
    required this.text,
    required this.imagen,
    required this.duration,
    required this.link,
    required this.zone,
  });
  late final int id;
  late final String title;
  late final String text;
  late final String imagen;
  late final String duration;
  late final String link;
  late final String zone;
  
  ListFavExercises.fromJson(Map<String, dynamic> json){
    id = json['id'];
    title = json['title'];
    text = json['text'];
    imagen = json['imagen'];
    duration = json['duration'];
    link = json['link'];
    zone = json['zone'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['title'] = title;
    _data['text'] = text;
    _data['imagen'] = imagen;
    _data['duration'] = duration;
    _data['link'] = link;
    _data['zone'] = zone;
    return _data;
  }
}