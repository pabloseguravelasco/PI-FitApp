part of 'diet_bloc.dart';

abstract class ImagePickBlocEvent extends Equatable {
  const ImagePickBlocEvent();

  @override
  List<Object> get props => [];
}

class SelectImageEvent extends ImagePickBlocEvent {
  final ImageSource source;

  const SelectImageEvent(this.source);

  @override
  List<Object> get props => [source];
}
class SaveDietEvent extends ImagePickBlocEvent{
  final DietDto dietDto;
  final String path;

  const SaveDietEvent(this.dietDto,this.path);

  @override
  List<Object> get props => [dietDto,path];
}