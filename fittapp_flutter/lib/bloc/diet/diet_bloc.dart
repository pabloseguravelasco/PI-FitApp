
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitapp_flutter/models/diet/diet_dto.dart';
import 'package:fitapp_flutter/models/diet/diet_response.dart';
import 'package:fitapp_flutter/repository/DietRepository/diet_repository.dart';

import 'package:image_picker/image_picker.dart';

part 'diet_event.dart';
part 'diet_state.dart';

class BlocDietBloc extends Bloc<BlocDietEvent, BlocDietState>{

  final DietRepository dietRepository;

  BlocDietBloc(this.dietRepository) :super(BlocDietInitial()){

    on<FetchDiets>(_dietsFetched);
    on<SelectImageDietEvent>(_onSelectImageDiet);
    on<SaveDietEvent>(_saveDiet);
    on<DeleteDietEvent>(_deleteDiet);


  }
    void _dietsFetched(BlocDietEvent event, Emitter<BlocDietState> emit) async {
    try {
      final diets = await dietRepository.fetchDiet();
      emit(BlocDietFetched(diets));
      return;
    } on Exception catch (e) {
      emit(BlocDietFetchedError(e.toString()));
    }
  }

  void _saveDiet(SaveDietEvent event, Emitter<BlocDietState> emit) async {
    emit(NewDietLoadingState());
    try {
      final DietResponse = await dietRepository.newDiet(event.dietDto, event.path);
      emit(NewDietSuccessState());
      return;
    }on Exception catch (e) {
      emit(NewDietErrorState(e.toString()));
    }
  }

     void _deleteDiet(DeleteDietEvent event, Emitter<BlocDietState> emit) async {
    emit(NewDietLoadingState());
    try {
     dietRepository.deleteDiet(event.id);
      emit(NewDietSuccessState());
      return;
    }on Exception catch (e) {
      emit(NewDietErrorState(e.toString()));
      
    }
  }

  void _onSelectImageDiet(SelectImageDietEvent event, Emitter<BlocDietState> emit) async {
    final ImagePicker _picker = ImagePicker();
    try{
      final XFile? pickedFile = await _picker.pickImage(source: event.source);
      if (pickedFile != null) {
        emit(ImageSelectedDietSuccessState(pickedFile));
    } else {
      emit(const ImageSelectedDietErrorState('Failed to select image'));
    }
    }catch (e){
      emit(const ImageSelectedDietErrorState('Failed to select image'));
    }
}
}