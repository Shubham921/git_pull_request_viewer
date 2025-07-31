

import 'package:get/get.dart';

import '../../../utils/token_service.dart';
import '../../pull_request/screens/pull_request_screen.dart';

class LoginController extends GetxController{


  void handleSimulatedLogin() async {
    await TokenService.saveToken("abc123");
    Get.to(PullRequestScreenListScreen());
  }

}