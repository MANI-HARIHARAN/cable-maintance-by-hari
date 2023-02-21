import 'package:flutter/material.dart';
import 'home.dart';

void main() {
  runApp(const cable());
}

// ignore: camel_case_types
class cable extends StatefulWidget {
  const cable({super.key});
  @override
  State<cable> createState() => _cablestate();
}

// ignore: camel_case_types
class _cablestate extends State<cable> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Homepage(),
    );
  }
}
