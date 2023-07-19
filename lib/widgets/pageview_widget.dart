import 'dart:math';

import 'package:flutter/material.dart';

import '../const/colors.dart';

class MyPageView extends StatefulWidget {
  @override
  _MyPageViewState createState() => _MyPageViewState();
}

class _MyPageViewState extends State<MyPageView> {
  late PageController _pageController;
  double _currentPage = 0;
  double viewport = 0.8;
  double pageOffset = 0;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: 0,
      viewportFraction:
          viewport, // Adjust this value to change the size of the centered item
    )..addListener(() {
        setState(() {
          pageOffset = _pageController.page!;
        });
      });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      scrollDirection: Axis.horizontal,
      controller: _pageController,
      itemCount: 3,
      itemBuilder: (BuildContext context, int index) {
        double scale =
            max(viewport, (1 - (pageOffset - index).abs()) + viewport);
        return Container(
            padding: EdgeInsets.only(
              right: 30,
              top: 100 - scale * 35,
              bottom: 50,
            ),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: AppColor.secondary,
                  boxShadow: [
                    BoxShadow(
                      color: AppColor.secondary.withOpacity(0.20),
                      spreadRadius: 8,
                      offset: Offset(2, 3),
                      blurRadius: 15,
                    ),
                  ]),
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 150,
                      height: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: AppColor.primary),
                      child: Center(
                        child: Text(
                          "02:12:34:56",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        height: 150,
                        width: 150,
                        child: Image.asset(
                          "assets/images/product1.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Expanded(
                                child: Text(
                                  "Air Jordan",
                                  style: TextStyle(
                                      fontSize: 18, fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),

                              Text(
                                "starts \$180",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.redAccent,
                                    fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                          RichText(
                            text: TextSpan(
                              style: DefaultTextStyle.of(context).style,
                              children: const <TextSpan>[
                                TextSpan(
                                  text: 'Posted by',
                                ),
                                TextSpan(
                                  text: ' @TurjhaPodder',
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 40,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: AppColor.primary,
                          border: Border.all(width: 2)),
                      child: Center(
                        child: Text(
                          "Place Bid",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ));
      },
    );
  }
}
