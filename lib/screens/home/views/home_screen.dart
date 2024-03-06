import 'dart:math';

import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:income_repository/income_repository.dart';
import 'package:semuny/screens/add_expense/blocs/create_catagory_bloc/create_catagory_bloc.dart';
import 'package:semuny/screens/add_expense/blocs/create_expense_bloc/create_expense_bloc.dart';
import 'package:semuny/screens/add_expense/blocs/get_categories_bloc/get_categories_bloc.dart';
import 'package:semuny/screens/add_income/blocs/create_income_bloc/create_income_bloc.dart';
import 'package:semuny/screens/add_income/blocs/create_source_bloc/create_source_bloc.dart';
import 'package:semuny/screens/add_income/blocs/get_sources_bloc/get_sources_bloc.dart';
import 'package:semuny/screens/add_income/views/add_income.dart';
import 'package:semuny/screens/home/bloc/get_expenses_bloc/get_expenses_bloc.dart';
import 'package:semuny/screens/home/bloc/get_incomes_bloc/get_incomes_bloc.dart'; // Import the GetIncomesBloc
import 'package:semuny/screens/add_expense/views/add_expense.dart';
import 'package:semuny/screens/home/views/main_screen.dart';
import 'package:semuny/screens/stats/stats.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  late Color selectedItemColor = Theme.of(context).colorScheme.primary;
  late Color? unselectedItemColor = Colors.grey[400];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
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
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          showDialog(
              // barrierColor: Theme.of(context).colorScheme.outline,
              context: context,
              builder: (ctx2) {
                return AlertDialog(
                    backgroundColor: Colors.white,
                    content: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width / 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Material(
                            elevation:
                                5.0, // Adjust the elevation to control the shadow
                            shadowColor: Colors.grey
                                .withOpacity(0.5), // Customize the shadow color
                            borderRadius: BorderRadius.circular(
                                12), // Match the border radius of your container
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: InkWell(
                                onTap: () async {
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute<Income>(
                                      builder: (BuildContext context) =>
                                          MultiBlocProvider(
                                        providers: [
                                          BlocProvider(
                                            create: (context) =>
                                                CreateSourceBloc(
                                                    FirebaseIncomeRepo()),
                                          ),
                                          BlocProvider(
                                            create: (context) => GetSourcesBloc(
                                                FirebaseIncomeRepo())
                                              ..add(GetSources()),
                                          ),
                                          BlocProvider(
                                            create: (context) =>
                                                CreateIncomeBloc(
                                                    FirebaseIncomeRepo()),
                                          ),
                                        ],
                                        child:
                                            const AddIncome(), // Navigate to the AddIncome page
                                      ),
                                    ),
                                  );
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      width:
                                          MediaQuery.of(context).size.width / 4,
                                      height:
                                          MediaQuery.of(context).size.width / 4,
                                      decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        border: Border.all(
                                          width: 1,
                                          color: Colors.transparent,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Image.asset(
                                        "assets/income.png",
                                        scale: 7,
                                        color: Colors.green,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    const Text(
                                      "Add Income",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.green,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Material(
                            elevation:
                                5.0, // Adjust the elevation to control the shadow
                            shadowColor: Colors.grey
                                .withOpacity(0.5), // Customize the shadow color
                            borderRadius: BorderRadius.circular(
                                12), // Match the border radius of your container
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 1.0),
                              child: InkWell(
                                onTap: () async {
                                  Expense? newExpense = await Navigator.push(
                                    context,
                                    MaterialPageRoute<Expense>(
                                      builder: (BuildContext context) =>
                                          MultiBlocProvider(
                                        providers: [
                                          BlocProvider(
                                            create: (context) =>
                                                CreateCatagoryBloc(
                                                    FirebaseExpenseRepo()),
                                          ),
                                          BlocProvider(
                                            create: (context) =>
                                                GetCategoriesBloc(
                                                    FirebaseExpenseRepo())
                                                  ..add(GetCategories()),
                                          ),
                                          BlocProvider(
                                            create: (context) =>
                                                CreateExpenseBloc(
                                                    FirebaseExpenseRepo()),
                                          ),
                                        ],
                                        child: AddExpense(),
                                      ),
                                    ),
                                  );
                                  if (newExpense != null) {
                                    // Assuming you have a way to add new expenses to the bloc
                                    // This might need to be adjusted based on your actual implementation
                                  }
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      width:
                                          MediaQuery.of(context).size.width / 4,
                                      height:
                                          MediaQuery.of(context).size.width / 4,
                                      decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        border: Border.all(
                                          color: Colors.transparent,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Image.asset(
                                        "assets/expense.png",
                                        scale: 7,
                                        color: Color.fromARGB(173, 158, 17, 17),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    const Text(
                                      "Add Expense",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Color.fromARGB(255, 158, 17, 17),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ));
              });
        },
        shape: const CircleBorder(),
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.tertiary,
                Theme.of(context).colorScheme.secondary,
                Theme.of(context).colorScheme.primary,
              ],
              transform: const GradientRotation(pi / 4),
            ),
          ),
          child: const Icon(
            CupertinoIcons.add,
            color: Colors.white,
          ),
        ),
      ),
      body: _selectedIndex == 0
          ? BlocBuilder<GetExpensesBloc, GetExpensesState>(
              builder: (context, expensesState) {
                if (expensesState is GetExpensesSuccess) {
                  // Calculate total incomes
                  double totalIncomes = 0.0;
                  if (BlocProvider.of<GetIncomesBloc>(context).state
                      is GetIncomesSuccess) {
                    totalIncomes = (BlocProvider.of<GetIncomesBloc>(context)
                            .state as GetIncomesSuccess)
                        .incomes
                        .fold(0, (sum, income) => sum + income.amount);
                  }
                  return MainScreen(expensesState.expenses, totalIncomes);
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            )
          : BlocBuilder<GetIncomesBloc, GetIncomesState>(
              builder: (context, incomesState) {
                if (incomesState is GetIncomesSuccess) {
                  return StatsScreen(incomesState.incomes);
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
    );
  }
}
