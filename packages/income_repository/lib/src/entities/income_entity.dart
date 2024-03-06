import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:income_repository/src/entities/entities.dart';
import '../models/models.dart';

class IncomeEntity {
  String incomeId;
  Sources sources;
  DateTime date;
  int amount;

  IncomeEntity({
    required this.incomeId,
    required this.sources,
    required this.date,
    required this.amount,
  });

  Map<String, Object?> toDocument() {
    return {
      'incomeId': incomeId,
      'sources': sources.toEntity().toDocument(),
      'date': date,
      'amount': amount,
    };
  }

  static IncomeEntity fromDocument(Map<String, dynamic> doc) {
    return IncomeEntity(
      incomeId: doc['incomeId'],
      sources: Sources.fromEntity(SourcesEntity.fromDocument(doc['sources'])),
      date: (doc['date'] as Timestamp).toDate(),
      amount: doc['amount'],
    );
  }
}
