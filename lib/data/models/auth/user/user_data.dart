class UserData {
  String? userId;
  String? email;
  String? fullName;
  dynamic profilePicture;

  UserData({this.userId, this.email, this.fullName, this.profilePicture});

  UserData.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? json; // ✅ خد من data لو موجودة، لو لأ خد الـ json نفسه
    userId = data["userId"];
    email = data["email"];
    fullName = data["fullName"];
    profilePicture = data["profilePicture"];
  }

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "email": email,
      "fullName": fullName,
      "profilePicture": profilePicture,
    };
  }

  @override
  String toString() {
    return 'UserData(userId: $userId, email: $email, fullName: $fullName, profilePicture: $profilePicture)';
  }
}