// ignore_for_file: file_names

import 'package:flutter/material.dart';

class WaitingCard extends StatelessWidget {
  const WaitingCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
            margin: const EdgeInsets.only(top: 10.0),
            child: const Text('Please Wait...', textAlign: TextAlign.center, style: TextStyle(fontSize: 14.0, fontWeight:FontWeight.w500))
        ),
      ],);
  }
}