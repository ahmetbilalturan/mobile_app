class User {
  String imagePath;
  String name;
  String email;

  User({
    required this.imagePath,
    required this.name,
    required this.email,
  });

  void setName(String newName) {
    this.name = newName;
  }

  void setEmail(String newEmail) {
    this.email = newEmail;
  }
}
