class UserModel {
  String? token;
  String? name;
  String? email;

  UserModel({this.token, this.name, this.email});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      token: json['token'],
      name: json['name'],
      email: json['email'],
    );
  }
}
