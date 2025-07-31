import 'package:flutter/material.dart';
import 'package:git_pull_request_viewer/modules/pull_request/screens/pull_request_tile.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import '../../../utils/ApiServices.dart';
import '../../../utils/appbar.dart';
import '../../../utils/token_service.dart';
import '../model/pull_request.dart';

class PullRequestScreenListScreen extends StatefulWidget {
  const PullRequestScreenListScreen({super.key});

  @override
  State<PullRequestScreenListScreen> createState() =>
      _PullRequestScreenListScreenState();
}

class _PullRequestScreenListScreenState
    extends State<PullRequestScreenListScreen> {
  late Future<List<PullRequest>> _pullRequests;
  String? _token;

  @override
  void initState() {
    super.initState();
    _pullRequests = ApiService.fetchPullRequests();
    _loadToken();
  }

  Future<void> _loadToken() async {
    final token = await TokenService.getToken();
    setState(() {
      _token = token;
    });
  }

  Future<void> _refresh() async {
    setState(() {
      _pullRequests = ApiService.fetchPullRequests();
    });
  }

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
    return Scaffold(
      appBar: const CustomAppBar(title: "Home", showBack: false),
      body: Column(
        children: [
          if (_token != null)
            Expanded(
              child: RefreshIndicator(
                onRefresh: _refresh,
                child: FutureBuilder<List<PullRequest>>(
                  future: _pullRequests,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return _buildShimmerList();
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Error:\n${snapshot.error}',
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            ElevatedButton(
                              onPressed: _refresh,
                              child: const Text('Retry'),
                            ),
                          ],
                        ),
                      );
                    } else {
                      final prList = snapshot.data!;
                      if (prList.isEmpty) {
                        return const Center(
                            child: Text('No open pull requests.'));
                      }
                      return ListView.builder(
                        itemCount: prList.length,
                        itemBuilder: (context, index) {
                          return PullRequestTile(pullRequest: prList[index]);
                        },
                      );
                    }
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}
