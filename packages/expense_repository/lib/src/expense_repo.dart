import 'package:expense_repository/expense_repository.dart';

abstract class ExpenseRepository {
  Future<void> createCatagory(Catagory catagory);

  Future<List<Catagory>> getCatagories();
  Future<void> createExpense(Expense expense, String userId);

  Future<List<Expense>> getExpenses(String userId);
}
