import 'package:flutter/material.dart';

class prescription_table {
  String Medicine;
  String Days;
  bool Morning;
  bool Afternoon;
  bool Evening;
  bool Night;

  prescription_table(
    {
    this.Medicine,
    this.Days,
    this.Morning,
    this.Afternoon,
    this.Evening,
    this.Night,
    }
  );
}

final List<String> precriptionColumns = [
  'Medicine Name',
  '     Days     ',
  'Morning',
  'Afternoon',
  'Evening',
  'Night'
];
