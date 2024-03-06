import 'package:income_repository/income_repository.dart';

class Income {
  String incomeId;
  Sources sources;
  DateTime date;
  int amount;

  Income({
    required this.incomeId,
    required this.sources,
    required this.date,
    required this.amount,
  });

  static final empty = Income(
    incomeId: '',
    sources: Sources.empty,
    date: DateTime.now(),
    amount: 0,
  );

  IncomeEntity toEntity() {
    return IncomeEntity(
      incomeId: incomeId,
      sources: sources,
      date: date,
      amount: amount,
    );
  }

  static Income fromEntity(IncomeEntity entity) {
    return Income(
      incomeId: entity.incomeId,
      sources: entity.sources,
      date: entity.date,
      amount: entity.amount,
    );
  }
}
