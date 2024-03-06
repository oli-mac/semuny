import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:income_repository/income_repository.dart';
import 'package:semuny/screens/add_income/blocs/create_source_bloc/create_source_bloc.dart';
import 'package:uuid/uuid.dart';

Future getSourceCreationView(BuildContext context) {
  List<String> sourceIcons = [
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
      Color? sourceColor = Colors.white;
      TextEditingController sourceNameController = TextEditingController();
      TextEditingController sourceIconController = TextEditingController();
      TextEditingController sourceColorController = TextEditingController();
      bool isLoading = false;
      Sources source = Sources.empty;
      return BlocProvider.value(
        value: context.read<CreateSourceBloc>(),
        child: StatefulBuilder(builder: (ctx, setState) {
          return BlocListener<CreateSourceBloc, CreateSourceState>(
            listener: (context, state) {
              if (state is CreateSourcesSuccess) {
                Navigator.pop(ctx, source);
              } else if (state is CreateSourcesLoading) {
                setState(() {
                  isLoading = true;
                });
              }
            },
            child: AlertDialog(
              content: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("Add Source"),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: sourceNameController,
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
                      controller: sourceIconController,
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
                                itemCount: sourceIcons.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedIcon = sourceIcons[index];
                                      });
                                    },
                                    child: Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: selectedIcon ==
                                                    sourceIcons[index]
                                                ? Theme.of(context)
                                                    .colorScheme
                                                    .primary
                                                : Theme.of(context)
                                                    .colorScheme
                                                    .outline,
                                            width: selectedIcon ==
                                                    sourceIcons[index]
                                                ? 3
                                                : 1),
                                        borderRadius: BorderRadius.circular(12),
                                        image: DecorationImage(
                                          image: AssetImage(
                                              "assets/${sourceIcons[index]}.png"),
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
                                        pickerColor: sourceColor!,
                                        onColorChanged: (color) {
                                          setState(
                                            () {
                                              sourceColor = color;
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
                                                    BorderRadius.circular(12)),
                                          ),
                                          onPressed: () {
                                            print("===================" +
                                                (sourceColor).toString());
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
                      controller: sourceColorController,
                      decoration: InputDecoration(
                        isDense: true,
                        filled: true,
                        fillColor: sourceColor ?? Colors.white,
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
                                setState(() {
                                  source.sourcesId = const Uuid().v1();
                                  source.name =
                                      sourceNameController.text.toString();
                                  source.icon = selectedIcon!;
                                  source.color = sourceColor!.value;
                                });
                                print("---------------------------"+source.icon+source.name+source.sourcesId+source.color.toString() + "---------------------------");
                                BlocProvider.of<CreateSourceBloc>(context)
                                    .add(CreateSource(sources: source));
                              },
                              child: const Text(
                                "Add Sources",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                ),
                              )),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      );
    },
  );
}
