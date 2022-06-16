class ExerciseDto {
  ExerciseDto({
    required this.title,
    required this.duration,
    required this.link,
    required this.text,
    required this.zone,
  });
  late final String title;
  late final String duration;
  late final String link;
  late final String text;
  late final String zone;
  
  ExerciseDto.fromJson(Map<String, dynamic> json){
    title = json['title'];
    duration = json['duration'];
    link = json['link'];
    text = json['text'];
    zone = json['zone'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['title'] = title;
    _data['duration'] = duration;
    _data['link'] = link;
    _data['text'] = text;
    _data['zone'] = zone;
    return _data;
  }
}