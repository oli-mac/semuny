import 'package:expense_repository/expense_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:semuny/screens/home/bloc/get_expenses_bloc/get_expenses_bloc.dart';
import 'package:semuny/screens/home/views/home_screen.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "expence track",
      theme: ThemeData(
          colorScheme: ColorScheme.light(
              background: Colors.grey.shade100,
              onBackground: Colors.black,
              primary: const Color(0xFF00B2E7),
              secondary: const Color(0xFFE064F7),
              tertiary: const Color(0XFFFF8D6C),
              outline: Colors.grey.shade400)),
      home: BlocProvider(
        create: (context) => GetExpensesBloc(
          FirebaseExpenseRepo(),
        )..add(GetExpenses()),
        child: HomeScreen(),
      ),
    );
  }
}
