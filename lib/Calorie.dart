import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CalorieIntake extends StatefulWidget {
  const CalorieIntake({super.key});

  @override
  State<CalorieIntake> createState() => _CalorieIntakeState();
}

class _CalorieIntakeState extends State<CalorieIntake> {
  double _width = 0;

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

  final List<ChartData> chartData = [
    ChartData('David', 25, Color.fromRGBO(7, 202, 192, 1)),
    ChartData('Steve', 38, Color.fromRGBO(32, 88, 209, 1)),
    ChartData('Jack', 34, Color.fromRGBO(209, 171, 1, 1)),
    // ChartData('Others', 52, Color.fromRGBO(255, 189, 57, 1)),
  ];

  @override
  Widget build(BuildContext context) {
  double  ScreenWidth = MediaQuery.of(context).size.width;
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
            SizedBox(height: 50),
            Text(
              'Awesome 😎! Here\'s Your Calorie Intake - with\n your \"7Kg in 3 months\" goal, this personalized\n daily calorie guide keeps you on track! ',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                // height: 1.5,
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: const Color.fromARGB(209, 0, 0, 0),
              ),
            ),
            SizedBox(height: 40),
            Container(
              height: 290,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color.fromARGB(0, 244, 67, 54),
              ),
              child: Stack(
                children: [
                 Center(
                   child: Padding(
                     padding: const EdgeInsets.only(top: 0),
                     child: Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('🔥',
                        style: TextStyle(
                          fontSize: 30
                        ),),
                        Text('1,800',
                        style: GoogleFonts.inter(
                          fontSize: 40,
                          fontWeight: FontWeight.w600
                        ),
                        ),
                        Text('Daily calories',
                        style: TextStyle(
                          color: const Color.fromARGB(131, 0, 0, 0),
                          fontWeight: FontWeight.w600,
                          fontSize: 17
                        ),
                        ),
                      ],
                     ),
                   ),
                 ),
                  SfCircularChart(
                    series: <CircularSeries>[
                      DoughnutSeries<ChartData,String>(
                        dataSource: chartData,
                        animationDuration: 0,
                        pointColorMapper: (ChartData data, _)=> data.color,
                        xValueMapper: (ChartData data, _)=>data.x,
                        yValueMapper: (ChartData data, _)=>data.y,
                        innerRadius: '90%',
                        radius: '95%',
                        
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 60,),
            Padding(
              padding: const EdgeInsets.only(right: 13,left: 13),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    height: 140,
                    width: 120,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 240, 250, 250),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 1,
                        color: const Color.fromARGB(68, 158, 158, 158)
                      )
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor: const Color.fromARGB(255, 75, 165, 165),
                          radius: 18,
                          child: Text('🍚',),
                        ),
                        SizedBox(height: 5,),
                        Text('185g',
                        style: GoogleFonts.roboto(
                          
                          fontSize: 22,
                          fontWeight: FontWeight.w600
                        ),
                        ),
                        // SizedBox(height: 4,),
                        Text('Carbs',
                        style: GoogleFonts.roboto(
                          
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: const Color.fromARGB(166, 0, 0, 0)
                        ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 140,
                    width: 120,
                     decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 245, 250, 250),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 1,
                        color: const Color.fromARGB(75, 158, 158, 158)
                      )
                    ),
                    child:  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor: const Color.fromARGB(255, 55, 110, 160),
                          radius: 18,
                          child: Text('🧬',
                          style: TextStyle(
                            fontSize: 13
                          ),
                          ),
                        ),
                        SizedBox(height: 5,),
                        Text('135g',
                        style: GoogleFonts.roboto(
                          
                          fontSize: 22,
                          fontWeight: FontWeight.w600
                        ),
                        ),
                        // SizedBox(height: 4,),
                        Text('Protein',
                        style: GoogleFonts.roboto(
                          
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: const Color.fromARGB(166, 0, 0, 0)
                        ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 140,
                    width: 120,
                     decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 250, 245, 230),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 1,
                        color: const Color.fromARGB(69, 158, 158, 158)
                      )
                    ),
                    child:  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor: const Color.fromARGB(255, 255, 180, 70),
                          radius: 18,
                          child: Text('🥑',
                          style: TextStyle(
                            fontSize: 14
                          ),
                          ),
                        ),
                        SizedBox(height: 5,),
                        Text('60g',
                        style: GoogleFonts.roboto(
                          
                          fontSize: 22,
                          fontWeight: FontWeight.w600
                        ),
                        ),
                        // SizedBox(height: 4,),
                        Text('Fat',
                        style: GoogleFonts.roboto(
                          
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: const Color.fromARGB(166, 0, 0, 0)
                        ),
                        ),
                      ],
                    ),
                  )
                ],
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
              Container(
                
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
              Container(
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

class ChartData {
  ChartData(this.x, this.y, this.color);
  final String x;
  final double y;
  final Color color;
}
