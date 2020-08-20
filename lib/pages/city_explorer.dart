import 'package:flutter/material.dart';

final imagesList = [
  "assets/eba.png",
  "assets/cat.gif",
  "assets/chicken.jpg",
  "assets/giphy.gif",
  "assets/kitten-playing.gif",
  "assets/unnamed.png",
  "assets/inn4.jpeg"
];
final colorList = [
  Colors.blueAccent.shade700,
  Colors.greenAccent.shade400,
  Colors.tealAccent,
  Colors.purpleAccent,
  Colors.indigoAccent,
  Colors.yellowAccent,
  Colors.redAccent.shade200
];

class CityExplorerPage extends StatefulWidget {
  @override
  _CityExplorerPageState createState() => _CityExplorerPageState();
}

class _CityExplorerPageState extends State<CityExplorerPage> {
  int currentPage = 0;
  PageController _pageController;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(
        initialPage: currentPage, keepPage: false, viewportFraction: 0.8);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        itemBuilder: (context, index) {
          return itemBuilder(index);
        },
        controller: _pageController,
        itemCount: imagesList.length,
        pageSnapping: true,
        onPageChanged: _onPageChanged,
        physics: ClampingScrollPhysics(),
      ),
    );
  }

  Widget itemBuilder(index) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (context, child) {
        double value = 1;

        if (_pageController.position.haveDimensions) {
          value = _pageController.page - index;
          value = (1 - (value.abs() * 0.5)).clamp(0.0, 1.0);
          return Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: Curves.easeIn.transform(value) * 600,
              margin: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
              child: child,
            ),
          );
        } else {
          return Align(
            alignment: Alignment.topCenter,
            child: Container(
              height:
                  Curves.easeIn.transform(index == 0 ? value : value * 0.5) *
                      600,
              margin: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
              child: child,
            ),
          );
        }
      },
      child: Material(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10.0),
            bottomRight: Radius.circular(10.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15.0),
              bottomRight: Radius.circular(15.0),
            ),
            child: Image.asset(
              imagesList[index],
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
        color: Colors.grey,
      ),
    );
  }

  _onPageChanged(int index) {
    setState(() {
      print(index);
      currentPage = index;
    });
  }
}
