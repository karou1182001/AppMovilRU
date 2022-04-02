class User {
  final String name;
  final String password;
  final int number;
  final String email; 

  const User(
      {required this.name, required this.password, required this.number, required this.email});

  get getName => name; 
  get getPassword => password; 
  get getNumber => number; 
  get getEmail => email; 
}
