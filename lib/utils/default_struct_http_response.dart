class DefaultStructHttpResponse {
  bool success;
  int statusCode;
  String? message;
  String body;

  DefaultStructHttpResponse({
    this.success = false,
    this.statusCode = 0,
    this.message = '',
    this.body = '',
  });
}
