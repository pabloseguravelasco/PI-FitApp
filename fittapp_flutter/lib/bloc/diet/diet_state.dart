part of 'diet_bloc.dart';

abstract class BlocDietState extends Equatable {
  const BlocDietState();

  @override
  List<Object> get props => [];
}

class BlocDietInitial extends BlocDietState {}

class BlocDietFetched extends BlocDietState {
  final List<Diet> diets;

  const BlocDietFetched(this.diets);

  
  @override
  List<Object> get props => [diets];
}

class BlocDietFetchedError extends BlocDietState {
  final String message;

  const BlocDietFetchedError(this.message);

  @override
  List<Object> get props => [message];
}


class NewDietSuccessState extends BlocDietState {}

class NewDietLoadingState extends BlocDietState{}

class NewDietErrorState extends BlocDietState {
  final String message;

  const NewDietErrorState(this.message);

  @override
  List<Object> get props => [message];
}

class ImageSelectedDietSuccessState extends BlocDietState {
  final XFile pickedFile;

  const ImageSelectedDietSuccessState(this.pickedFile);

  @override
  List<Object> get props => [pickedFile];
}

class ImageSelectedDietErrorState extends BlocDietState {
  final String message;

  const ImageSelectedDietErrorState(this.message);

  @override
  List<Object> get props => [message];
}
