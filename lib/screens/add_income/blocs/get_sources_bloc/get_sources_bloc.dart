import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:income_repository/income_repository.dart';


part 'get_sources_events.dart';
part 'get_sources_state.dart';

class GetSourcesBloc extends Bloc<GetSourcesEvent, GetSourcesState> {
 IncomeRepository incomeRepository;

 GetSourcesBloc(this.incomeRepository) : super(GetSourcesInitial()) {
    on<GetSources>((event, emit) async {
      emit(GetSourcesLoading());
      try {
        List<Sources> sources = await incomeRepository.getSources();
        emit(GetSourcesSuccess(sources));
      } catch (e) {
        emit(GetSourcesFailure());
      }
    });
 }
}
