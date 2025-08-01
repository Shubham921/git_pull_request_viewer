import 'package:get/get.dart';
import '../../../utils/ApiServices.dart';
import '../model/pull_request.dart';

class PullRequestController extends GetxController {
  List<PullRequest> pullRequests = [];
  bool isLoading = true;
  String? error;

  @override
  void onInit() {
    fetchPullRequests();
    super.onInit();
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
