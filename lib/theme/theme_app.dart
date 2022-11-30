
import 'package:flutter/material.dart';

class ThemeApp {

  static Color primary =  Colors.red.shade300;
  

  static final tema = ThemeData.dark().copyWith(

      primaryColor: primary,

      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: primary,
      )
  );

}