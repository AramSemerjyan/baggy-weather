/// I was preparing to implement user authentication and user data caching
/// yeah... sure... I guess nothing of it in the project, right? I knew that...
class UserModel {
  final String email;
  final String name;

  UserModel({required this.email, required this.name});

  factory UserModel.guest() => UserModel(email: "guest_email", name: "Guest");

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      UserModel(email: json['email'], name: json['name']);

  Map<String, dynamic> toJson() => {'email': email, 'name': name};
}
