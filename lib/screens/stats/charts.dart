// ignore_for_file: prefer_const_constructors

//import 'dart:core';
//import 'dart:js';

import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MyChart extends StatefulWidget {
  const MyChart({super.key});

  @override
  State<MyChart> createState() => _MyChartState();
}

class _MyChartState extends State<MyChart> {
  @override
  Widget build(BuildContext context) {
    return BarChart(mainBarChart());
  }

  BarChartGroupData makeGroupData(int x, double y) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          gradient: LinearGradient(
            colors: const [
              Color(0xFF00B2E7),
              Color(0xFFE064F7),
              Color(0XFFFF8D6C),
            ],
            transform: GradientRotation(pi / 40),
          ),
          width: 20,
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 5,
            color: Colors.grey[300],
          ),
        )
      ],
    );
  }

  List<BarChartGroupData> showingGroups() => List.generate(8, (i) {
        switch (i) {
          case 0:
            return makeGroupData(0, 2);
          case 1:
            return makeGroupData(1, 3);
          case 2:
            return makeGroupData(2, 2.1);
          case 3:
            return makeGroupData(3, 4.5);
          case 4:
            return makeGroupData(4, 3.8);
          case 5:
            return makeGroupData(5, 1.5);
          case 6:
            return makeGroupData(6, 4);
          case 7:
            return makeGroupData(7, 3.8);
          default:
            return makeGroupData(0, 0);
        }
      });
  BarChartData mainBarChart() {
    return BarChartData(
      titlesData: const FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
            sideTitles: SideTitles(
                showTitles: true, reservedSize: 38, getTitlesWidget: getTiles)),
        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        leftTitles: AxisTitles(
            sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 38,
                getTitlesWidget: leftTiles)),
      ),
      borderData: FlBorderData(
        show: false,
        border: const Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 1,
          ),
          left: BorderSide(
            color: Colors.grey,
            width: 1,
          ),
        ),
      ),
      gridData: FlGridData(
        show: false,
        drawHorizontalLine: true,
        horizontalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Colors.grey,
            strokeWidth: 1,
          );
        },
      ),
      barGroups: showingGroups(),
    );
  }
}

Widget getTiles(double value, TitleMeta meta) {
  const style = TextStyle(
    color: Colors.grey,
    fontWeight: FontWeight.bold,
    fontSize: 14,
  );
  Widget text;

  switch (value.toInt()) {
    case 0:
      text = Text('00', style: style);
      break;
    case 1:
      text = Text('01', style: style);
      break;
    case 2:
      text = Text('02', style: style);
      break;
    case 3:
      text = Text('03', style: style);
      break;
    case 4:
      text = Text('04', style: style);
      break;
    case 5:
      text = Text('05', style: style);
      break;
    case 6:
      text = Text('06', style: style);
      break;
    // case 7:
    //   text = Text('07', style: style);
    //   break;
    // case 8:
    //   text = Text('08', style: style);
    //   break;
    // case 9:
    //   text = Text('09', style: style);
    //   break;
    // case 10:
    //   text = Text('10', style: style);
    //   break;
    default:
      text = const SizedBox();
  }
  return SideTitleWidget(
    child: text,
    axisSide: meta.axisSide,
    space: 16,
  );
}

Widget leftTiles(double value, TitleMeta meta) {
  const style = TextStyle(
    color: Colors.grey,
    fontWeight: FontWeight.bold,
    fontSize: 14,
  );
  String text;

  if (value.toInt() == 0) {
    text = '1K';
  } else if (value.toInt() == 1) {
    text = '2K';
  } else if (value.toInt() == 2) {
    text = '3K';
  } else if (value.toInt() == 3) {
    text = '4K';
  } else if (value.toInt() == 4) {
    text = '5K';
  } else if (value.toInt() == 5) {
    text = '6K';
  } else if (value.toInt() == 6) {
    text = '7K';
  } else {
    text = '';
  }

  return SideTitleWidget(
    child: Text(
      text,
      style: style,
    ),
    axisSide: meta.axisSide,
    space: 0,
  );
}
