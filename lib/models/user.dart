class User {
  final String name;
  final String password;
  final int number;
  final String email; 
  final String description; 

  const User(
      {required this.name, required this.password, required this.number, required this.email, required this.description});

  get getName => name; 
  get getPassword => password; 
  get getNumber => number; 
  get getEmail => email; 
  get getDescription => description;
}
