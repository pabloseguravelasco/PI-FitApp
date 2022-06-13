part of 'diet_bloc.dart';

abstract class BlocDietEvent extends Equatable {
  const BlocDietEvent();

  @override
  List<Object> get props => [];
}

class FetchDiets extends BlocDietEvent {
  @override
  List<Object> get props => [];
}

class SelectImageDietEvent extends BlocDietEvent {
  final ImageSource source;

  const SelectImageDietEvent(this.source);

  @override
  List<Object> get props => [source];
}
class SaveDietEvent extends BlocDietEvent{
  final DietDto dietDto;
  final String path;

  const SaveDietEvent(this.dietDto,this.path);

  @override
  List<Object> get props => [dietDto,path];
}

class DeleteDietEvent extends BlocDietEvent{

  final int id;

  const DeleteDietEvent(this.id);

  

  @override
  List<Object> get props => [id];
}