// Modelo de usuario
class User {
  final int id;
  final String firstName;
  final String lastName;
  final String dni;
  final String email;
  final String password;
  final String userType; // Puede ser 'client' o 'admin'

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.dni,
    required this.email,
    required this.password,
    required this.userType,
  });

  // Convertir un User a un Map para la base de datos
  Map<String, Object?> toMap() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'dni': dni,
      'email': email,
      'password': password,
      'user_type': userType,
    };
  }

  // Convertir un Map en un User
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      firstName: map['first_name'],
      lastName: map['last_name'],
      dni: map['dni'],
      email: map['email'],
      password: map['password'],
      userType: map['user_type'],
    );
  }

  @override
  String toString() {
    return 'User{firstName: $firstName, lastName: $lastName, dni: $dni, email: $email, userType: $userType}';
  }
}
