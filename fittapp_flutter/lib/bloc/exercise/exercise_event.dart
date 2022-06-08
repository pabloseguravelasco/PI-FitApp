part of 'exercise_bloc.dart';

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
class SaveExerciseEvent extends ImagePickBlocEvent{
  final ExerciseDto exerciseDto;
  final String path;

  const SaveExerciseEvent(this.exerciseDto,this.path);

  @override
  List<Object> get props => [exerciseDto,path];
}