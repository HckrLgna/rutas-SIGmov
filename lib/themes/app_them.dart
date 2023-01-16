

import 'package:flutter/material.dart';

class AppTheme{
  // static const Color primary = Color.fromARGB(255, 190, 211, 191);
  static const Color primary = Colors.black12;
// 

  static final ThemeData lightTheme = ThemeData.light().copyWith(
        //Color primario
        // primaryColor: Colors.indigo,        
        inputDecorationTheme: InputDecorationTheme(
          floatingLabelStyle: const TextStyle(color: Color.fromARGB(255, 35, 127, 202), fontSize: 18),
          contentPadding: const EdgeInsets.all(15.0),  
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent, width: 1.5),
            borderRadius: BorderRadius.circular(100.0) 
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent, width: 2.0),
            borderRadius: BorderRadius.circular(100.0) 
          ),
          border: OutlineInputBorder(                      
            borderRadius: BorderRadius.circular(100.0),
          ), 
        )
      );
}