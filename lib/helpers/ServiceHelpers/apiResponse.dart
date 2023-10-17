class ApiResponse {
  dynamic message;
  dynamic data;
  dynamic otp;
  dynamic error;
  ApiResponse({
    this.message,
    this.data,
    this.otp,
    this.error
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      message: json["message"],
      data: json["data"],
      otp: json["otp"],
      error: json["error"],
    );
  }

  Map<String, dynamic> apiBaseResponseToJson(ApiResponse instance) {
    return <String, dynamic>{
      'message': instance.message,
      "data":instance.data
    };
  }
}
