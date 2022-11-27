// Placeholder, should be generated from the api.

class Response {
  Response({
    this.status,
    this.message,
  });

  bool status; // Request status
  String message; // Request message

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
      );
}
