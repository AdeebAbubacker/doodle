class RegisterModel {
  final int? id;
  final String? token;

  RegisterModel({this.id, this.token});

  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    return RegisterModel(
      id: json['id'] as int?,
      token: json['token'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'token': token,
    };
  }
}
