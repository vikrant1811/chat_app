import 'package:app_chat/services/auth/authservice.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/button.dart';
import '../components/textfield.dart';
class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({super.key,required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

    final emailController =TextEditingController();
    final passwordController = TextEditingController();
    final confirmpasswordController = TextEditingController();

   void signUp() async {
      if (passwordController.text != confirmpasswordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("confirm password must be same as password!"),
            )
        );
        return;
      }
      // get auth service
      final authService = Provider.of<AuthService>(context, listen: false);
      try {
        await authService.signUpWithEmailandpassword(
            emailController.text,
            passwordController.text);
      }
      catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e.toString()),
            ),
        );
      }

    }

    @override
    Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 10,),
                SizedBox(height: 100,width: 100,
                    child: Image.asset("assets/images/img_login&reg.jpeg")),
                const SizedBox(height: 5,),
                const Text("Create Account",
                  style: TextStyle(
                      fontSize:25,color: Colors.white ),
                ),
                const SizedBox(height: 10,),
                MyTextField(
                  controller: emailController,
                  hintText: "Email",
                  obscureText: false,
                ),
                const SizedBox(height: 10,),
                MyTextField(
                  controller: passwordController,
                  hintText: "password",
                  obscureText: true,
                ),
                const SizedBox(height: 10,),
                MyTextField(
                  controller: confirmpasswordController,
                  hintText: "confirm password",
                  obscureText: true,
                ),
                const SizedBox(height: 10,),
                MyButton(
                  onTap: signUp,
                  text: "Sign Up",
                ),
                const SizedBox(height: 10,),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an Account??',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white
                      ),),
                    const SizedBox(width: 4,),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text('Login now!!',
                        style: TextStyle(fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),),
                    ),
                  ],
                ),


              ],
            ),
          ),
        ),
      ),
    );
  }
}

