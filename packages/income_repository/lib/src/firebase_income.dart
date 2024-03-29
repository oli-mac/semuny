import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:income_repository/income_repository.dart';

class FirebaseIncomeRepo implements IncomeRepository {
  final sourcesCollection = FirebaseFirestore.instance.collection('sourcess');
  final incomeCollection = FirebaseFirestore.instance.collection('incomes');

  @override
  Future<void> createSources(Sources sources) async {
    try {
      await sourcesCollection
          .doc(sources.sourcesId)
          .set(sources.toEntity().toDocument());
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }

  @override
  Future<List<Sources>> getSources() async {
    try {
      return await sourcesCollection.get().then((querySnapshot) => querySnapshot
          .docs
          .map((e) => Sources.fromEntity(SourcesEntity.fromDocument(e.data())))
          .toList());
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }

  @override
  Future<void> createIncome(Income income, String userId) async {
    try {
      await incomeCollection.add({
        ...income.toEntity().toDocument(),
        'userId': userId,
      });
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<Income>> getIncomes(String userId) async {
    try {
      // Get all documents where 'userId' equals the provided userId
      final querySnapshot =
          await incomeCollection.where('userId', isEqualTo: userId).get();

      // Map each document to an Income object
      return querySnapshot.docs
          .map(
              (doc) => Income.fromEntity(IncomeEntity.fromDocument(doc.data())))
          .toList();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  // @override
  // Future<List<Income>> getIncomes(String userId) async {
  //   try {
  //     return await incomeCollection
  //         .where('incomeId', isEqualTo: userId)
  //         .get()
  //         .then((value) => value.docs
  //             .map(
  //                 (e) => Income.fromEntity(IncomeEntity.fromDocument(e.data())))
  //             .toList());
  //   } catch (e) {
  //     log(e.toString());
  //     rethrow;
  //   }
  // }
}
