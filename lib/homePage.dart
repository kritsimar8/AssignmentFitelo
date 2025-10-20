import 'package:assignment_fitelo/Calorie.dart';
import 'package:assignment_fitelo/DataProcessing.dart';
import 'package:assignment_fitelo/main.dart';
import 'package:assignment_fitelo/timeline.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final int _pageCount = 3;

  Dataprocessing _data = Dataprocessing();

  

  // List<Widget> pages = [RotationDemo(onNext: ,), Timeline(), CalorieIntake()];

  @override
  void dispose() {
    // TODO: implement dispose
    _pageController.dispose();
    super.dispose();
  }
  
  void _nextPage() {
    if (_currentPage < 2) {
      _pageController.animateToPage(
        _currentPage + 1,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.animateToPage(
        _currentPage - 1,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOut,
      );
    }
  }

  void _goToPage(int page) {
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    // _data.dataPrint('Aloo prantha');
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              physics: NeverScrollableScrollPhysics(),
              controller: _pageController,
              onPageChanged: (value) {
                setState(() {
                  _currentPage = value;
                });
              },

              children: [RotationDemo(
                onNext: _nextPage,
              ),
               Timeline(
                onNext: _nextPage,
                onPrevious: _previousPage,
               ),
                CalorieIntake(
                  onNext: _nextPage,
                  onPrevious: _previousPage,
                )],
            ),
          ),
        ],
      ),
    );
  }
}
