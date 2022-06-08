class UserModel {
  //final String uid;
  final String email;
  final String password;
  final String username;
  final String bio;
  final String profilePic;
  UserModel(
      {required this.email,
      required this.password,
      required this.username,
      required this.bio,
      required this.profilePic});
}
