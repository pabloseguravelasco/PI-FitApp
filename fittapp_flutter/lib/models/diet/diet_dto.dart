class DietDto {
  DietDto({
    required this.title,
    required this.ingredient,
    required this.calories,
  });
  late final String title;
  late final String ingredient;
  late final String calories;
  
  DietDto.fromJson(Map<String, dynamic> json){
    title = json['title'];
    ingredient = json['ingredient'];
    calories = json['calories'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['title'] = title;
    _data['ingredient'] = ingredient;
    _data['calories'] = calories;
    return _data;
  }
}