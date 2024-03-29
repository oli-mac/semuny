import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:income_repository/income_repository.dart';

part 'create_income_events.dart';
part 'create_income_state.dart';

class CreateIncomeBloc extends Bloc<CreateIncomeEvent, CreateIncomeState> {
  IncomeRepository incomeRepository;
  String userID;

  CreateIncomeBloc(this.incomeRepository, this.userID)
      : super(CreateIncomeInitial()) {
    on<CreateIncome>((event, emit) async {
      emit(CreateIncomeLoading());
      try {
        await incomeRepository.createIncome(event.income, userID);
        emit(CreateIncomeSuccess());
      } catch (e) {
        print(e);
        emit(CreateIncomeFailure());
      }
    });
  }
}
