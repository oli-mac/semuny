import 'dart:math';

import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:income_repository/income_repository.dart';
import 'package:intl/intl.dart';
import 'package:semuny/screens/add_income/blocs/create_income_bloc/create_income_bloc.dart';
import 'package:semuny/screens/add_income/blocs/get_sources_bloc/get_sources_bloc.dart';
import 'package:semuny/screens/add_income/views/source_creation.dart';
import 'package:uuid/uuid.dart';

class AddIncome extends StatefulWidget {
  const AddIncome({super.key});

  @override
  State<AddIncome> createState() => _AddIncomeState();
}

class _AddIncomeState extends State<AddIncome> {
  TextEditingController incomeController = TextEditingController();
  TextEditingController sourceController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  late Income income;
  bool isLoading = false;

  @override
  void initState() {
    dateController.text = DateFormat('dd/MM/yy').format(DateTime.now());
    income = Income.empty;
    income.incomeId = Uuid().v1();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateIncomeBloc, CreateIncomeState>(
      listener: (context, state) {
        if (state is CreateIncomeSuccess) {
          Navigator.pop(context, income);
        } else if (state is CreateIncomeLoading) {
          setState(() {
            isLoading = true;
          });
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
            body: BlocBuilder<GetSourcesBloc, GetSourcesState>(
              builder: (context, state) {
                if (state is GetSourcesSuccess) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Add Income",
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
                            controller: incomeController,
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
                          controller: sourceController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: income.sources == Sources.empty
                                ? Colors.white
                                : Color(income.sources.color),
                            prefixIcon: income.sources == Sources.empty
                                ? Icon(
                                    FontAwesomeIcons.listCheck,
                                    color:
                                        Theme.of(context).colorScheme.outline,
                                    size: 16,
                                  )
                                : Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(
                                      "assets/${income.sources.icon}.png",
                                      scale: 25,
                                    ),
                                  ),
                            suffixIcon: IconButton(
                              onPressed: () async {
                                var newSource =
                                    await getSourceCreationView(context);
                                setState(() {
                                  state.sources.insert(0, newSource);
                                });
                              },
                              icon: const Icon(
                                FontAwesomeIcons.plus,
                                size: 16,
                              ),
                              color: Theme.of(context).colorScheme.outline,
                            ),
                            hintText: "Source",
                            border: const OutlineInputBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(12),
                                    bottom: Radius.circular(0)),
                                borderSide: BorderSide.none),
                          ),
                        ),
                        // Add the rest of your UI elements here, similar to the expense view
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
