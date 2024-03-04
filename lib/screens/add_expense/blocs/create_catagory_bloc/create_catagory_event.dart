part of 'create_catagory_bloc.dart';

sealed class CreateCatagoryEvent extends Equatable {
  const CreateCatagoryEvent();

  @override
  List<Object> get props => [];

  get catagory => null;
}

class CreateCategory extends CreateCatagoryEvent {
  // final Category catagory;
  final Catagory catagory;

  const CreateCategory({required this.catagory});

  @override
  List<Object> get props => [catagory];
}
