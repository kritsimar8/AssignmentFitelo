import 'dart:async';
import 'dart:math';


import 'package:assignment_fitelo/DataProcessing.dart';

import 'package:assignment_fitelo/front.dart';


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]).then((_){
     runApp(const MyApp());
  });
 
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Flutter Demo', 
    debugShowCheckedModeBanner: false,
    home: Front());
  }
}








//  LayoutBuilder(
//                builder: (context, constraints){
//                final  _center = Offset(constraints.maxWidth/2, constraints.maxHeight/2);
//                  return GestureDetector(
//                    onPanStart: (details){
//                      _controller.stop();
//                      _baseAngle = _rotationAngle;
//                      _lastHapticAngle = _rotationAngle;
//                      final touchPosition = details.localPosition;
            
//                      final vector = touchPosition - _center; 
            
                   
//                      _startAngle = vector.direction;
            
//                    },
//                    onPanUpdate: (details) {
//                      final touchPosition = details.localPosition;
//                      final vector = touchPosition - _center;
//                      final currentAngle = vector.direction;
            
//                      final angleDelta = currentAngle - _startAngle;
//                      final newAngle = _baseAngle + angleDelta;
//                      setState(() {
//                        _rotationAngle = newAngle;
//                        print(_rotationAngle);
//                        _checkAndApplyHapticFeedback(newAngle);
//                      });
//                    },
//                    onPanEnd: (details) {
//                      final double velocity = details.velocity.pixelsPerSecond.dx * 0.006 + 
//                      details.velocity.pixelsPerSecond.dy * 0.006;
            
//                      final double targetAngle = _rotationAngle + (velocity*1);
            
//                      _animation = Tween<double>(
//                        begin: _rotationAngle, 
//                        end: targetAngle
//                      ).animate(
//                        CurvedAnimation(parent: _controller,
//                         curve: Curves.decelerate)
//                      );
//                      _controller.value = 0.0;
//                      _controller.duration = Duration(milliseconds: 1000+(velocity.abs()* 100).toInt());
//                      _controller.forward();
//                    },
//                    child: Transform.rotate(
//                      angle: _rotationAngle,
//                      child: Transform.scale(
//                        scaleX: 1.5,
//                        scaleY: 1.5,
//                        child: Container(
//                        height: 600,
//                        width: 600,
//                        decoration: BoxDecoration(
//                          shape: BoxShape.circle,
//                          gradient: LinearGradient(
//                            colors: [
//                              Colors.red,
//                              Colors.blue
//                            ])
//                        ),
//                        child: Center(
//                          child: Text('Hello',
//                          style: TextStyle(
//                            color: Colors.black,
//                            fontSize: 30
//                          ),
//                          ),
//                        ),      
                         
//                                  ),
//                      ),
//                    ),
//                  );
//                }),
        
        