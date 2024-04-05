import 'package:exam/screen/bill/bill_screen.dart';
import 'package:exam/screen/edit/edit_screen.dart';
import 'package:exam/screen/home/home_screen.dart';
import 'package:exam/screen/personal/personal_screen.dart';
import 'package:flutter/cupertino.dart';

Map<String, WidgetBuilder> screen = {
  '/': (context) => const HomeScreen(),
  'person':(context) => const PersonalScreen(),
  'edit': (context) => const EditScreen(),
  'bill': (context) => const BillScreen(),
};
