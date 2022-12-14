

import 'package:flutter/material.dart';

Route pageTransitionSlide( Widget pagina ){
  return PageRouteBuilder( pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) => pagina,
    // transitionDuration: const Duration( seconds: 2 ),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final curvedAnimation = CurvedAnimation(parent: animation, curve: Curves.easeInOut);
      return SlideTransition(
        position: Tween<Offset>( begin: const Offset(0.5, 1.0), end: Offset.zero).animate( curvedAnimation ),
        child: child,
      );
    } ,
  );
}
Route pageTransitionScale( Widget pagina ){
  return PageRouteBuilder( pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) => pagina,
    // transitionDuration: const Duration( seconds: 2 ),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final curvedAnimation = CurvedAnimation(parent: animation, curve: Curves.easeInOut);
      return ScaleTransition(
        scale: Tween<double>(begin: 0.0, end: 1.0).animate(curvedAnimation),
        child: child,
      );
    } ,
  );
}
Route pageTransitionFade( Widget pagina ){
  return PageRouteBuilder( pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) => pagina,
    // transitionDuration: const Duration( seconds: 2 ),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final curvedAnimation = CurvedAnimation(parent: animation, curve: Curves.easeInOut);
      return FadeTransition(
        opacity: Tween<double>(begin: 0.0, end: 1.0).animate(curvedAnimation),
        child: child,
      );
    } ,
  );
}
Route pageTransitionCombined( Widget pagina ){
  return PageRouteBuilder( pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) => pagina,
    transitionDuration:  const Duration( milliseconds: 1000 ),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final curvedAnimation = CurvedAnimation(parent: animation, curve: Curves.fastOutSlowIn);
      return SlideTransition(
        position: Tween<Offset>( begin: const Offset(0.5, 1.0), end: Offset.zero).animate( curvedAnimation ),
        child: FadeTransition(
          opacity: Tween<double>(begin: 0.3, end: 1.0).animate(curvedAnimation),
          child: child,
        ),
      );
    } ,
  );
}