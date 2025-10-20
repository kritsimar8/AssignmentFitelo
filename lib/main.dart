import 'dart:async';
import 'dart:math';

import 'package:assignment_fitelo/Calorie.dart';
import 'package:assignment_fitelo/DataProcessing.dart';
import 'package:assignment_fitelo/extra.dart';
import 'package:assignment_fitelo/homePage.dart';
import 'package:assignment_fitelo/timeline.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Flutter Demo', 
    home: HomePage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  // double _lastHapticAngle = 0.0;

  // static const double _hapticIncrement = 15 * (pi/180);

  double _normalizeAngle(double angle) {
    return angle % (2 * pi);
  }

  double _rotationAngle = 0.0;
  double _startAngle = 0.0;

  double _baseAngle = 0.0;
  double _width = 0;
  // Offset _center = Offset.zero;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    _controller.addListener(() {
      setState(() {
        _rotationAngle = _animation.value;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose

    _controller.dispose();
    super.dispose();
  }

  // void _checkAndApplyHapticFeedback(double newAngle){
  //   final angleDifference = newAngle - _lastHapticAngle;

  //   if (angleDifference.abs() >= _hapticIncrement){
  //     int steps = (angleDifference / _hapticIncrement).round();
  //     HapticFeedback.lightImpact();

  //     _lastHapticAngle += steps * _hapticIncrement;
  //   }
  // }
 
  @override
  Widget build(BuildContext context) {
    
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 50, bottom: 0),
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: 20),
              Column(
                children: [
                  Text(
                    'Your weight loss goal',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: const Color.fromARGB(158, 0, 0, 0),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '7kg',
                    style: GoogleFonts.inter(
                      fontSize: 35,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}

class RotationDemo extends StatefulWidget {

  final VoidCallback onNext;

  const RotationDemo({
    Key? key, 
    required this. onNext,
  }) : super(key:key);


  @override
  _RotationDemoState createState() => _RotationDemoState();
}

class _RotationDemoState extends State<RotationDemo>
    with SingleTickerProviderStateMixin {
  double _rotation = 0.0;
  double _previousRotation = 0.0;
  Offset? _center;

  Dataprocessing _data = Dataprocessing();
  



  late AnimationController _controller;
  double _velocity = 0.0;
  final double _scale = 0;
  Timer? _timer;

  final _hapticInterval = 1;

  int _lastHapticDegree = 0;
  double _width = 0;

  double defaultWeight =10;
  double prevAngle=0;
  double currentAngle= 0;   
  double MyWeight=10; 

double getCurrentDigit(double angle) {
  
  double adjustedAngle = angle + 1.5;
  
  
  double offset = -adjustedAngle / 9.0;
  

  double fullReading = 10.0 + offset;
  
 
  fullReading = ((fullReading % 40.0) + 40.0) % 40.0;
  
 
  double roundedReading = (fullReading * 2.0).roundToDouble() / 2.0;
  print(roundedReading);
  setState(() {
    MyWeight = roundedReading;
  });
  return roundedReading;
}
  @override
  void initState() {
    super.initState();
   
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..addListener(() {
      setState(() {
        _rotation += _velocity * (1 - _controller.value);
        _velocity *= 0.98; // Damping
      });
    });
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _width = 23;
      });
    });
  }

 

  @override
  void dispose() {
    _controller.dispose();
   
    super.dispose();
  }

  void _onPanStart(DragStartDetails details) {
    _controller.stop();
    _previousRotation = _rotation;
    int currentDegree = (_rotation * 180 / pi).round();
    _lastHapticDegree = (currentDegree / _hapticInterval).floor();
  }

  void _onPanUpdate(DragUpdateDetails details) {
    if (_center == null) return;

    final adjustedPosition = Offset(
      details.localPosition.dx / _scale,
      details.localPosition.dy / _scale,
    );


    // Calculate angle from center to touch point
    final offset = details.localPosition - _center!;
    final angle = atan2(offset.dy, offset.dx);

    // Calculate previous angle
    final prevOffset = details.localPosition - details.delta - _center!;
    final prevAngle = atan2(prevOffset.dy, prevOffset.dx);

    // Calculate delta rotation
    double delta = angle - prevAngle;

    // Handle wrap around
    if (delta > pi) delta -= 2 * pi;
    if (delta < -pi) delta += 2 * pi;

    getCurrentDigit(_rotation * 180 / pi);

    
    setState(() {
      _rotation += delta;
      _velocity = delta; // Store for momentum
      int currentDegree = (_rotation * 180 / pi).round();
      int currentStep = (currentDegree / _hapticInterval).floor();
      if (currentStep != _lastHapticDegree) {
        HapticFeedback.selectionClick();
        _lastHapticDegree = currentStep;
      }
    });
  }

  

  void _onPanEnd(DragEndDetails details) {
    // Add momentum/inertia effect
    if (_velocity.abs() > 0.01) {
      _controller.forward(from: 0);
    }
  }
  int opt=0;

  @override
  Widget build(BuildContext context) {
    
    // print('${(_rotation * 180 / pi).toStringAsFixed(1)}°');
     double ScreenWidth = MediaQuery.of(context).size.width;
     double height = MediaQuery.of(context).size.height;
     ScreenWidth <400? opt=0:ScreenWidth>=420 && ScreenWidth<450? opt=3 : ScreenWidth>450?opt=4 :opt=1; 

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 251, 251),

      body: Stack(
        children: [
          Align(
            // alignment: Alignment.bottomCenter,
            child: Column(
              children: [
                SizedBox(
                  height:opt==4?height*.51 :height*.51,
                ),
                Container(
                  // margin: EdgeInsets.only(top:opt==4?MediaQuery.of(context).size.height/2 :MediaQuery.of(context).size.height/2.1),
                  height:opt==4?440 :opt==0? 380 : 410,
                  width:opt==4?440 :opt==0? 380 : 410,
                  child: GestureDetector(
                    onPanStart: _onPanStart,
                    onPanUpdate: _onPanUpdate,
                    onPanEnd: _onPanEnd,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        // Calculate center for rotation calculations
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          if (_center == null) {
                            setState(() {
                              _center = Offset(150, 150); // Half of container size
                            });
                          }
                        });
                
                        return Transform.scale(
                          scale:1.5,
                          child: Transform.rotate(
                            angle: _rotation,
                            child: Container(
                              width: 400,
                              height: 400,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  colors: [Colors.white, Colors.white],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                
                                // borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.center,
                                      child: Container(
                                        // margin: EdgeInsets.only(top: 40),
                                        // constraints: BoxConstraints.expand(),
                                        height:opt==4?440 :opt==0? 380 : 410,
                                        width: opt==4?440 :opt==0? 380 : 410,
                                        child: CustomPaint(painter: ClockPainter()),
                                      ),
                                    ),
                                    Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.rotate_right,
                                            size: 80,
                                            color: Colors.white,
                                          ),
                                          SizedBox(height: 20),
                                          Text(
                                            'Drag to Rotate',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            '${(_rotation * 180 / pi).toStringAsFixed(1)}°',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          ClipPath(
            clipper: CustomClipPath(),
            child: Container(
              padding: EdgeInsets.only(top: 60),
              height: MediaQuery.of(context).size.height/2.1,
              width: 500,
              color: const Color.fromARGB(0, 161, 41, 41),
              child: Stack(
                
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: CustomPaint(
                      painter: MyTopBox(option: opt),
                      child: Container(
                        height: 200,
                        width: ScreenWidth,
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AnimatedContainer(
                            duration: Duration(milliseconds: 800),
                            height: 8,
                            width: _width,
                            decoration: BoxDecoration(
                              // shape: BoxShape.circle,
                              borderRadius: BorderRadius.circular(30),
                              color: const Color.fromARGB(255, 230, 152, 6),
                            ),
                          ),
                          SizedBox(width: 8),
                          Container(
                            height: 8,
                            width: 8,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: const Color.fromARGB(99, 158, 158, 158),
                            ),
                          ),
                          SizedBox(width: 8),
                          Container(
                            height: 8,
                            width: 8,
                          
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color.fromARGB(99, 158, 158, 158),
                            ),
                          ),
                          SizedBox(width: 8),
                          Container(
                            height: 8,
                            width: 8,
                          
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color.fromARGB(99, 158, 158, 158),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 40),
                      Text(
                        'Based on your height and weight, \nhere a goal 🎯 crafted just for you. Ready to \nstart your journey?',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.bold,
                          wordSpacing: 2,
                          fontSize: 14,
                          color: const Color.fromARGB(185, 0, 0, 0),
                        ),
                      ),
                      SizedBox(height: 50),
                      Text(
                        'Your weight loss goal',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: const Color.fromARGB(158, 0, 0, 0),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '$MyWeight kg',
                        style: GoogleFonts.inter(
                          fontSize: 35,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
         
       Align(
        alignment: Alignment.bottomCenter,
         child: Transform.scale(
          scale: opt==3? 1.85 : 1.62, 
          // opt==0 ? 1.66: opt==4? 1.8:1.7,
           child: Container(
            margin: EdgeInsets.only(top: 30),
            height: 300,
            width: 300,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                width: 8,
                color: const Color.fromARGB(255, 216, 213, 213)
              ),
               color: const Color.fromARGB(255, 255, 250, 250),
            ),
            
           ),
         ),
       ),
       Positioned(
        bottom: 0,
         child: Container(
          padding: EdgeInsets.all(10),
          height: 90,
          width: ScreenWidth,
          color:  const Color.fromARGB(255, 255, 250, 250),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    width: 1.5,
                    color: const Color.fromARGB(64, 0, 0, 0),
                  ),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Icon(
                  Icons.arrow_back,
                  color: const Color.fromARGB(78, 0, 0, 0),
                  size: 30,
                ),
              ),
              GestureDetector(
                onTap: (){
                  widget.onNext();
                  Dataprocessing.UpdateWeight(MyWeight);
                }
                 
                
                ,
                child: Container(
                  height: 50,
                  width: ScreenWidth*.7,
                 
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                       color: const Color.fromARGB(255, 240, 145, 90),
                  ),
                  child: Center(
                    child: Text(
                      'Continue',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20
                      ),
                
                    ),
                  ),
                ),
              )
            ],
          ),
         ),
       ),
       Positioned(
        bottom: 150,
        right: ScreenWidth*.08,
        left: ScreenWidth*.08,
         child: Container(
          padding: EdgeInsets.all(15),
          height: 100,
          width: ScreenWidth*.8,
          
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              width: 1,
              color: const Color.fromARGB(117, 158, 158, 158)
            )
          ),
          child: Column(
            children: [
              Text(
                'Reccomended',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: const Color.fromARGB(255, 240, 145, 90),
                ),
              ),
              SizedBox(height: 10,),
              Text(
                'Most Fitelo users (90%) follow our plan - it\'s \nyour turn to share!',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  color: const Color.fromARGB(255, 78, 78, 78),
                  fontSize: 13
                ),
              )
            ],
          ),
         ),
       ),
       Center(
         child: Container(
          padding: EdgeInsets.only(top: 2,bottom:45),
          height: 180,
          width: 10,
          color: const Color.fromARGB(0, 244, 67, 54),
          child: Stack(
            children: [
              VerticalDivider(thickness: 2,color: Colors.orange,),
              Positioned(
                top: 15,
                left: 1,
                child: CircleAvatar(
                  radius: 4,
                  backgroundColor: Colors.orange,
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                child: CircleAvatar(
                  radius: 5,
                  backgroundColor: Colors.orange,
                ),
              ),
            ],
          ),
         ),
       )
        ],
      ),
    );
  }
}

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double w = size.width;
    double h = size.height;

    final path = Path();

    path.lineTo(0, h);
    path.quadraticBezierTo(w * 0.5, h - 140, w, h);
    path.lineTo(w, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return false;
  }
}



  class MyTopBox extends CustomPainter{
    final int option;

    MyTopBox({
      required this.option
    });
    @override 
    void paint(Canvas canvas , Size size){
      // print(option);
       double w = size.width;
    double h = size.height;
      final paint = Paint()
      ..color = const Color.fromARGB(0, 33, 149, 243);
      final path = Path();
      path.moveTo(0, h);
      path.quadraticBezierTo(w*.5, h-100, w, h);
      path.lineTo(w, 0);
      path.lineTo(0, 0);
      canvas.drawPath(path, paint);

        final paint2 = Paint()
        ..color = const Color.fromARGB(255, 216, 213, 213)
        ..strokeCap = StrokeCap.square
        ..style = PaintingStyle.stroke
        ..strokeWidth = 15;

        final path2 = Path();

        path2.moveTo(0, h*.96);
        option==0? path2.quadraticBezierTo(w*.5, h-145, w, h*.96): option==4?path2.quadraticBezierTo(w*.5, h-185, w, h*.96) :path2.quadraticBezierTo(w*.5, h-175, w, h*.96) ;
        canvas.drawPath(path2, paint2);

        final paint3 = Paint()
        ..color = const Color.fromARGB(255, 216, 213, 213)
        ..strokeCap = StrokeCap.square
        ..style = PaintingStyle.stroke
        
        ..strokeWidth = 1;

        final path3 = Path();

        path3.moveTo(0, h*.9);
       option==0? path3.quadraticBezierTo(w*.5, h-155, w, h*.9): option==4?  path3.quadraticBezierTo(w*.5, h-195, w, h*.9)   :path3.quadraticBezierTo(w*.5, h-185, w, h*.9);
        canvas.drawPath(path3, paint3);
        
        


    }
    
      @override
      bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
     return false; 
      }
  }

class ClockPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var centerX = size.width / 2;
    var centerY = size.height / 2;
 

    var center = Offset(centerX, centerY);
    var radius = min(centerX, centerY);

    var outerRadius = radius - 10;
    var innerRadius = radius - 20;
    var innerRadius2 = radius - 28;
    final textRadius = innerRadius2-17;
    double x2;
    double y2;

    var hourDashPaint =
        Paint()
          ..color = const Color.fromARGB(76, 158, 158, 158)
          ..strokeWidth = 1
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round;
    var hourDashPaint2 =
        Paint()
          ..color = const Color.fromARGB(127, 255, 153, 0)
          ..strokeWidth = 1
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round;
    var hourDashPaint3 =
        Paint()
          ..color = const Color.fromARGB(120, 0, 0, 0)
          ..strokeWidth = 1
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round;

    for (int i = 0; i < 400; i += 1) {
      double x1 = centerX - outerRadius * cos(i * pi / 200);
      double y1 = centerX - outerRadius * sin(i * pi / 200);
      if (i % 5 == 0) {
         x2 = centerX - innerRadius2 * cos(i * pi / 200);
         y2 = centerX - innerRadius2 * sin(i * pi / 200);
      } else {
         x2 = centerX - innerRadius * cos(i * pi / 200);
         y2 = centerX - innerRadius * sin(i * pi / 200);
      }

    i%5==0 && i%10!=0? canvas.drawLine(Offset(x1, y1), Offset(x2, y2), hourDashPaint2) :i%5==0 && i%10==0?canvas.drawLine(Offset(x1, y1), Offset(x2, y2), hourDashPaint3): canvas.drawLine(Offset(x1, y1), Offset(x2, y2), hourDashPaint);

    if (i % 10 == 0) {
        final number = i ~/ 10; // Get number from 0 to 40
        final angle = i * pi / 200  +pi; // Angle in radians

        // Calculate text position
        final textX = centerX + textRadius * cos(angle);
        final textY = centerY + textRadius * sin(angle);

        // Save canvas state
        canvas.save();

        // Translate to text position
        canvas.translate(textX, textY);

        // Rotate canvas to make text upright
        canvas.rotate(angle);
        canvas.rotate(pi / 2);

        // Draw text
        final textSpan = TextSpan(
          text: '$number',
          style: TextStyle(
            color: const Color.fromARGB(255, 139, 136, 136),
            fontSize: 9,
            fontWeight: FontWeight.w500,
          ),
        );
        final textPainter = TextPainter(
          text: textSpan,
          textAlign: TextAlign.center,
          textDirection: TextDirection.rtl,
        );
        textPainter.layout();

        // Center the text at the translated point
        textPainter.paint(
          canvas,
          Offset(-textPainter.width / 2, -textPainter.height / 2),
        );

        // Restore canvas state
        canvas.restore();
      }
    

  
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
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
        
        