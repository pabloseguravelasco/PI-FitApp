part of 'exercise_bloc.dart';

abstract class BlocExerciseEvent extends Equatable {
  const BlocExerciseEvent();

  @override
  List<Object> get props => [];
}

class FetchExercises extends BlocExerciseEvent {
  @override
  List<Object> get props => [];
}

class SelectImageExerciseEvent extends BlocExerciseEvent {
  final ImageSource source;

  const SelectImageExerciseEvent(this.source);

  @override
  List<Object> get props => [source];
}
class SaveExerciseEvent extends BlocExerciseEvent{
  final ExerciseDto exerciseDto;
  final String path;

  const SaveExerciseEvent(this.exerciseDto,this.path);

  @override
  List<Object> get props => [exerciseDto,path];
}

class EditExerciseEvent extends BlocExerciseEvent{
  final ExerciseDto exerciseDto;
  final String path;
  final int id;

  const EditExerciseEvent(this.exerciseDto,this.path,this.id);

  

  @override
  List<Object> get props => [exerciseDto,path];
}

class DeleteExerciseEvent extends BlocExerciseEvent{

  final int id;

  const DeleteExerciseEvent(this.id);

  

  @override
  List<Object> get props => [id];
}