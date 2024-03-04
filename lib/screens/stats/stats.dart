import 'package:flutter/material.dart';
import 'package:semuny/screens/stats/charts.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: Column(children: [
        const Text(
          "Transactions",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          // color: Colors.red,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 20, 12, 12),
            child: const MyChart(),
          ),
        )
      ]),
    ));
  }
}
