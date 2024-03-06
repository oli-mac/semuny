import 'dart:math';

import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:income_repository/income_repository.dart';
import 'package:intl/intl.dart';
import 'package:semuny/data/data.dart';
import 'package:semuny/screens/add_expense/blocs/create_catagory_bloc/create_catagory_bloc.dart';
import 'package:semuny/screens/add_expense/blocs/create_expense_bloc/create_expense_bloc.dart';
import 'package:semuny/screens/add_expense/blocs/get_categories_bloc/get_categories_bloc.dart';
import 'package:semuny/screens/add_expense/views/add_expense.dart';
import 'package:semuny/screens/add_income/blocs/create_income_bloc/create_income_bloc.dart';
import 'package:semuny/screens/add_income/blocs/create_source_bloc/create_source_bloc.dart';
import 'package:semuny/screens/add_income/blocs/get_sources_bloc/get_sources_bloc.dart';
import 'package:semuny/screens/add_income/views/add_income.dart';

class MainScreen extends StatefulWidget {
  final List<Expense> expenses;
  final double totalIncomes;

  // final List<Income> incomes;
  const MainScreen(this.expenses, this.totalIncomes, {super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  double calculateTotalExpenses(List<Expense> expenses) {
    double total = 0;
    for (var expense in expenses) {
      total += expense.amount;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    double totalBalance =
        widget.totalIncomes - calculateTotalExpenses(widget.expenses);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.yellow[700],
                          ),
                        ),
                        const Icon(CupertinoIcons.person)
                      ],
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome!",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).colorScheme.outline),
                        ),
                        Text(
                          "Olyad M",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color:
                                  Theme.of(context).colorScheme.onBackground),
                        )
                      ],
                    ),
                  ],
                ),
                IconButton(
                    onPressed: () async {
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
                                    CreateIncomeBloc(FirebaseIncomeRepo()),
                              ),
                            ],
                            child:
                                const AddIncome(), // Navigate to the AddIncome page
                          ),
                        ),
                      );
                    },
                    icon: const Icon(CupertinoIcons.info_circle)),
                // IconButton(
                //     onPressed: () async {
                //       showDialog(
                //           // barrierColor: Theme.of(context).colorScheme.outline,
                //           context: context,
                //           builder: (ctx2) {
                //             return AlertDialog(
                //                 backgroundColor: Colors.white,
                //                 content: SizedBox(
                //                   width: MediaQuery.of(context).size.width,
                //                   height: MediaQuery.of(context).size.width / 3,
                //                   child: Row(
                //                     mainAxisAlignment:
                //                         MainAxisAlignment.spaceAround,
                //                     crossAxisAlignment:
                //                         CrossAxisAlignment.center,
                //                     children: [
                //                       Material(
                //                         elevation:
                //                             5.0, // Adjust the elevation to control the shadow
                //                         shadowColor: Colors.grey.withOpacity(
                //                             0.5), // Customize the shadow color
                //                         borderRadius: BorderRadius.circular(
                //                             12), // Match the border radius of your container
                //                         child: InkWell(
                //                           onTap: () async {
                //                             await Navigator.push(
                //                               context,
                //                               MaterialPageRoute<Income>(
                //                                 builder:
                //                                     (BuildContext context) =>
                //                                         MultiBlocProvider(
                //                                   providers: [
                //                                     BlocProvider(
                //                                       create: (context) =>
                //                                           CreateSourceBloc(
                //                                               FirebaseIncomeRepo()),
                //                                     ),
                //                                     BlocProvider(
                //                                       create: (context) =>
                //                                           GetSourcesBloc(
                //                                               FirebaseIncomeRepo())
                //                                             ..add(GetSources()),
                //                                     ),
                //                                     BlocProvider(
                //                                       create: (context) =>
                //                                           CreateIncomeBloc(
                //                                               FirebaseIncomeRepo()),
                //                                     ),
                //                                   ],
                //                                   child:
                //                                       const AddIncome(), // Navigate to the AddIncome page
                //                                 ),
                //                               ),
                //                             );
                //                           },
                //                           child: Column(
                //                             children: [
                //                               Container(
                //                                 width: MediaQuery.of(context)
                //                                         .size
                //                                         .width /
                //                                     4,
                //                                 height: MediaQuery.of(context)
                //                                         .size
                //                                         .width /
                //                                     4,
                //                                 decoration: BoxDecoration(
                //                                   color: Colors.transparent,
                //                                   border: Border.all(
                //                                     width: 1,
                //                                     color: Colors.transparent,
                //                                   ),
                //                                   borderRadius:
                //                                       BorderRadius.circular(12),
                //                                 ),
                //                                 child: Image.asset(
                //                                   "assets/income.png",
                //                                   scale: 7,
                //                                   color: Colors.green,
                //                                 ),
                //                               ),
                //                               const SizedBox(
                //                                 height: 8,
                //                               ),
                //                               const Text(
                //                                 "Add Income",
                //                                 style: TextStyle(
                //                                   fontSize: 16,
                //                                   fontWeight: FontWeight.w600,
                //                                   color: Colors.green,
                //                                 ),
                //                               )
                //                             ],
                //                           ),
                //                         ),
                //                       ),
                //                       Material(
                //                         elevation:
                //                             5.0, // Adjust the elevation to control the shadow
                //                         shadowColor: Colors.grey.withOpacity(
                //                             0.5), // Customize the shadow color
                //                         borderRadius: BorderRadius.circular(
                //                             12), // Match the border radius of your container
                //                         child: Padding(
                //                           padding: const EdgeInsets.symmetric(
                //                               horizontal: 10.0, vertical: 1.0),
                //                           child: InkWell(
                //                             onTap: () async {
                //                               Expense? newExpense =
                //                                   await Navigator.push(
                //                                 context,
                //                                 MaterialPageRoute<Expense>(
                //                                   builder:
                //                                       (BuildContext context) =>
                //                                           MultiBlocProvider(
                //                                     providers: [
                //                                       BlocProvider(
                //                                         create: (context) =>
                //                                             CreateCatagoryBloc(
                //                                                 FirebaseExpenseRepo()),
                //                                       ),
                //                                       BlocProvider(
                //                                         create: (context) =>
                //                                             GetCategoriesBloc(
                //                                                 FirebaseExpenseRepo())
                //                                               ..add(
                //                                                   GetCategories()),
                //                                       ),
                //                                       BlocProvider(
                //                                         create: (context) =>
                //                                             CreateExpenseBloc(
                //                                                 FirebaseExpenseRepo()),
                //                                       ),
                //                                     ],
                //                                     child: AddExpense(),
                //                                   ),
                //                                 ),
                //                               );
                //                               if (newExpense != null) {
                //                                 // Assuming you have a way to add new expenses to the bloc
                //                                 // This might need to be adjusted based on your actual implementation
                //                               }
                //                             },
                //                             child: Column(
                //                               children: [
                //                                 Container(
                //                                   width: MediaQuery.of(context)
                //                                           .size
                //                                           .width /
                //                                       4,
                //                                   height: MediaQuery.of(context)
                //                                           .size
                //                                           .width /
                //                                       4,
                //                                   decoration: BoxDecoration(
                //                                     color: Colors.transparent,
                //                                     border: Border.all(
                //                                       color: Colors.transparent,
                //                                       width: 1,
                //                                     ),
                //                                     borderRadius:
                //                                         BorderRadius.circular(
                //                                             12),
                //                                   ),
                //                                   child: Image.asset(
                //                                     "assets/expense.png",
                //                                     scale: 7,
                //                                     color: Color.fromARGB(
                //                                         173, 158, 17, 17),
                //                                   ),
                //                                 ),
                //                                 const SizedBox(
                //                                   height: 8,
                //                                 ),
                //                                 const Text(
                //                                   "Add Expense",
                //                                   style: TextStyle(
                //                                     fontSize: 16,
                //                                     fontWeight: FontWeight.w600,
                //                                     color: Color.fromARGB(
                //                                         255, 158, 17, 17),
                //                                   ),
                //                                 )
                //                               ],
                //                             ),
                //                           ),
                //                         ),
                //                       )
                //                     ],
                //                   ),
                //                 ));
                //           });
                //     },
                //     icon: const Icon(CupertinoIcons.settings)),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width / 2,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Theme.of(context).colorScheme.tertiary,
                    Theme.of(context).colorScheme.secondary,
                    Theme.of(context).colorScheme.primary,
                  ], transform: const GradientRotation(pi / 4)),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 4,
                        color: Colors.grey.shade300,
                        offset: const Offset(5, 5))
                  ]),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Total Balance",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      '${totalBalance.toStringAsFixed(2)} ETB',
                      style: const TextStyle(
                          fontSize: 40,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 25,
                                height: 25,
                                decoration: const BoxDecoration(
                                    color: Colors.white30,
                                    shape: BoxShape.circle),
                                child: const Center(
                                    child: Icon(
                                  CupertinoIcons.arrow_down,
                                  size: 12,
                                  color: Colors.greenAccent,
                                )),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Income",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    '+${widget.totalIncomes.toStringAsFixed(2)} ETB',
                                    style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                width: 25,
                                height: 25,
                                decoration: const BoxDecoration(
                                    color: Colors.white30,
                                    shape: BoxShape.circle),
                                child: const Center(
                                    child: Icon(
                                  CupertinoIcons.arrow_down,
                                  size: 12,
                                  color: Colors.redAccent,
                                )),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Expenses",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    '-${calculateTotalExpenses(widget.expenses)} ETB',
                                    style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ]),
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Transaction',
                  style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.onBackground,
                      fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    'View All',
                    style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.outline,
                        fontWeight: FontWeight.w400),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: widget.expenses.length,
                  itemBuilder: (context, int i) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(children: [
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(
                                            widget.expenses[i].category.color),
                                      ),
                                      // child: const Icon(CupertinoIcons.person)
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.asset(
                                        "assets/catagory/${widget.expenses[i].category.icon}.png",
                                        scale: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                Text(widget.expenses[i].category.name,
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground,
                                        fontWeight: FontWeight.w600)),
                              ]),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    widget.expenses[i].amount.toString() +
                                        ".00 ETB",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .outline,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    DateFormat('dd/MM/yyyy')
                                        .format(widget.expenses[i].date),
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .outline,
                                        fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
