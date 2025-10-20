import 'package:assignment_fitelo/DataProcessing.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Timeline extends StatefulWidget {

  final VoidCallback onNext; 
  final VoidCallback onPrevious;
  

  const Timeline({super.key, required this.onNext, required this.onPrevious});

  @override
  State<Timeline> createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {

    double _width =0;

  @override
  void initState() {
    // TODO: implement initState

     Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _width = 23;
      });
    });

    super.initState();
  }

  double sliderValue = 1;
  double months= 6 ;

  double Month(double sliderValue){
    return sliderValue>0 &&sliderValue<3 ?6: sliderValue>3 &&sliderValue<8? 3: 1.5;
  }

  Dataprocessing _data = Dataprocessing();


  @override
  Widget build(BuildContext context) {

    double ScreenWidth = MediaQuery.of(context).size.width;
    double Mymonth= Month(sliderValue);

  



    // print(sliderValue);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 60),
        child: Column(
          children: [
            Row(
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
            SizedBox(height: 50,),
            Text(
              'Great⏳ ! We\'ve calculated a safe, steady \ntimeline-how soon do you want to reach\n your milestone?',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black, 

              ),
            ),
            SizedBox(height: 50,),
            Column(
              children: [
                Text(
                  'Time to lose weight',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: const Color.fromARGB(160, 0, 0, 0),
                    fontWeight: FontWeight.w600
                  ),
                ),
                SizedBox(height: 10,),
                Text(
                  '$Mymonth months',
                  style: GoogleFonts.inter(
                    fontSize: 38,
                    color: const Color.fromARGB(225, 0, 0, 0),
                    fontWeight: FontWeight.w600
                  ),
                ),
                SizedBox(height: 30,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '⏳',
                        style: TextStyle(
                          fontSize: 30
                        ),
                      ),
                      Text(
                        '🤝',
                        style: TextStyle(
                          fontSize: 30
                        ),
                      ),
                      Text(
                        '🏋🏼‍♂️',
                        style: TextStyle(
                          fontSize: 30
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 40,),
            SliderTheme(
              data: SliderThemeData(
                trackHeight: 10,
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10)
              ),
              child: Slider(
                activeColor: const Color.fromARGB(255, 230, 115, 55),
                thumbColor: const Color.fromARGB(255, 230, 115, 55),
                inactiveColor: const Color.fromARGB(50, 194, 194, 194),
           
                min: 0,
                max: 10,
              value: sliderValue, 
              onChanged: (value){
                setState(() {
                  sliderValue = value;  
                });
                
              },
              ),
            ),
              SizedBox(height: 20),
             Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Gentle',
                        style: GoogleFonts.inter(
                          fontSize: 15,
                           fontWeight: FontWeight.w600,
                           color: sliderValue>0 && sliderValue< 3 ? Color.fromARGB(255, 230, 115, 55) : Colors.black
                        ),
                      ),
                      Text(
                        'Recommended',
                        style: GoogleFonts.inter(
                          fontSize: 15,
                           fontWeight: FontWeight.w600,
                           color: sliderValue>=3 && sliderValue< 8 ? Color.fromARGB(255, 230, 115, 55) : Colors.black
                        ),
                      ),
                      Text(
                        'Intense',
                        style: GoogleFonts.inter(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                           color: sliderValue>=8  ? Color.fromARGB(255, 230, 115, 55) : Colors.black
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 50,),
                Text(
                  '\"Gentle pace, easier to maintain long term.\" ',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: const Color.fromARGB(179, 0, 0, 0)
                  ),
                ),
                Spacer(),
                Container(
          padding: EdgeInsets.all(10),
          height: 90,
          width: ScreenWidth,
          color:  const Color.fromARGB(255, 255, 255, 255),
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
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Icon(
                    Icons.arrow_back,
                    color: const Color.fromARGB(255, 240, 145, 90),
                    size: 30,
                  ),
                ),
              ),
              GestureDetector(
                onTap:(){
                  widget.onNext();
                  Dataprocessing.UpdateDuration(Mymonth);
                } ,
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
            
          ],
        ),
      ),
    );
  }
}
