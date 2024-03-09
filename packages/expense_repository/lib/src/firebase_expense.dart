import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_repository/expense_repository.dart';

class FirebaseExpenseRepo implements ExpenseRepository {
  final catagoryCollection =
      FirebaseFirestore.instance.collection('catagories');
  final expenseCollection = FirebaseFirestore.instance.collection('expenses');

  @override
  Future<void> createCatagory(Catagory catagory) async {
    try {
      await catagoryCollection
          .doc(catagory.catagoryId)
          .set(catagory.toEntity().toDocument());
    } catch (e) {
      log(e.toString());

      throw Exception(e);
    }
  }

  @override
  Future<List<Catagory>> getCatagories() async {
    try {
      return await catagoryCollection.get().then((querySnapshot) =>
          querySnapshot.docs
              .map((e) =>
                  Catagory.fromEntity(CatagoryEntity.fromDocument(e.data())))
              .toList());
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }

  @override
  Future<void> createExpense(Expense expense, String userId) async {
    try {
      await expenseCollection.add({
        ...expense.toEntity().toDocument(),
        'userId': userId,
      });
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<Expense>> getExpenses(String userId) async {
    try {
      final querySnapshot =
          await expenseCollection.where('userId', isEqualTo: userId).get();

      return querySnapshot.docs
          .map((doc) =>
              Expense.fromEntity(ExpenseEntity.fromDocument(doc.data())))
          .toList();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
