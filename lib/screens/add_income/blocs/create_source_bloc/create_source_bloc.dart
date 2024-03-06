import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:income_repository/income_repository.dart';

part 'create_source_events.dart';
part 'create_source_state.dart';

class CreateSourceBloc extends Bloc<CreateSourceEvent, CreateSourceState> {
  final IncomeRepository incomeRepository;

  CreateSourceBloc(this.incomeRepository) : super(CreateSourcesInitial()) {
    on<CreateSourceEvent>((event, emit) async {
      emit(CreateSourcesLoading());
      try {
        await incomeRepository.createSources(event.source);
        print('------------------Source created----------------=' +
            event.source.toString());
        emit(CreateSourcesSuccess());
      } catch (e) {
        print('------------------Source created----------------=' +
            event.source.toString());
        print(e);
        emit(CreateSourcesFailure());
      }
    });
  }
}
