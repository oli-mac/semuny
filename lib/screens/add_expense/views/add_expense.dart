import 'dart:math';

import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:semuny/app_view.dart';
import 'package:semuny/screens/add_expense/blocs/create_expense_bloc/create_expense_bloc.dart';
import 'package:semuny/screens/add_expense/blocs/get_categories_bloc/get_categories_bloc.dart';
import 'package:semuny/screens/add_expense/views/catagory_creation.dart';
import 'package:semuny/utils/notification_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  TextEditingController expenseController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  // DateTime? _selectedDate = DateTime.now();
  late Expense expense;
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    dateController.text = DateFormat('dd/MM/yy').format(DateTime.now());
    expense = Expense.empty;
    // expense.expenseId = Uuid().v1();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateExpenseBloc, CreateExpenseState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is CreateExpenseSuccess) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const MyAppView()),
          );
          NotificationService.showNotification(
                    title: "Expense Created",
                    body: "Expense of ${expense.amount}ETB has been created",
                    // icon: "assets/income.png",
                    color: Colors.blue,
                  );
        } else if (state is CreateExpenseLoading) {
          setState(() {
            isLoading = true;
          });
        } else if (state is CreateExpenseFailure) {
          NotificationService.showNotification(
                    title: "Expense Creation Failed",
                    body: "Expense of ${expense.amount}ETB has not been created",
                    // icon: "assets/income.png",
                    color: Colors.blue,
                  );
        }
      },
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.background,
            ),
            body: BlocBuilder<GetCategoriesBloc, GetCategoriesState>(
              builder: (context, state) {
                if (state is GetCategoriesSuccess) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Add Expense",
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onBackground)),
                        const SizedBox(
                          height: 16,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: TextFormField(
                            controller: expenseController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              prefixIcon: Icon(
                                FontAwesomeIcons.dollarSign,
                                color: Theme.of(context).colorScheme.outline,
                                size: 16,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide.none),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        TextFormField(
                          readOnly: true,
                          onTap: () {},
                          controller: categoryController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: expense.category == Catagory.empty
                                ? Colors.white
                                : Color(expense.category.color),
                            prefixIcon: expense.category == Catagory.empty
                                ? Icon(
                                    FontAwesomeIcons.listCheck,
                                    color:
                                        Theme.of(context).colorScheme.outline,
                                    size: 16,
                                  )
                                : Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(
                                      "assets/catagory/${expense.category.icon}.png",
                                      scale: 25,
                                    ),
                                  ),
                            suffixIcon: IconButton(
                              onPressed: () async {
                                var newCatagory =
                                    await getCatagoryCreationView(context);
                                print("------------------" +
                                    newCatagory +
                                    "------------------");
                                setState(() {
                                  state.categories.insert(0, newCatagory);
                                });
                              },
                              icon: const Icon(
                                FontAwesomeIcons.plus,
                                size: 16,
                              ),
                              color: Theme.of(context).colorScheme.outline,
                            ),
                            hintText: "Catagory",
                            border: const OutlineInputBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(12),
                                    bottom: Radius.circular(0)),
                                borderSide: BorderSide.none),
                          ),
                        ),
                        Container(
                            height: 200,
                            width: MediaQuery.of(context).size.width,
                            // color: Colors.red,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.vertical(
                                  bottom: Radius.circular(12)),
                            ),
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListView.builder(
                                  itemCount: state.categories.length,
                                  itemBuilder: (context, index) {
                                    return Card(
                                      child: ListTile(
                                          onTap: () {
                                            setState(() {
                                              expense.category =
                                                  state.categories[index];
                                              categoryController.text =
                                                  expense.category.name;
                                            });
                                          },
                                          leading: Image.asset(
                                            "assets/catagory/${state.categories[index].icon}.png",
                                            scale: 6,
                                          ),
                                          title: Text(
                                              "${state.categories[index].name}"),
                                          tileColor: Color(
                                              state.categories[index].color),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          )),
                                    );
                                  },
                                ))),
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          controller: dateController,
                          readOnly: true,
                          onTap: () async {
                            DateTime? newDate = await showDatePicker(
                                context: context,
                                initialDate: expense.date,
                                firstDate: DateTime.now(),
                                lastDate: DateTime.now().add(
                                  const Duration(
                                    days: 365,
                                  ),
                                ));

                            if (newDate != null) {
                              dateController.text =
                                  DateFormat('dd/MM/yyyy').format(newDate);
                              expense.date = newDate;
                            }
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: Icon(
                              FontAwesomeIcons.clock,
                              color: Theme.of(context).colorScheme.outline,
                              size: 16,
                            ),
                            hintText: "Date",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: kToolbarHeight,
                          child: isLoading
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: Theme.of(context)
                                        .colorScheme
                                        .tertiary
                                        .withOpacity(0.8),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                  ),
                                  onPressed: () async {
                                    final prefs =
                                        await SharedPreferences.getInstance();
                                    final userId = prefs.getString('userId');

                                    if (userId != null) {
                                      setState(() {
                                        expense.amount =
                                            int.parse(expenseController.text);
                                        expense.expenseId =
                                            userId; // Assuming your Expense model has a userId field

                                        BlocProvider.of<CreateExpenseBloc>(
                                                context)
                                            .add(CreateExpense(expense));
                                      });
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'User ID not found. Please log in again.')),
                                      );
                                    }
                                  },
                                  child: const Text(
                                    "Save",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                    ),
                                  )),
                        )
                      ],
                    ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            )),
      ),
    );
  }
}
