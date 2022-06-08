

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitapp_flutter/models/diet/diet_dto.dart';
import 'package:fitapp_flutter/repository/DietRepository/diet_repository.dart';

import 'package:image_picker/image_picker.dart';

part 'diet_event.dart';
part 'diet_state.dart';

class ImagePickBlocBloc extends Bloc<ImagePickBlocEvent, ImagePickBlocState> {
  final DietRepository dietRepository;
  ImagePickBlocBloc(this.dietRepository) : super(ImagePickBlocInitial()) {
    on<SelectImageEvent>(_onSelectImage);
    on<SaveDietEvent>(_onSaveDiet);
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

  void _onSaveDiet(
      SaveDietEvent event, Emitter<ImagePickBlocState> emit) async {
    emit(RegisterLoadingState());
    try {
      var dietResponse =
          dietRepository.diet(event.dietDto, event.path);
      emit(SaveUserSuccessState());
      return;
    } catch (e) {
      emit(RegisterErrorState(e.toString()));
    }
  }
}


/**final ExerciseRepository exerciseRepository; */