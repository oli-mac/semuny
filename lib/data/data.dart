import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

List<Map<String, dynamic>> transactionsData = [
  {
    "icon": FaIcon(FontAwesomeIcons.burger, color: Colors.white),
    "color": Colors.yellow[700],
    "name": "Food",
    "totalAmount": '-1000 ETB',
    "date": "Today 10:00 AM",
  },
  {
    "icon": FaIcon(FontAwesomeIcons.bagShopping, color: Colors.white),
    "color": Colors.purple,
    "name": "shopping",
    "totalAmount": '-400 ETB',
    "date": "Today 10:00 AM",
  },
  {
    "icon": FaIcon(FontAwesomeIcons.heartCircleCheck, color: Colors.white),
    "color": Colors.green,
    "name": "Healt",
    "totalAmount": '-2400 ETB',
    "date": "Yesterday 10:00 AM",
  },
  {
    "icon": FaIcon(FontAwesomeIcons.plane, color: Colors.white),
    "color": Colors.blue,
    "name": "Travel",
    "totalAmount": '-2000 ETB',
    "date": "Today 10:00 AM",
  },
  {
    "icon": FaIcon(FontAwesomeIcons.house, color: Colors.white),
    "color": Colors.red[700],
    "name": "House",
    "totalAmount": '-2000 ETB',
    "date": "Yesterday 10:00 AM",
  },
];
