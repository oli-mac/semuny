import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:semuny/screens/home/views/components/info_card.dart';

class SelectionScreen extends StatefulWidget {
  const SelectionScreen({super.key});

  @override
  State<SelectionScreen> createState() => _SelectionScreenState();
}

class _SelectionScreenState extends State<SelectionScreen> {
  // Define the onMoreTap function
  void onMoreTap() {
    // Handle the tap event here
    print("More button tapped");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.secondary,
                  Theme.of(context).colorScheme.tertiary,
                ],
                transform: const GradientRotation(pi / 8),
              ),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              color: Colors.black.withOpacity(0.1), // Adjust opacity as needed
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: InfoCard(
                    title:
                        "Track Your Fainance", // Provide a title for the InfoCard
                    subInfoTextExpence:
                        "Add Expense", // Provide a subtitle for the InfoCard
                    subInfoTextIncome:
                        "Add Income", // Provide a subtitle for the InfoCard
                    onMoreTap: onMoreTap,
                    onAddExpeseTap: () {},
                    onAddIncomeTap: () {},
                    subIconIncome: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Image.asset(
                        "assets/income.png",
                        scale: 12,
                        color: Colors.green,
                      ),
                    ),
                    subIconExpense: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Image.asset(
                        "assets/expense.png",
                        scale: 12,
                        color: Color.fromARGB(173, 158, 17, 17),
                      ),
                    ),
                    // Pass the onMoreTap function
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
