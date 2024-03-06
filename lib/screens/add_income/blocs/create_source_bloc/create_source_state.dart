part of 'create_source_bloc.dart';

sealed class CreateSourceState extends Equatable {
  const CreateSourceState();

  @override
  List<Object?> get props => [];
}

final class CreateSourcesInitial extends CreateSourceState {}

final class CreateSourcesLoading extends CreateSourceState {}

final class CreateSourcesSuccess extends CreateSourceState {}

final class CreateSourcesFailure extends CreateSourceState {}
