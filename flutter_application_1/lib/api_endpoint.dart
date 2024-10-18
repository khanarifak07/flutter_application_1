class APIEndPoint {
  final String url;
  final String method;
  final bool requireAuth;

  APIEndPoint({
    required this.url,
    required this.method,
    required this.requireAuth,
  });
}
