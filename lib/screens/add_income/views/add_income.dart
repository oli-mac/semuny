import 'dart:math';

import 'package:income_repository/income_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
                                      "assets/source/${income.sources.icon}.png",
                                      scale: 25,
                                    ),
                                  ),
                            suffixIcon: IconButton(
                              onPressed: () async {
                                var newSource =
                                    await getSourceCreationView(context);
                                print("------------------" +
                                    newSource +
                                    "------------------");
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
                        Container(
                            height: 200,
                            width: MediaQuery.of(context).size.width,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.vertical(
                                  bottom: Radius.circular(12)),
                            ),
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListView.builder(
                                  itemCount: state.sources.length,
                                  itemBuilder: (context, index) {
                                    return Card(
                                      child: ListTile(
                                          onTap: () {
                                            setState(() {
                                              income.sources =
                                                  state.sources[index];
                                              sourceController.text =
                                                  income.sources.name;
                                            });
                                          },
                                          leading: Image.asset(
                                            "assets/source/${state.sources[index].icon}.png",
                                            scale: 6,
                                          ),
                                          title: Text(
                                              "${state.sources[index].name}"),
                                          tileColor:
                                              Color(state.sources[index].color),
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
                                initialDate: income.date,
                                firstDate: DateTime.now(),
                                lastDate: DateTime.now().add(
                                  const Duration(
                                    days: 365,
                                  ),
                                ));

                            if (newDate != null) {
                              dateController.text =
                                  DateFormat('dd/MM/yyyy').format(newDate);
                              income.date = newDate;
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
                                  onPressed: () {
                                    setState(() {
                                      income.amount =
                                          int.parse(incomeController.text);

                                      BlocProvider.of<CreateIncomeBloc>(context)
                                          .add(CreateIncome(income));
                                    });
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
