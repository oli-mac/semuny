import 'package:elegant_notification/elegant_notification.dart';
import 'package:elegant_notification/resources/arrays.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:semuny/screens/add_expense/blocs/create_catagory_bloc/create_catagory_bloc.dart';
import 'package:uuid/uuid.dart';

Future getCatagoryCreationView(BuildContext context) {
  List<String> categoriesIcons = [
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
  return showDialog(
      context: context,
      builder: (ctx) {
        bool isExpaned = false;
        String? selectedIcon;
        Color? catagoryColor = Colors.white;
        TextEditingController categoryNameController = TextEditingController();
        TextEditingController categoryIconController = TextEditingController();
        TextEditingController categoryColorController = TextEditingController();
        bool isLoading = false;
        Catagory catagory = Catagory.empty;
        return BlocProvider.value(
          value: context.read<CreateCatagoryBloc>(),
          child: StatefulBuilder(builder: (ctx, setState) {
            return BlocListener<CreateCatagoryBloc, CreateCatagoryState>(
              listener: (context, state) {
                // TODO: implement listener
                if (state is CreateCatagorySuccess) {
                  ElegantNotification.success(
                    width: 360,
                    position: Alignment.topCenter,
                    animation: AnimationType.fromRight,
                    title: const Text('Update'),
                    description:
                        const Text('Catagory has been Created Succesfully'),
                    // onDismiss: () {
                    //   print('Message when the notification is dismissed');
                    // },
                    // onTap: () {
                    //   print('Message when the notification is pressed');
                    // },
                    closeOnTap: true,
                  ).show(context);
                  Navigator.pop(ctx, catagory);
                } else if (state is CreateCatagoryLoading) {
                  setState(() {
                    isLoading = true;
                  });
                } else if (state is CreateCatagoryFailure) {
                  ElegantNotification.error(
                    width: 360,
                    position: Alignment.topCenter,
                    animation: AnimationType.fromRight,
                    title: const Text('Error'),
                    description: const Text('Failed to create Catagory'),
                    // onDismiss: () {
                    //   print('Message when the notification is dismissed');
                    // },
                    // onTap: () {
                    //   print('Message when the notification is pressed');
                    // },
                    closeOnTap: true,
                  ).show(context);
                }
              },
              child: AlertDialog(
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
                        controller: categoryNameController,
                        decoration: InputDecoration(
                          isDense: true,
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: Icon(
                            FontAwesomeIcons.signature,
                            color: Theme.of(context).colorScheme.outline,
                            size: 16,
                          ),
                          hintText: "Name",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: categoryIconController,
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
                            color: Theme.of(context).colorScheme.outline,
                            size: 16,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              FontAwesomeIcons.caretDown,
                              size: 16,
                            ),
                            color: Theme.of(context).colorScheme.outline,
                          ),
                          hintText: "Icon",
                          border: OutlineInputBorder(
                              borderRadius: isExpaned
                                  ? const BorderRadius.vertical(
                                      top: const Radius.circular(12),
                                    )
                                  : BorderRadius.circular(12),
                              borderSide: BorderSide.none),
                        ),
                      ),
                      isExpaned
                          ? Container(
                              width: MediaQuery.of(context).size.width,
                              height: 200,
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.vertical(
                                    bottom: Radius.circular(12),
                                  )),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GridView.builder(
                                  itemCount: categoriesIcons.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectedIcon = categoriesIcons[index];
                                        });
                                      },
                                      child: Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: selectedIcon ==
                                                      categoriesIcons[index]
                                                  ? Theme.of(context)
                                                      .colorScheme
                                                      .primary
                                                  : Theme.of(context)
                                                      .colorScheme
                                                      .outline,
                                              width: selectedIcon ==
                                                      categoriesIcons[index]
                                                  ? 3
                                                  : 1),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          image: DecorationImage(
                                            image: AssetImage(
                                              "assets/catagory/${categoriesIcons[index]}.png",
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
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
                              builder: (BuildContext ctx2) {
                                return AlertDialog(
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ColorPicker(
                                          pickerColor: catagoryColor!,
                                          onColorChanged: (color) {
                                            setState(
                                              () {
                                                catagoryColor = color;
                                              },
                                            );
                                            print("===================" +
                                                (color).toString());
                                          }),
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
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12)),
                                            ),
                                            onPressed: () {
                                              print("===================" +
                                                  (catagoryColor).toString());
                                              Navigator.pop(context);
                                            },
                                            child: const Text(
                                              "Select",
                                              style: TextStyle(
                                                color: Colors.white,
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
                        controller: categoryColorController,
                        decoration: InputDecoration(
                          isDense: true,
                          filled: true,
                          fillColor: catagoryColor ?? Colors.white,
                          prefixIcon: Icon(
                            FontAwesomeIcons.droplet,
                            color: Theme.of(context).colorScheme.outline,
                            size: 16,
                          ),
                          hintText: "Color",
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
                        child: isLoading == true
                            ? const Center(child: CircularProgressIndicator())
                            : TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor: Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(0.8),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                ),
                                onPressed: () {
                                  // Provider.of(context,
                                  //     listen: false);
                                  //! TODO write to the databse and close the dialog

                                  setState(() {
                                    catagory.catagoryId = const Uuid().v1();
                                    catagory.name =
                                        categoryNameController.text.toString();
                                    catagory.icon = selectedIcon!;
                                    catagory.color = catagoryColor!.value;
                                  });
                                  BlocProvider.of<CreateCatagoryBloc>(context)
                                      .add(CreateCategory(catagory: catagory));
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
              ),
            );
          }),
        );
      });
}
