
class User {
  final int id;
  final String username;
  final String email;
  final String firstName;
  final String lastName;
  final bool isActive;
  String accessToken;
  String refreshToken;

  User({this.id, this.username, this.email, this.firstName, this.lastName, this.isActive, this.accessToken, this.refreshToken});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      isActive: json['is_active'],
      accessToken: json['access_token'],
      refreshToken: json['refresh_token']
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'username': username,
    'email': email,
    'firstName': firstName,
    'lastName': lastName,
    'is_active': isActive,
    'access_token': accessToken,
    'refresh_token': refreshToken
  };


  @override
  String toString() {
    return "$id | $username | $email | $accessToken | $refreshToken";
  }
}