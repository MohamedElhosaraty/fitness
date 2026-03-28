class UserModel {
  final String email;
  final String name;
  final String uId;
  final String? imageUrl;

  UserModel({
    required this.email,
    required this.name,
    required this.uId,
    this.imageUrl,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uId: map['uId'] ?? '',
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uId': uId,
      'email': email,
      'name': name,
      'imageUrl': imageUrl,
    };
  }
}