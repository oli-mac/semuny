import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  TextEditingController _expenseController = TextEditingController();
  TextEditingController _categoryController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  DateTime? _selectedDate = DateTime.now();

  List<String> _categoriesIcons = [
    "Food",
    "Shopping",
    "Health",
    "House",
    "Education",
    "Entertainment",
    "Technology",
    "wifi",
    "Trip",
  ];

  @override
  void initState() {
    // TODO: implement initState
    _dateController.text = DateFormat('dd/MM/yy').format(DateTime.now());
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
                    controller: _expenseController,
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
                  controller: _categoryController,
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
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              bool isExpaned = false;
                              String? _selectedIcon;
                              Color? catagoryColor = Colors.white;
                              return StatefulBuilder(
                                  builder: (context, setState) {
                                return AlertDialog(
                                  // title: Text("Add Catagory"),
                                  content: SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Text("Add Catagory"),
                                        const SizedBox(
                                          height: 16,
                                        ),
                                        TextFormField(
                                          // controller: _dateController,
                                          decoration: InputDecoration(
                                            isDense: true,
                                            filled: true,
                                            fillColor: Colors.white,
                                            prefixIcon: Icon(
                                              FontAwesomeIcons.signature,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .outline,
                                              size: 16,
                                            ),
                                            hintText: "Name",
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                borderSide: BorderSide.none),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 16,
                                        ),
                                        TextFormField(
                                          // controller: _dateController,
                                          onTap: () {
                                            setState(() {
                                              isExpaned = !isExpaned;
                                            });
                                          },
                                          readOnly: true,
                                          decoration: InputDecoration(
                                            isDense: true,
                                            filled: true,
                                            fillColor: Colors.white,
                                            prefixIcon: Icon(
                                              FontAwesomeIcons.icons,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .outline,
                                              size: 16,
                                            ),
                                            suffixIcon: IconButton(
                                              onPressed: () {},
                                              icon: const Icon(
                                                FontAwesomeIcons.caretDown,
                                                size: 16,
                                              ),
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .outline,
                                            ),
                                            hintText: "Icon",
                                            border: OutlineInputBorder(
                                                borderRadius: isExpaned
                                                    ? const BorderRadius
                                                        .vertical(
                                                        top: const Radius
                                                            .circular(12),
                                                      )
                                                    : BorderRadius.circular(12),
                                                borderSide: BorderSide.none),
                                          ),
                                        ),
                                        isExpaned
                                            ? Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: 200,
                                                decoration: const BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.vertical(
                                                      bottom:
                                                          Radius.circular(12),
                                                    )),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: GridView.builder(
                                                    itemCount:
                                                        _categoriesIcons.length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      return GestureDetector(
                                                        onTap: () {
                                                          setState(() {
                                                            _selectedIcon =
                                                                _categoriesIcons[
                                                                    index];
                                                          });
                                                        },
                                                        child: Container(
                                                          width: 50,
                                                          height: 50,
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                                color: _selectedIcon ==
                                                                        _categoriesIcons[
                                                                            index]
                                                                    ? Theme.of(
                                                                            context)
                                                                        .colorScheme
                                                                        .primary
                                                                    : Theme.of(
                                                                            context)
                                                                        .colorScheme
                                                                        .outline,
                                                                width: _selectedIcon ==
                                                                        _categoriesIcons[
                                                                            index]
                                                                    ? 3
                                                                    : 1),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12),
                                                            image:
                                                                DecorationImage(
                                                              image: AssetImage(
                                                                  "assets/${_categoriesIcons[index]}.png"),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    gridDelegate:
                                                        SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 3,
                                                      crossAxisSpacing: 8,
                                                      mainAxisSpacing: 8,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : const SizedBox(),
                                        const SizedBox(
                                          height: 16,
                                        ),
                                        TextFormField(
                                          onTap: () {
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    content: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        ColorPicker(
                                                            pickerColor:
                                                                catagoryColor!,
                                                            onColorChanged:
                                                                (color) {
                                                              setState(
                                                                () {
                                                                  catagoryColor =
                                                                      color;
                                                                },
                                                              );
                                                              print("===================" +
                                                                  (color)
                                                                      .toString());
                                                            }),
                                                        SizedBox(
                                                          width:
                                                              double.infinity,
                                                          height:
                                                              kToolbarHeight,
                                                          child: TextButton(
                                                              style: TextButton
                                                                  .styleFrom(
                                                                backgroundColor: Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .tertiary
                                                                    .withOpacity(
                                                                        0.8),
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            12)),
                                                              ),
                                                              onPressed: () {
                                                                print("===================" +
                                                                    (catagoryColor)
                                                                        .toString());
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: const Text(
                                                                "Select",
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 22,
                                                                ),
                                                              )),
                                                        )
                                                      ],
                                                    ),
                                                  );
                                                });
                                          },
                                          readOnly: true,

                                          // controller: _dateController,
                                          decoration: InputDecoration(
                                            isDense: true,
                                            filled: true,
                                            fillColor:
                                                catagoryColor ?? Colors.white,
                                            prefixIcon: Icon(
                                              FontAwesomeIcons.droplet,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .outline,
                                              size: 16,
                                            ),
                                            hintText: "Color",
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
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
                                                backgroundColor:
                                                    Theme.of(context)
                                                        .colorScheme
                                                        .primary
                                                        .withOpacity(0.8),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12)),
                                              ),
                                              onPressed: () {
                                                //! TODO write to the databse and close the dialog
                                                Navigator.pop(context);
                                              },
                                              child: const Text(
                                                "Add Catagory",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 22,
                                                ),
                                              )),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              });
                            });
                      },
                      icon: const Icon(
                        FontAwesomeIcons.plus,
                        size: 16,
                      ),
                      color: Theme.of(context).colorScheme.outline,
                    ),
                    hintText: "Catagory",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _dateController,
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
                      _dateController.text =
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
