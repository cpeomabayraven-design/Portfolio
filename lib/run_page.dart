import 'package:flutter/material.dart';

class PixelScene extends StatefulWidget {
  const PixelScene({super.key});

  @override
  State<PixelScene> createState() => _PixelSceneState();
}

class _PixelSceneState extends State<PixelScene>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  late Animation<double> catAnim;
  late Animation<double> text1Anim;
  late Animation<double> text2Anim;
  late Animation<double> text3Anim;
  late Animation<double> text4Anim;
  late Animation<double> text5Anim;
  late Animation<double> text6Anim;
  late Animation<double> text7Anim;
  late Animation<double> text8Anim;
  late Animation<double> text9Anim;
  late Animation<double> text10Anim;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final screenWidth = MediaQuery.of(context).size.width;

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();

    // Cat animation
    catAnim = Tween<double>(
      begin: -150,
      end: screenWidth + 150,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.linear));

    // Text 1
    text1Anim = Tween<double>(begin: -300, end: screenWidth + 300).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.7, curve: Curves.linear),
      ),
    );

    // Text 2 (delayed)
    text2Anim = Tween<double>(begin: -300, end: screenWidth + 300).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 1.0, curve: Curves.linear),
      ),
    );

    // Text 3 (more delayed)
    text3Anim = Tween<double>(begin: -300, end: screenWidth + 300).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 0.9, curve: Curves.linear),
      ),
    );

    text4Anim = Tween<double>(begin: -300, end: screenWidth + 300).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.4, curve: Curves.linear),
      ),
    );

    text5Anim = Tween<double>(begin: -300, end: screenWidth + 300).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.1, 0.5, curve: Curves.linear),
      ),
    );

    text6Anim = Tween<double>(begin: -300, end: screenWidth + 300).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 0.7, curve: Curves.linear),
      ),
    );

    text7Anim = Tween<double>(begin: -300, end: screenWidth + 300).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 0.9, curve: Curves.linear),
      ),
    );

    text8Anim = Tween<double>(begin: -300, end: screenWidth + 300).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 0.8, curve: Curves.linear),
      ),
    );

    text9Anim = Tween<double>(begin: -300, end: screenWidth + 300).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.1, 0.5, curve: Curves.linear),
      ),
    );

    text10Anim = Tween<double>(begin: -300, end: screenWidth + 300).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.1, 0.8, curve: Curves.linear),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background
          Positioned.fill(
            child: Image.asset("assets/bg.png", fit: BoxFit.cover),
          ),

          // Back button
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 12, top: 8),
              child: Align(
                alignment: Alignment.topLeft,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Back",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ),
          ),

          // Animations
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Stack(
                children: [
                  // Cat
                  Positioned(
                    bottom: 150,
                    left: catAnim.value,
                    child: Image.asset("assets/cat.gif", width: 120),
                  ),

                  // Text 1
                  Positioned(
                    top: 200,
                    left: text1Anim.value,
                    child: const Text(
                      "FLUTTER",
                      style: TextStyle(
                        color: Colors.brown,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  // Text 2
                  Positioned(
                    top: 300,
                    left: text2Anim.value,
                    child: const Text(
                      "DART",
                      style: TextStyle(
                        color: Colors.brown,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  // Text 3
                  Positioned(
                    top: 400,
                    left: text3Anim.value,
                    child: const Text(
                      "GO LANG",
                      style: TextStyle(
                        color: Colors.brown,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  Positioned(
                    top: 100,
                    left: text4Anim.value,
                    child: const Text(
                      "SQL",
                      style: TextStyle(
                        color: Colors.brown,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  Positioned(
                    top: 500,
                    left: text5Anim.value,
                    child: const Text(
                      "PYTHON",
                      style: TextStyle(
                        color: Colors.brown,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  Positioned(
                    top: 450,
                    left: text6Anim.value,
                    child: const Text(
                      "C++",
                      style: TextStyle(
                        color: Colors.brown,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  Positioned(
                    top: 350,
                    left: text7Anim.value,
                    child: const Text(
                      "JAVA",
                      style: TextStyle(
                        color: Colors.brown,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  Positioned(
                    top: 250,
                    left: text8Anim.value,
                    child: const Text(
                      "DOCKERFILE",
                      style: TextStyle(
                        color: Colors.brown,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  Positioned(
                    top: 150,
                    left: text9Anim.value,
                    child: const Text(
                      "HTML",
                      style: TextStyle(
                        color: Colors.brown,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  Positioned(
                    top: 50,
                    left: text10Anim.value,
                    child: const Text(
                      "POSTGRESQL",
                      style: TextStyle(
                        color: Colors.brown,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
