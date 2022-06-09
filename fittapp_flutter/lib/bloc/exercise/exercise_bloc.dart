

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitapp_flutter/models/exercise/exercise_dto.dart';
import 'package:fitapp_flutter/repository/ExerciseRepository/exercise_repository.dart';
import 'package:image_picker/image_picker.dart';

part 'exercise_event.dart';
part 'exercise_state.dart';

class ImagePickBlocBloc extends Bloc<ImagePickBlocEvent, ImagePickBlocState> {
  final ExerciseRepository exerciseRepository;
  ImagePickBlocBloc(this.exerciseRepository) : super(ImagePickBlocInitial()) {
    on<SelectImageEvent>(_onSelectImage);
    on<SaveExerciseEvent>(_onSaveExercise);
  }

  void _onSelectImage(
      SelectImageEvent event, Emitter<ImagePickBlocState> emit) async {
    final ImagePicker _picker = ImagePicker();

    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: event.source,
      );
      if (pickedFile != null) {
        emit(ImageSelectedSuccessState(pickedFile));
      } else {
        emit(const ImageSelectedErrorState('Error in image selection'));
      }
    } catch (e) {
      emit(const ImageSelectedErrorState('Error in image selection'));
    }
  }

  void _onSaveExercise(
      SaveExerciseEvent event, Emitter<ImagePickBlocState> emit) async {
    emit(RegisterLoadingState());
    try {
      var exerciseResponse =
          exerciseRepository.exercise(event.exerciseDto, event.path);
      emit(SaveUserSuccessState());
      return;
    } catch (e) {
      emit(RegisterErrorState(e.toString()));
    }
  }
}


/**final ExerciseRepository exerciseRepository; */