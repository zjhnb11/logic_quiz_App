import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';

class DotsControls extends StatelessWidget {
  final PageController controller;
  final double currentPage;

  DotsControls({required this.controller, required this.currentPage});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          //left
          icon: Icon(Icons.arrow_back),
          onPressed: currentPage > 0
              ? () {
                  controller.previousPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeIn);
                }
              : null,
        ),
        const SizedBox(width: 20),
        DotsIndicator(
          dotsCount: 4,
          position: currentPage,
          decorator: DotsDecorator(
            activeColor: Colors.purple,
          ),
        ),
        const SizedBox(width: 20),
        IconButton(
          //right
          icon: Icon(Icons.arrow_forward),
          onPressed: currentPage < 3.0
              ? () {
                  controller.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeIn);
                }
              : null,
        ),
      ],
    );
  }
}
