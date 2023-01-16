import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

void showLoadingMessage( BuildContext context ) {

  // Android
  if ( Platform.isAndroid ) {
    showDialog(
      context: context, 
      barrierDismissible: false,
      builder: ( context ) => ZoomIn(
        duration: const Duration(milliseconds: 500),
        child: AlertDialog(
          title: const Text('Espere por favor...', style: TextStyle(letterSpacing: 1, color: Colors.black)),
          content: Container(
            width: 100,
            height: 100,            
            margin: const EdgeInsets.only( top: 10),
            child: const SpinKitDualRing(
              size: 80,
              color:Color.fromARGB(255, 40, 87, 42),
            )
          ),
        ),
      )
    );
    return;
  }

  showCupertinoDialog(
    context: context, 
    builder: ( context ) => const CupertinoAlertDialog(
      title: Text('Espere por favor'),
      content: CupertinoActivityIndicator(),
    )
  );


}


