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
  Future<void> createExpense(Expense expense) async {
    try {
      await expenseCollection
        .doc(expense.expenseId)
        .set(expense.toEntity().toDocument());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<Expense>> getExpenses() async {
    try {
      return await expenseCollection
        .get()
        .then((value) => value.docs.map((e) => 
          Expense.fromEntity(ExpenseEntity.fromDocument(e.data()))
        ).toList());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
