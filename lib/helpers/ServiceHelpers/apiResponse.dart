class ApiResponse {
  dynamic message;
  dynamic error;
  dynamic success;
  dynamic data;
  dynamic otp;
  ApiResponse({
    this.message,
    this.data,
    this.otp,
    this.success,
    this.error,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      message: json["message"],
      data: json["data"],
      otp: json["otp"],
      error: json["error"],
      success: json["success"],
    );
  }

  Map<String, dynamic> apiBaseResponseToJson(ApiResponse instance) {
    return <String, dynamic>{
      'message': instance.message,
      "data": instance.data,
      "otp": instance.otp,
      "error": instance.error
    };
  }

  Map<String, dynamic> toJson() {
    return {
      "message": message ?? "",
      "data": data ?? "",
      "otp": otp ?? "",
      "error": error ?? "",
      "success": success ?? "",
    };
  }
}
