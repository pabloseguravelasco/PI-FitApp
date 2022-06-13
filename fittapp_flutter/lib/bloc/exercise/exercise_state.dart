part of 'exercise_bloc.dart';

abstract class BlocExerciseState extends Equatable {
  const BlocExerciseState();

  @override
  List<Object> get props => [];
}

class BlocExerciseInitial extends BlocExerciseState {}

class BlocExerciseFetched extends BlocExerciseState {
  final List<Exercise> exercises;

  const BlocExerciseFetched(this.exercises);

  
  @override
  List<Object> get props => [exercises];
}

class BlocExerciseFetchedError extends BlocExerciseState {
  final String message;

  const BlocExerciseFetchedError(this.message);

  @override
  List<Object> get props => [message];
}


class NewExerciseSuccessState extends BlocExerciseState {}

class NewExerciseLoadingState extends BlocExerciseState{}

class NewExerciseErrorState extends BlocExerciseState {
  final String message;

  const NewExerciseErrorState(this.message);

  @override
  List<Object> get props => [message];
}

class EditExerciseLoadingState extends BlocExerciseState{
  
}

class ImageSelectedExerciseSuccessState extends BlocExerciseState {
  final XFile pickedFile;

  const ImageSelectedExerciseSuccessState(this.pickedFile);

  @override
  List<Object> get props => [pickedFile];
}

class ImageSelectedEditExerciseSuccessState extends BlocExerciseState {
  final XFile pickedFile;
  final int id;

  const ImageSelectedEditExerciseSuccessState(this.pickedFile, this.id);

  @override
  List<Object> get props => [pickedFile];
}

class ImageSelectedExerciseErrorState extends BlocExerciseState {
  final String message;

  const ImageSelectedExerciseErrorState(this.message);

  @override
  List<Object> get props => [message];
}
