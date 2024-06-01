import 'package:app_chat/components/button.dart';
import 'package:app_chat/components/textfield.dart';
import 'package:app_chat/services/auth/authservice.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  const LoginPage({super.key,required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

    final emailController =TextEditingController();
    final passwordController = TextEditingController();
    void signIn() async{
      //get the auth service
      final authService = Provider.of<AuthService>(context, listen:false);

      try {
        await authService.signInWithEmailandpassword(
            emailController.text,
            passwordController.text,);

      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              e.toString(),
            ),
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
                SizedBox(height: 120,width: 120,
                    child: Image.asset("assets/images/img_login&reg.jpeg")),

                const SizedBox(height: 10,),
                const Text("Welcome back",
                  style: TextStyle(
                      fontSize:35,color: Colors.white ),
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
                MyButton(
                    onTap: signIn,
                    text: "Sign In",
                ),
                const SizedBox(height: 10,),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have Account??",
                      style: TextStyle(fontSize: 17,color: Colors.white),),
                    const  SizedBox(width: 10,),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text('Register Now',
                      style: TextStyle(fontSize: 18,
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
