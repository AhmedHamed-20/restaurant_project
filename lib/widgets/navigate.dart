import 'package:flutter/material.dart';

Navigate({Widget Screen, BuildContext context}) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Screen),
  );
}

NavigateandReplace({Widget Screen, BuildContext context}) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => Screen),
  );
}
