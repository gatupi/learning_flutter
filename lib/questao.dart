import 'package:flutter/material.dart';

class Questao extends StatelessWidget {
  final String texto;
  final bool isSelected;

  Questao(this.texto, {this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Text(this.texto,
        style: TextStyle(fontSize: 24, color: isSelected ? Colors.blueAccent : Colors.black));
  }
}
