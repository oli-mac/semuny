import 'dart:math';

import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:income_repository/income_repository.dart';
import 'package:semuny/screens/add_expense/blocs/create_catagory_bloc/create_catagory_bloc.dart';
import 'package:semuny/screens/add_expense/blocs/create_expense_bloc/create_expense_bloc.dart';
import 'package:semuny/screens/add_expense/blocs/get_categories_bloc/get_categories_bloc.dart';
import 'package:semuny/screens/add_expense/blocs/create_catagory_bloc/create_catagory_bloc.dart';
import 'package:semuny/screens/add_expense/blocs/get_categories_bloc/get_categories_bloc.dart';
import 'package:semuny/screens/add_income/blocs/create_income_bloc/create_income_bloc.dart';
import 'package:semuny/screens/add_income/blocs/create_source_bloc/create_source_bloc.dart';
import 'package:semuny/screens/add_income/blocs/get_sources_bloc/get_sources_bloc.dart';
// import 'package:semuny/screens/home/bloc/get_expenses_bloc/get_expenses_bloc.dart';

import 'package:semuny/screens/add_expense/views/add_expense.dart';
import 'package:semuny/screens/home/bloc/get_expenses_bloc/get_expenses_bloc.dart';
import 'package:semuny/screens/home/views/main_screen.dart';
import 'package:semuny/screens/stats/stats.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // var pages = const <Widget>[
  //   MainScreen(),
  //   StatsScreen(),
  // ];
  int _selectedIndex = 0;
  late Color selectedItemColor = Theme.of(context).colorScheme.primary;
  late Color? unselectedItemColor = Colors.grey[400];

  // @override
  // void initState() {
  //   selectedItemColor = Theme.of(context).colorScheme.primary;
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetExpensesBloc, GetExpensesState>(
      builder: (context, state) {
        if (state is GetExpensesSuccess) {
          return Scaffold(
              // appBar: AppBar(
              //   backgroundColor: Colors.white,
              //   elevation: 0,
              // ),
              bottomNavigationBar: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(30)),
                child: BottomNavigationBar(
                    onTap: (value) => setState(() => _selectedIndex = value),
                    showSelectedLabels: false,
                    showUnselectedLabels: false,
                    elevation: 3,
                    items: [
                      BottomNavigationBarItem(
                        icon: Icon(
                          CupertinoIcons.home,
                          color: _selectedIndex == 0
                              ? selectedItemColor
                              : unselectedItemColor,
                        ),
                        label: 'Home',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(
                          CupertinoIcons.graph_square_fill,
                          color: _selectedIndex == 1
                              ? selectedItemColor
                              : unselectedItemColor,
                        ),
                        label: 'Status',
                      ),
                    ]),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              floatingActionButton: FloatingActionButton(
                // shape: BoxShape.circle,
                onPressed: () async {
                  Expense? newExpense = await Navigator.push(
                      context,
                      MaterialPageRoute<Expense>(
                        builder: (BuildContext context) => MultiBlocProvider(
                          providers: [
                            BlocProvider(
                              create: (context) =>
                                  CreateCatagoryBloc(FirebaseExpenseRepo()),
                            ),
                            BlocProvider(
                              create: (context) =>
                                  GetCategoriesBloc(FirebaseExpenseRepo())
                                    ..add(GetCategories()),
                            ),
                            BlocProvider(
                              create: (context) =>
                                  CreateExpenseBloc(FirebaseExpenseRepo()),
                            ),
                          ],
                          child: AddExpense(),
                        ),
                      ));
                  if (newExpense != null) {
                    setState(() {
                      state.expenses.insert(0, newExpense);
                    });
                  }
                },
                shape: const CircleBorder(),
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(colors: [
                        Theme.of(context).colorScheme.tertiary,
                        Theme.of(context).colorScheme.secondary,
                        Theme.of(context).colorScheme.primary,
                      ], transform: const GradientRotation(pi / 4))),
                  child: const Icon(
                    CupertinoIcons.add,
                    color: Colors.white,
                  ),
                ),
              ),
              body: _selectedIndex == 0
                  ? MainScreen(
                      state.expenses,
                    )
                  : const StatsScreen());
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
