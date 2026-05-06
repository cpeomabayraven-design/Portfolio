import 'package:flutter/material.dart';

class PixelScene extends StatefulWidget {
  const PixelScene({super.key});

  @override
  State<PixelScene> createState() => _PixelSceneState();
}

class _PixelSceneState extends State<PixelScene>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();

    _animation = Tween<double>(
      begin: -150,
      end: MediaQueryData.fromView(WidgetsBinding.instance.window).size.width,
    ).animate(_controller);
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

          // Moving cat
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Positioned(
                bottom: 150,
                left: _animation.value,
                child: child!,
              );
            },
            child: Image.asset("assets/cat.gif", width: 120),
          ),
        ],
      ),
    );
  }
}
