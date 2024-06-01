import 'dart:async';

import 'package:app_chat/services/auth/authgate.dart';
import 'package:flutter/material.dart';
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
{

  startTimer()
  {
    Timer(const Duration(seconds: 3), () async {
      //send user to authGate
      Navigator.push(context, MaterialPageRoute(builder: (c) => const AuthGate()));

    });
  }
  @override
  void initState() {
    super.initState();
    startTimer();
  }
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/img_splashchat.png"),
              const Text("Keep chatting!!",style: TextStyle(fontSize:35,
                  fontWeight:FontWeight.w700),),
            ],
          ),

        ),
      ),
    );
  }
}
