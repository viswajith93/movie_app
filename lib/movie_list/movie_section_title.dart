import 'package:flutter/material.dart';

import '../common/constant.dart';

class MovieSectionTitle extends StatelessWidget {
  final String title;

  const MovieSectionTitle(this.title, {Key? key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.0, 16.0, 8.0, 0),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          title,
          style: TextStyle(
            fontSize: 20.0,
            color: primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
