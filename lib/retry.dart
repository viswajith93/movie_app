import 'dart:ui';

import 'package:flutter/material.dart';

class RetryWidget extends StatelessWidget {
  final Function _retryFunction;

  const RetryWidget(this._retryFunction);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            'Sorry! Unable to load the data.',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(
              2.0,
            ),
          ),
          ElevatedButton(
            onPressed: _retryFunction(),
            child: Text(
              'Retry',
              style: TextStyle(color: Colors.white),
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                Colors.pinkAccent,
              ),
            ),
          )
        ],
      ),
    );
  }
}
