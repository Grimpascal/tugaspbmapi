import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthController{

  Future<bool> login(
    String username,
    String password,
  )async{
    final url = Uri.parse(
      'https://task.itprojects.web.id/api/auth/login'
    );

    final response = await http.post(
      url,
      headers: {
        'Content-Type' : 'application/json',
        'Accept' : 'application/json'
      },
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200){
      final data = jsonDecode(response.body);

      String token = data['data']['token'];

      SharedPreferences prefs = await SharedPreferences.getInstance();

      await prefs.setString('token', token);
      return true;
    }else{
      print(response.body);
      return false;
    }
  }

}