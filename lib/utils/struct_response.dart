class StructResponse {
  String message;
  dynamic response;
  bool error;

  StructResponse({
    this.message = '',
    this.response,
    this.error = false,
  });
}
