import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:semuny/screens/add_expense/blocs/get_categories_bloc/get_categories_bloc.dart';
import 'package:semuny/screens/add_expense/views/catagory_creation.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  TextEditingController expenseController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  DateTime? _selectedDate = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    dateController.text = DateFormat('dd/MM/yy').format(DateTime.now());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.background,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Add Expense",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.onBackground)),
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
                    fillColor: Colors.white,
                    prefixIcon: Icon(
                      FontAwesomeIcons.listCheck,
                      color: Theme.of(context).colorScheme.outline,
                      size: 16,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        getCatagoryCreationView(context);
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
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(12)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: BlocBuilder<GetCategoriesBloc, GetCategoriesState>(
                        builder: (context, state) {
                          if (state is GetCategoriesSuccess) {
                            return ListView.builder(
                              itemCount: state.categories.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  child: ListTile(
                                      leading: Image.asset(
                                        "assets/${state.categories[index].icon}.png",
                                        scale: 6,
                                      ),
                                      title: Text(
                                          "${state.categories[index].name}"),
                                      // tileColor: Color(int.parse(
                                      //     state.categories[index].color)),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      )),
                                );
                              },
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                    )),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: dateController,
                  readOnly: true,
                  onTap: () async {
                    DateTime? newDate = await showDatePicker(
                        context: context,
                        initialDate: _selectedDate,
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(
                          const Duration(
                            days: 365,
                          ),
                        ));

                    if (newDate != null) {
                      dateController.text =
                          DateFormat('dd/MM/yyyy').format(newDate);
                      _selectedDate = newDate;
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
                  child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Theme.of(context)
                            .colorScheme
                            .tertiary
                            .withOpacity(0.8),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () {},
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
          )),
    );
  }
}
