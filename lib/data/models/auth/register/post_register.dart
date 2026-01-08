
class PostRegister {
  String? email;
  String? password;
  String? firstName;
  String? lastName;

  PostRegister({this.email, this.password, this.firstName, this.lastName});

  PostRegister.fromJson(Map<String, dynamic> json) {
    email = json["email"];
    password = json["password"];
    firstName = json["firstName"];
    lastName = json["lastName"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["email"] = email;
    _data["password"] = password;
    _data["firstName"] = firstName;
    _data["lastName"] = lastName;
    return _data;
  }
}