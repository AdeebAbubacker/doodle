class LoginModel {
  final String? token;

  LoginModel({this.token});

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      token: json['token'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
    };
  }
}
