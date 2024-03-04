part of 'create_catagory_bloc.dart';

sealed class CreateCatagoryState extends Equatable {
  const CreateCatagoryState();

  @override
  List<Object> get props => [];
}

final class CreateCatagoryInitial extends CreateCatagoryState {}

final class CreateCatagoryLoading extends CreateCatagoryState {}

final class CreateCatagorySuccess extends CreateCatagoryState {}

final class CreateCatagoryFailure extends CreateCatagoryState {}
