import 'package:flutter/material.dart';

Navigate({Widget Screen, BuildContext context}) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Screen),
  );
}
