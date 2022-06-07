class ExerciseResponse {
  ExerciseResponse({
    required this.content,
    required this.pageable,
    required this.last,
    required this.totalPages,
    required this.totalElements,
    required this.size,
    required this.number,
    required this.sort,
    required this.first,
    required this.numberOfElements,
    required this.empty,
  });
  late final List<Exercise> content;
  late final Pageable pageable;
  late final bool last;
  late final int totalPages;
  late final int totalElements;
  late final int size;
  late final int number;
  late final Sort sort;
  late final bool first;
  late final int numberOfElements;
  late final bool empty;
  
  ExerciseResponse.fromJson(Map<String, dynamic> json){
    content = List.from(json['content']).map((e)=>Exercise.fromJson(e)).toList();
    pageable = Pageable.fromJson(json['pageable']);
    last = json['last'];
    totalPages = json['totalPages'];
    totalElements = json['totalElements'];
    size = json['size'];
    number = json['number'];
    sort = Sort.fromJson(json['sort']);
    first = json['first'];
    numberOfElements = json['numberOfElements'];
    empty = json['empty'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['content'] = content.map((e)=>e.toJson()).toList();
    _data['pageable'] = pageable.toJson();
    _data['last'] = last;
    _data['totalPages'] = totalPages;
    _data['totalElements'] = totalElements;
    _data['size'] = size;
    _data['number'] = number;
    _data['sort'] = sort.toJson();
    _data['first'] = first;
    _data['numberOfElements'] = numberOfElements;
    _data['empty'] = empty;
    return _data;
  }
}

class Exercise {
  Exercise({
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
  
  Exercise.fromJson(Map<String, dynamic> json){
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

class Pageable {
  Pageable({
    required this.sort,
    required this.offset,
    required this.pageNumber,
    required this.pageSize,
    required this.unpaged,
    required this.paged,
  });
  late final Sort sort;
  late final int offset;
  late final int pageNumber;
  late final int pageSize;
  late final bool unpaged;
  late final bool paged;
  
  Pageable.fromJson(Map<String, dynamic> json){
    sort = Sort.fromJson(json['sort']);
    offset = json['offset'];
    pageNumber = json['pageNumber'];
    pageSize = json['pageSize'];
    unpaged = json['unpaged'];
    paged = json['paged'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['sort'] = sort.toJson();
    _data['offset'] = offset;
    _data['pageNumber'] = pageNumber;
    _data['pageSize'] = pageSize;
    _data['unpaged'] = unpaged;
    _data['paged'] = paged;
    return _data;
  }
}

class Sort {
  Sort({
    required this.empty,
    required this.sorted,
    required this.unsorted,
  });
  late final bool empty;
  late final bool sorted;
  late final bool unsorted;
  
  Sort.fromJson(Map<String, dynamic> json){
    empty = json['empty'];
    sorted = json['sorted'];
    unsorted = json['unsorted'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['empty'] = empty;
    _data['sorted'] = sorted;
    _data['unsorted'] = unsorted;
    return _data;
  }
}


class UsuarioDTO {
  UsuarioDTO({
    required this.id,
    required this.nickname,
    required this.fechaNacimiento,
    required this.email,
    required this.role,
    required this.password,
    required this.avatar,
     this.listFavDiets,
     this.listFavExercises,
  });
  late final String id;
  late final String nickname;
  late final String fechaNacimiento;
  late final String email;
  late final String role;
  late final String password;
  late final String avatar;
  late final Null listFavDiets;
  late final Null listFavExercises;
  
  UsuarioDTO.fromJson(Map<String, dynamic> json){
    id = json['id'];
    nickname = json['nickname'];
    fechaNacimiento = json['fechaNacimiento'];
    email = json['email'];
    role = json['role'];
    password = json['password'];
    avatar = json['avatar'];
    listFavDiets = null;
    listFavExercises = null;
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
