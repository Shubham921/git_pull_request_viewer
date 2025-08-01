import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:git_pull_request_viewer/modules/pull_request/screens/pull_request_tile.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import '../../../utils/appbar.dart';
import '../controller/pull_request_controller.dart';

class PullRequestScreenListScreen extends StatelessWidget {
  const PullRequestScreenListScreen({super.key});

  Widget _buildShimmerList() {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Shimmer(
          duration: const Duration(seconds: 2),
          color: Colors.white,
          colorOpacity: 0.3,
          direction: const ShimmerDirection.fromLTRB(),
          child: Container(
            height: 80,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PullRequestController>(
      init: PullRequestController(),
      builder: (controller) {
        return Scaffold(
          appBar:  CustomAppBar(title: "Home",
            onInfoPressed: () {
              Get.snackbar("Saved Token", controller.token.isNotEmpty ? controller.token : 'Token not available');

            },
          ),
          body: RefreshIndicator(
            onRefresh: controller.refreshList,
            child: controller.isLoading
                ? _buildShimmerList()
                : controller.error != null
                ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Error:\n${controller.error}',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: controller.refreshList,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            )
                : controller.pullRequests.isEmpty
                ? const Center(child: Text('No open pull requests.'))
                : ListView.builder(
              itemCount: controller.pullRequests.length,
              itemBuilder: (context, index) {
                return PullRequestTile(index: index);
              },

            ),
          ),
        );
      },
    );
  }
}
