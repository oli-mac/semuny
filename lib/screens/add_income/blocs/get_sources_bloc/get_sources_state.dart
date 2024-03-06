part of 'get_sources_bloc.dart';

sealed class GetSourcesState extends Equatable {
 const GetSourcesState();

 @override
 List<Object> get props => [];
}

final class GetSourcesInitial extends GetSourcesState {}

final class GetSourcesFailure extends GetSourcesState {}
final class GetSourcesLoading extends GetSourcesState {}
final class GetSourcesSuccess extends GetSourcesState {
 final List<Sources> sources;

 const GetSourcesSuccess(this.sources);

 @override
 List<Object> get props => [sources];
}
