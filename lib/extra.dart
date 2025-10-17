import 'package:flutter/material.dart';

class CenterSelectorWheel extends StatefulWidget {
  @override
  _CenterSelectorWheelState createState() => _CenterSelectorWheelState();
}

class _CenterSelectorWheelState extends State<CenterSelectorWheel> {
  // Constants
  static const double _itemHeight = 80.0;
  static const int _totalItems = 20;

  // Controller for the list view
  final ScrollController _scrollController = ScrollController();

  // State variable for the currently focused number
  int _centerNumber = 0;

  @override
  void initState() {
    super.initState();
    // Start with a small delay to ensure the list has been laid out
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _calculateCenterNumber(0.0); // Calculate initial center
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // --- Core Calculation Logic ---
  void _calculateCenterNumber(double scrollOffset) {
    // 1. Get the height of the entire viewport.
    final double viewportHeight = MediaQuery.of(context).size.height;
    
    // 2. Calculate the position of the center line (fixed pointer).
    // It's the midpoint of the viewport.
    final double centerOffset = viewportHeight / 2.0;

    // 3. Calculate the index of the item whose center is closest to the viewport center.
    // The formula: (scrollOffset + centerOffset) / _itemHeight
    // Note: We subtract half an item height to align the item's center with the pointer.
    final double centerPosition = scrollOffset + centerOffset - (_itemHeight / 2);
    
    // 4. Determine the index.
    int newCenterIndex = (centerPosition / _itemHeight).round();

    // Clamp the index within the valid range (0 to _totalItems - 1)
    newCenterIndex = newCenterIndex.clamp(0, _totalItems - 1);

    // Update the state if the number has changed
    if (_centerNumber != newCenterIndex + 1) {
      setState(() {
        // We add 1 because the list index starts at 0, but numbers start at 1.
        _centerNumber = newCenterIndex + 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Selector Wheel')),
      body: Stack(
        alignment: Alignment.center,
        children: [
          // ----------------------------------------------------
          // 1. The Scrollable List (Replaces SingleChildScrollView)
          // ----------------------------------------------------
          NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              // Only react to scrolling motion
              if (notification is ScrollUpdateNotification) {
                _calculateCenterNumber(notification.metrics.pixels);
              }
              return true;
            },
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _totalItems,
              itemBuilder: (context, index) {
                final int number = index + 1;
                // Highlight the center item
                final bool isCenter = number == _centerNumber;

                return Container(
                  height: _itemHeight,
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 20.0),
                  decoration: BoxDecoration(
                    color: isCenter ? Colors.red.withOpacity(0.2) : Colors.grey[200],
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: isCenter ? Colors.red : Colors.transparent, width: 2),
                  ),
                  child: Text(
                    number.toString(),
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: isCenter ? FontWeight.bold : FontWeight.normal,
                      color: isCenter ? Colors.red : Colors.black,
                    ),
                  ),
                );
              },
            ),
          ),
          
          // ----------------------------------------------------
          // 2. The Fixed Center Pointer (The "Ruler" Line)
          // ----------------------------------------------------
          IgnorePointer(
            child: Container(
              height: _itemHeight, // The pointer area matches the item height
              decoration: BoxDecoration(
                border: Border.symmetric(
                  horizontal: BorderSide(color: Colors.red, width: 3.0),
                ),
              ),
              child: Center(
                child: Text(
                  'Center: $_centerNumber',
                  style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}