import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:income_repository/income_repository.dart';
import 'package:semuny/screens/add_expense/blocs/create_catagory_bloc/create_catagory_bloc.dart';
import 'package:semuny/screens/add_expense/blocs/create_expense_bloc/create_expense_bloc.dart';
import 'package:semuny/screens/add_expense/blocs/get_categories_bloc/get_categories_bloc.dart';
import 'package:semuny/screens/add_expense/views/add_expense.dart';
import 'package:semuny/screens/add_income/blocs/create_income_bloc/create_income_bloc.dart';
import 'package:semuny/screens/add_income/blocs/create_source_bloc/create_source_bloc.dart';
import 'package:semuny/screens/add_income/blocs/get_sources_bloc/get_sources_bloc.dart';
import 'package:semuny/screens/add_income/views/add_income.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InfoCard extends StatelessWidget {
  Future<String> _getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId') ?? '';
    return userId;
  }

  final String title;
  final String body;
  final Function() onMoreTap;
  final Function() onAddIncomeTap;
  final Function() onAddExpeseTap;

  final String subInfoTitle;
  final String subInfoTextExpence;
  final String subInfoTextIncome;
  final Widget subIconIncome;
  final Widget subIconExpense;

  const InfoCard(
      {required this.title,
      this.body =
          """Lorem ipsum dolor sit amet consectetur adipisicing elit. Maxime mollitia, molestiae quas vel sint commodi repudi conseqr!""",
      required this.onMoreTap,
      required this.onAddExpeseTap,
      required this.onAddIncomeTap,
      this.subIconIncome = const CircleAvatar(
        backgroundColor: Color(0xFF00B2E7),
        radius: 25,
        child: Icon(
          Icons.directions,
          color: Colors.white,
        ),
      ),
      this.subIconExpense = const CircleAvatar(
        backgroundColor: Color(0xFF00B2E7),
        radius: 25,
        child: Icon(
          Icons.directions,
          color: Colors.white,
        ),
      ),
      this.subInfoTextIncome = "Add",
      this.subInfoTextExpence = "Add",
      this.subInfoTitle = "Directions",
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            offset: const Offset(0, 10),
            blurRadius: 0,
            spreadRadius: 0,
          )
        ],
        color: const Color.fromARGB(255, 241, 241, 241),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Center(
                child: ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context).colorScheme.secondary,
                      Theme.of(context).colorScheme.tertiary,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ).createShader(bounds),
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Container(
                width: 75,
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100.0),
                  gradient: const LinearGradient(
                      colors: [Colors.white, Colors.white],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter),
                ),
                child: GestureDetector(
                  onTap: onMoreTap,
                  child: const Center(
                      child: Text(
                    "More",
                    style: TextStyle(color: Colors.orange),
                  )),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            child: Text(
              body,
              style: const TextStyle(color: Colors.black45, fontSize: 14),
            ),
          ),

          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: GestureDetector(
              onTap: () async {
                final userId = await _getUserId();
                if (userId.isNotEmpty) {
                  await Navigator.push(
                    context,
                    MaterialPageRoute<Income>(
                      builder: (BuildContext context) => MultiBlocProvider(
                        providers: [
                          BlocProvider(
                            create: (context) =>
                                CreateSourceBloc(FirebaseIncomeRepo()),
                          ),
                          BlocProvider(
                            create: (context) =>
                                GetSourcesBloc(FirebaseIncomeRepo())
                                  ..add(GetSources()),
                          ),
                          BlocProvider(
                            create: (context) =>
                                CreateIncomeBloc(FirebaseIncomeRepo(), userId),
                          ),
                        ],
                        child: const AddIncome(),
                      ),
                    ),
                  );
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.green,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(25.0),
                  color: const Color.fromARGB(255, 255, 255, 255),
                ),
                width: double.infinity,
                height: 75,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      subIconIncome,
                      const SizedBox(width: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Text(subInfoTitle),
                          Text(
                            subInfoTextIncome,
                            style: const TextStyle(
                              color: Colors.green,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          //goto The page
          GestureDetector(
            onTap: () async {
              final userId = await _getUserId();
              if (userId.isNotEmpty) {
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
                              CreateExpenseBloc(FirebaseExpenseRepo(), userId),
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
              }
            },
            child: Container(
              width: double.infinity,
              height: 75,
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromARGB(173, 88, 17, 17),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(25.0),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    subIconExpense,
                    const SizedBox(width: 10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text(subInfoTitle),
                        Text(
                          subInfoTextExpence,
                          style: const TextStyle(
                            color: Color.fromARGB(173, 88, 17, 17),
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
