import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:expense_repository/expense_repository.dart';

part 'create_catagory_event.dart';
part 'create_catagory_state.dart';

class CreateCatagoryBloc
    extends Bloc<CreateCatagoryEvent, CreateCatagoryState> {
  final ExpenseRepository expenseRepository;

  CreateCatagoryBloc(this.expenseRepository) : super(CreateCatagoryInitial()) {
    on<CreateCatagoryEvent>((event, emit) async {
      // TODO: implement event handler
      emit(CreateCatagoryLoading());
      try {
        await expenseRepository.createCatagory(event.catagory);
        emit(CreateCatagorySuccess());
      } catch (e) {
        emit(CreateCatagoryFailure());
      }
    });
  }
}
