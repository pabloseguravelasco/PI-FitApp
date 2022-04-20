import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitapp_flutter/models/register_dto.dart';
import 'package:fitapp_flutter/repository/register_repository/register_repository.dart';
import 'package:image_picker/image_picker.dart';

part 'image_pick_bloc_event.dart';
part 'image_pick_bloc_state.dart';

class ImagePickBlocBloc extends Bloc<ImagePickBlocEvent, ImagePickBlocState> {
  final RegisterRepository registerRepository;
  ImagePickBlocBloc(this.registerRepository) : super(ImagePickBlocInitial()) {
    on<SelectImageEvent>(_onSelectImage);
    on<SaveUserEvent>(_onSaveUser);
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

  void _onSaveUser(
      SaveUserEvent event, Emitter<ImagePickBlocState> emit) async {
    emit(RegisterLoadingState());
    try {
      var registerResponse =
          registerRepository.register(event.registerDto, event.path);
      emit(SaveUserSuccessState());
      return;
    } catch (e) {
      emit(RegisterErrorState(e.toString()));
    }
  }
}
