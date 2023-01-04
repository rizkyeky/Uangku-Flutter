part of _model;

class Profile {
  User? user;
  String name;

  Profile({
    required this.user,
    required this.name,
  });

  // toJson
  Map<String, dynamic> toJson() {
    return {
      'id': user?.id,
      'name': name,
    };
  }

  // fromJson
  factory Profile.fromJsonAndUser(Map<String, dynamic> json, User? user) {
    return Profile(
      user: user,
      name: json['name'],
    );
  }
}