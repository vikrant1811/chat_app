import 'package:app_chat/screens/loginpage.dart';
import 'package:app_chat/screens/registerpage.dart';
import 'package:flutter/material.dart';
class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  bool showLoginPage = true;
  void togglePages(){
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }
  @override
  Widget build(BuildContext context) {
    if(showLoginPage) {
      return LoginPage(onTap: togglePages);
    }
    else {
      return RegisterPage(onTap: togglePages);
    }
  }
}
