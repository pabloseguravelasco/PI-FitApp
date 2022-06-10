part of 'exercise_bloc.dart';

abstract class ImagePickBlocState extends Equatable {
  const ImagePickBlocState();

  @override
  List<Object> get props => [];
}

class ImagePickBlocInitial extends ImagePickBlocState {}

class ExerciseLoadingState extends ImagePickBlocState {}

class SaveExerciseSuccessState extends ImagePickBlocState {}

class ExerciseErrorState extends ImagePickBlocState {
  final String message;

  const ExerciseErrorState(this.message);

  @override
  List<Object> get props => [message];
}

class ImageSelectedSuccessState extends ImagePickBlocState {
  final XFile pickedFile;

  const ImageSelectedSuccessState(this.pickedFile);

  @override
  List<Object> get props => [pickedFile];
}

class ImageSelectedErrorState extends ImagePickBlocState {
  final String message;

  const ImageSelectedErrorState(this.message);

  @override
  List<Object> get props => [message];
}
