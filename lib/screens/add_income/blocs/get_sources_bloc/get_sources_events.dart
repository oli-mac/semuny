part of 'get_sources_bloc.dart';

sealed class GetSourcesEvent extends Equatable {
 const GetSourcesEvent();

 @override
 List<Object> get props => [];
}

class GetSources extends GetSourcesEvent {}
