import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

void showLoadingMessage( BuildContext context ) {

  // Android
  if ( Platform.isAndroid ) {
    showDialog(
      context: context, 
      barrierDismissible: false,
      builder: ( context ) => AlertDialog(
        title: const Text('Espere por favor...'),
        content: Container(
          width: 100,
          height: 100,
          margin: const EdgeInsets.only( top: 10),
          child: const SpinKitWave(
            size: 50,
            color:Color.fromARGB(255, 190, 211, 191),
          )
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


