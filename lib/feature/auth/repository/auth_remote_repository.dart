import 'package:http/http.dart' as http;

class AuthRemoteRepository{
  Future<void> signup({
    required String name,
    required String email,
    required String password,
}) async{
    final response = await http.post(Uri.parse('http://0.0.0.0:8000/auth/signup'),
      body: {
        'name': name,
        'email': email,
        'password': password
      },
    );
  }
  Future<void> login() async{

  }
}