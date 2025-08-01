import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../utils/token_service.dart';
import 'package:slide_to_act/slide_to_act.dart';
import '../controller/login_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    LoginController loginController = Get.put(LoginController());
    final GlobalKey<SlideActionState> _key = GlobalKey();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(height: 40),
            Column(
              children: [
                Semantics(
                  label: 'GitHub logo',
                  hint: 'This is the logo of GitHub',
                  child: Image.asset(
                    'assets/github.png',
                    height: 140,
                    width: 140,
                  ),
                ),
                const SizedBox(height: 16),
                Semantics(
                  label: 'GitHub Pull Request Viewer',
                  hint: 'This is the title of the app',
                  child: const Text(
                    'GitHub Pull Request Viewer',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Semantics(
                  label: 'Visualize and manage GitHub pull requests effortlessly',
                  child: const Text(
                    'Visualize and manage GitHub PRs effortlessly',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Semantics(
                label: 'Slide to log in button',
                hint: 'Swipe right to login to the app',
                button: true,
                child: SlideAction(
                  key: _key,
                  onSubmit: () async => loginController.handleSimulatedLogin(),
                  text: 'Slide to Login',
                  innerColor: const Color(0xFF232323),
                  outerColor: const Color(0xFF838282),
                  elevation: 4,
                  sliderButtonIcon: Image.asset(
                    'assets/codebranch.png',
                    width: 24,
                    height: 24,
                    color: Colors.white,
                  ),
                  submittedIcon: const Icon(Icons.check, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
