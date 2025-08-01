class PullRequest {
  final String title;
  final String? body;
  final String author;
  final DateTime createdAt;
  final String baseBranch;
  final String headBranch;

  PullRequest({
    required this.title,
    required this.body,
    required this.author,
    required this.createdAt,
    required this.baseBranch,
    required this.headBranch,
  });

  factory PullRequest.fromJson(Map<String, dynamic> json) {
    return PullRequest(
      title: json['title'],
      body: json['body'] ?? '',
      author: json['user']['login'],
      createdAt: DateTime.parse(json['created_at']),
      baseBranch: json['base']['ref'],
      headBranch: json['head']['ref'],
    );
  }
}
