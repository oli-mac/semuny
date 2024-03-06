part of 'create_source_bloc.dart';


sealed class CreateSourceEvent extends Equatable {
  const CreateSourceEvent();

  @override
  List<Object> get props => [];

  get source => null;
}

class CreateSource extends CreateSourceEvent {
  final Sources sources;

  const CreateSource({required this.sources});

  @override
  List<Object> get props => [sources];
}