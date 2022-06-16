
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitapp_flutter/models/exercise/exercise_dto.dart';
import 'package:fitapp_flutter/models/exercise/exercise_response.dart';
import 'package:fitapp_flutter/repository/ExerciseRepository/exercise_repository.dart';
import 'package:image_picker/image_picker.dart';

part 'exercise_event.dart';
part 'exercise_state.dart';

class BlocExerciseBloc extends Bloc<BlocExerciseEvent, BlocExerciseState>{

  final ExerciseRepository exerciseRepository;

  BlocExerciseBloc(this.exerciseRepository) :super(BlocExerciseInitial()){

    on<FetchExercises>(_exercisesFetched);
    on<SelectImageExerciseEvent>(_onSelectImageExercise);
    on<SaveExerciseEvent>(_saveExercise);
    on<EditExerciseEvent>(_editExercise);
    on<DeleteExerciseEvent>(_deleteExercise);


  }
    void _exercisesFetched(BlocExerciseEvent event, Emitter<BlocExerciseState> emit) async {
    try {
      final exercises = await exerciseRepository.fetchExercise();
      emit(BlocExerciseFetched(exercises));
      return;
    } on Exception catch (e) {
      emit(BlocExerciseFetchedError(e.toString()));
    }
  }

  void _saveExercise(SaveExerciseEvent event, Emitter<BlocExerciseState> emit) async {
    emit(NewExerciseLoadingState());
    try {
      final ExerciseResponse = await exerciseRepository.newExercise(event.exerciseDto, event.path);
      emit(NewExerciseSuccessState());
      return;
    }on Exception catch (e) {
      emit(NewExerciseErrorState(e.toString()));
      
    }
  }
  void _editExercise(EditExerciseEvent event, Emitter<BlocExerciseState> emit) async {
    emit(NewExerciseLoadingState());
    try {
      final ExerciseResponse = await exerciseRepository.editExercise(event.exerciseDto, event.path, event.id);
      emit(NewExerciseSuccessState());
      return;
    }on Exception catch (e) {
      emit(NewExerciseErrorState(e.toString()));
      
    }
  }

   void _deleteExercise(DeleteExerciseEvent event, Emitter<BlocExerciseState> emit) async {
    emit(NewExerciseLoadingState());
    try {
     exerciseRepository.deleteExercise(event.id);
      emit(NewExerciseSuccessState());
      return;
    }on Exception catch (e) {
      emit(NewExerciseErrorState(e.toString()));
      
    }
  }

  void _onSelectImageExercise(SelectImageExerciseEvent event, Emitter<BlocExerciseState> emit) async {
    final ImagePicker _picker = ImagePicker();
    try{
      final XFile? pickedFile = await _picker.pickImage(source: event.source);
      if (pickedFile != null) {
        emit(ImageSelectedExerciseSuccessState(pickedFile));
    } else {
      emit(const ImageSelectedExerciseErrorState('Failed to select image'));
    }
    }catch (e){
      emit(const ImageSelectedExerciseErrorState('Failed to select image'));
    }
}
}