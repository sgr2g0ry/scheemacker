import 'package:flutter/material.dart';
import 'package:scheemacker/ui/home.dart';

void main() {
  runApp(Scheemacker());
}

class Scheemacker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'scheemacker.fr',
      home: HomeUI(),
    );
  }
}
