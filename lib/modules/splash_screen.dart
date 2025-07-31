import 'package:flutter/material.dart';
import 'login/screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  final String _title = "GitHub Pull Request Viewer";
  late List<AnimationController> _controllers;
  late List<Animation<Offset>> _animations;

  @override
  void initState() {
    super.initState();

    _controllers = List.generate(_title.length, (index) {
      return AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 500),
      );
    });

    _animations = _controllers.map((controller) {
      return Tween<Offset>(
        begin: const Offset(0, -1.5),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: controller,
        curve: Curves.bounceOut,
      ));
    }).toList();

    _startStaggeredAnimations();


    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    });
  }

  Future<void> _startStaggeredAnimations() async {
    for (int i = 0; i < _controllers.length; i++) {
      await Future.delayed(const Duration(milliseconds: 50));
      _controllers[i].forward();
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/github.png",
              scale: 3,
            ),
            const SizedBox(height: 24), // spacing between image and text
          /*  Wrap(
              alignment: WrapAlignment.center,
              children: List.generate(_title.length, (index) {
                return SlideTransition(
                  position: _animations[index],
                  child: Text(
                    _title[index],
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                    ),
                  ),
                );
              }),
            ),*/
          ],
        ),
      ),
    );
  }

}
