import 'package:income_repository/income_repository.dart';

abstract class IncomeRepository {
  Future<void> createSources(Sources sources);

  Future<List<Sources>> getSources();
  Future<void> createIncome(Income income);

  Future<List<Income>> getIncomes(String userId);
}
