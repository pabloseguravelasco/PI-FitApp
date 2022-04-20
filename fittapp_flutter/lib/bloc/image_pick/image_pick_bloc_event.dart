part of 'image_pick_bloc_bloc.dart';

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
class SaveUserEvent extends ImagePickBlocEvent{
  final RegisterDto registerDto;
  final String path;

  const SaveUserEvent(this.registerDto,this.path);

  @override
  List<Object> get props => [registerDto,path];
}