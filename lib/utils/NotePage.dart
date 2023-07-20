import 'package:flutter/material.dart';

final List<String> noteDescription = [];
final List<String> noteHeading = [];
TextEditingController noteHeadingController = new TextEditingController();
TextEditingController noteDescriptionController = new TextEditingController();
FocusNode textSecondFocusNode = new FocusNode();

int notesHeaderMaxLenth = 100;
int notesDescriptionMaxLines = 10;
int notesDescriptionMaxLenth = 100000;
String deletedNoteHeading = "";
String deletedNoteDescription = "";

List<Color> noteColor = [
  Colors.pink.shade50,
  Colors.green.shade50,
  Colors.blue.shade50,
  Colors.orange.shade50,
  Colors.indigo.shade50,
  Colors.red.shade50,
  Colors.yellow.shade50,
  Colors.brown.shade50,
  Colors.teal.shade50,
  Colors.purple.shade50,
];
List<Color> noteMarginColor = [
  Colors.pink,
  Colors.green,
  Colors.blue,
  Colors.orange,
  Colors.indigo,
  Colors.red,
  Colors.yellow,
  Colors.brown,
  Colors.teal,
  Colors.purple,
];
