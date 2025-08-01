import 'package:get/get.dart';
import '../../../utils/ApiServices.dart';
import '../../../utils/token_service.dart';
import '../model/pull_request.dart';

class PullRequestController extends GetxController {
  List<PullRequest> pullRequests = [];
  bool isLoading = true;
  String? error;
  String token = '';

  @override
  void onInit() {
    super.onInit();
    fetchPullRequests();
    loadToken();

  }

  Future<void> loadToken() async {
    token = (await TokenService.getToken())!;
    update();
  }

  void fetchPullRequests() async {
    try {
      isLoading = true;
      error = null;
      update();
      pullRequests = await ApiService.fetchPullRequests();
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> refreshList() async {
    fetchPullRequests();
  }
}
