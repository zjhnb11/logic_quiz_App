import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:log_app/widgets/pageview_Explain.dart';
import 'package:log_app/widgets/dotscontrollers.dart';

class ExplainationScreen extends StatefulWidget {
  const ExplainationScreen({Key? key}) : super(key: key);

  @override
  _ExplanationScreenState createState() => _ExplanationScreenState();
}

class _ExplanationScreenState extends State<ExplainationScreen> {
  final _controller = PageController();
  double _currentPage = 0;

  @override
  void initState() {
    _controller.addListener(() {
      setState(() {
        _currentPage = _controller.page!;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Color.fromARGB(234, 12, 122, 231),
        actions: [
          TextButton(
            child: Text('Skip'),
            style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: 20),
            ),
            onPressed: () {
              context.go('/quiz');
            },
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          if (_currentPage < 3.0) {
            _controller.nextPage(
                duration: Duration(milliseconds: 300), curve: Curves.easeIn);
          }
        },
        child: Column(
          children: [
            const Text('Feature Description',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            const SizedBox(height: 30),
            PageView_Explaination(controller: _controller),
            const SizedBox(height: 30),
            DotsControls(controller: _controller, currentPage: _currentPage),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
