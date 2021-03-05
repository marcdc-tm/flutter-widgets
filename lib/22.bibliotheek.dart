library bibliotheek;

import 'dart:async';
import 'package:flutter/material.dart';

TextStyle kopTekst = TextStyle(
    color: Color(0xff4696ec),
    fontSize: 40,
    fontWeight: FontWeight.bold
);

StreamController<String> tekstStroom = StreamController<String>();

StreamController<bool> boolStroom = StreamController.broadcast();