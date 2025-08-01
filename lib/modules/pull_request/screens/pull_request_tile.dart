import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controller/pull_request_controller.dart';

class PullRequestTile extends StatefulWidget {
  final int index;

  const PullRequestTile({super.key, required this.index});

  @override
  State<PullRequestTile> createState() => _PullRequestTileState();
}

class _PullRequestTileState extends State<PullRequestTile> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PullRequestController>(
      builder: (controller) {
        final pullRequest = controller.pullRequests[widget.index];
        final formattedDate = DateFormat.yMMMEd().format(pullRequest.createdAt);
        final statusColor = Colors.green;

        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 1,
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: ExpansionTile(
            tilePadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            childrenPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            onExpansionChanged: (expanded) {
              setState(() {
                _isExpanded = expanded;
              });
            },
            title: Row(
              children: [
                Expanded(
                  child: Text(
                    pullRequest.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                Image.asset('assets/codebranch.png', height: 20, width: 20),
              ],
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Author: ${pullRequest.author}',
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        'Date: $formattedDate',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  /*Text(
                    'Date: $formattedDate',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),*/
                ],
              ),
            ),

            trailing: Icon(
              _isExpanded
                  ? Icons.keyboard_arrow_up_rounded
                  : Icons.keyboard_arrow_down_rounded,
              color: Colors.grey.shade600,
            ),
            children: [
              const Divider(),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Created At:',
                    style: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    formattedDate,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              Row(
                children: [
                  const Icon(
                    Icons.merge_type,
                    size: 18,
                    color: Colors.blueGrey,
                  ),
                  const SizedBox(width: 6),
                  const Text('From ', style: TextStyle(fontSize: 13)),
                  Text(
                    pullRequest.headBranch,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                  const Text(' → ', style: TextStyle(fontSize: 13)),
                  Text(
                    pullRequest.baseBranch,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              const Text(
                'Body:',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),

              const SizedBox(height: 4),

              Text(
                pullRequest.body?.trim().isNotEmpty == true
                    ? pullRequest.body!
                    : 'No description provided.',
                style: const TextStyle(fontSize: 13),
              ),

              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }
}
