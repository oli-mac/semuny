import 'package:expense_repository/expense_repository.dart';

abstract class ExpenseRepository {
  Future<void> createCatagory(Catagory catagory);

  Future<List<Catagory>> getCatagories();
  Future<void> createExpense(Expense expense);

  Future<List<Expense>> getExpenses();
}
