import 'package:flutter/material.dart';
import 'package:voice_assistant/controller/functions/googleLogin.dart';

class GoogleGoogleUI extends StatefulWidget {
  GoogleGoogleUI({super.key});

  @override
  State<GoogleGoogleUI> createState() => _GoogleGoogleUIState();
}

class _GoogleGoogleUIState extends State<GoogleGoogleUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          GoogleLoginService().logout();
        },
      ),
      body: Center(
        child: TextButton(
          onPressed: () {
            GoogleLoginService().signInWithGoogleEmail();
          },
          child: Text("Login"),
        ),
      ),
    );
  }
}

// foundit
