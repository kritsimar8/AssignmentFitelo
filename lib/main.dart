import 'dart:math';

import 'package:assignment_fitelo/extra.dart';
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
    return MaterialApp(title: 'Flutter Demo', home: RotationDemo());
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
  @override
  _RotationDemoState createState() => _RotationDemoState();
}

class _RotationDemoState extends State<RotationDemo>
    with SingleTickerProviderStateMixin {
  double _rotation = 0.0;
  double _previousRotation = 0.0;
  Offset? _center;

  late AnimationController _controller;
  double _velocity = 0.0;
  final double _scale = 0;

  final _hapticInterval = 2;

  int _lastHapticDegree = 0;
  double _width = 0;

  @override
  void initState() {
    super.initState();
    // Animation controller for momentum/inertia effect
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 251, 251),

      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              // margin: EdgeInsets.only(top: 450),
              height: 400,
              width: 400,
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
                          _center = Offset(
                            150,
                            150,
                          ); // Half of container size
                        });
                      }
                    });
          
                    return Transform.scale(
                      scale: 1.3,
                      child: Transform.rotate(
                        angle: _rotation,
                        child: Container(
                          width: 500,
                          height: 500,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [Colors.blue, Colors.purple],
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
                                    height: 400,
                                    width: 400,
                                    child: CustomPaint(
                                      painter: ClockPainter(),
                                    ),
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
                                          color: Colors.white70,
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
          ),
          ClipPath(
            clipper: CustomClipPath(),
            child: Container(
              padding: EdgeInsets.only(top: 50),
              height: 30,
              width: 500,
              color: const Color.fromARGB(255, 197, 102, 7),
              child: Column(
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
                    'Based on your height and weight, \nhere a goal crafted just for you.Ready to \nstart your journey?',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.bold,
                      wordSpacing: 2,
                      color: const Color.fromARGB(185, 0, 0, 0),
                    ),
                  ),
                  SizedBox(height: 30),
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
            ),
          ),
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

class ClockPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var centerX = size.width / 2;
    var centerY = size.height / 2;
    print(centerX);
    print(centerY);

    var center = Offset(centerX, centerY);
    var radius = min(centerX, centerY);

    var outerRadius = radius - 35;
    var innerRadius = radius - 45;

    var hourDashPaint =
        Paint()
          ..color = Colors.grey
          ..strokeWidth = 2
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round;

    for (int i = 0; i < 180; i += 1) {
      double x1 = centerX - outerRadius * cos(i * pi / 100);
      double y1 = centerX - outerRadius * sin(i * pi / 100);
      double x2 = centerX - innerRadius * cos(i * pi / 100);
      double y2 = centerX - innerRadius * sin(i * pi / 100);

      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), hourDashPaint);
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
        
        