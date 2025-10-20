import 'package:assignment_fitelo/homePage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Front extends StatefulWidget {
  const Front({super.key});

  @override
  State<Front> createState() => _FrontState();
}

class _FrontState extends State<Front> {
  double? _width;
  double? _height;

  @override
  Widget build(BuildContext context) {
  _width=  MediaQuery.of(context).size.width;
  _height = MediaQuery.of(context).size.height;
    return Scaffold(
      
      body: GestureDetector(
        onTap: () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomePage()));
        },
        child: Stack(
          
          children: [
            Container(
              height: _height,
              width: _width,
              color: const Color.fromARGB(255, 248, 237, 218),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                'Assignment',
              style: GoogleFonts.parisienne(
               fontSize: 50,
               color: const Color.fromARGB(255, 255, 128, 95) 
              ),
              ),
            ),
            // Spacer(),
            Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                'Assignment',
              style: GoogleFonts.libreBarcode128(
               fontSize: 50,
               color: const Color.fromARGB(255, 255, 128, 95) 
              ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}