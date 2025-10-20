import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Lastpage extends StatefulWidget {
  final VoidCallback onPrevious;
  const Lastpage({super.key, required this.onPrevious});

  @override
  State<Lastpage> createState() => _LastpageState();
}

class _LastpageState extends State<Lastpage> {
  double? ScreenWidth;
  double? _height;

  double _width = 0;

  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
         _width = 23;
      });
     
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenWidth = MediaQuery.of(context).size.width;
    _height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 248, 237, 218),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          Padding(
            padding: const EdgeInsets.only(top: 60),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                SizedBox(width: 8),
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
              ],
            ),
          ),
          Column(
            children: [
              Icon(
                Icons.task_alt,
                color: const Color.fromARGB(255, 255, 128, 95),
                size: 80,
              ),
              SizedBox(height: 30),
              Text(
                'All the best for your journey',
                style: GoogleFonts.inter(
                  fontSize: 30,
                  color: const Color.fromARGB(255, 255, 128, 95),
                ),
              ),
            ],
          ),

          // Spacer(),
          Container(
            padding: EdgeInsets.all(10),
            height: 90,
            width: ScreenWidth,
            color: const Color.fromARGB(255, 248, 237, 218),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: widget.onPrevious,
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        width: 1.5,
                        color: const Color.fromARGB(255, 240, 145, 90),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.arrow_back,
                      color: const Color.fromARGB(255, 240, 145, 90),
                      size: 30,
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  width: ScreenWidth! * .7,

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(55, 240, 145, 90),
                  ),
                  child: Center(
                    child: Text(
                      'Continue',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
