import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:income_repository/income_repository.dart';

part 'get_incomes_event.dart';
part 'get_incomes_state.dart';

class GetIncomesBloc extends Bloc<GetIncomesEvent, GetIncomesState> {
  IncomeRepository incomeRepository;
  String userID;

  GetIncomesBloc(this.incomeRepository, this.userID)
      : super(GetIncomesInitial()) {
    on<GetIncomes>((event, emit) async {
      // TODO: implement event handler
      try {
        emit(GetIncomesLoading());
        List<Income> incomes = await incomeRepository.getIncomes(userID);
        emit(GetIncomesSuccess(incomes));
      } catch (e) {
        emit(GetIncomesFailure());
      }
    });
  }
}
