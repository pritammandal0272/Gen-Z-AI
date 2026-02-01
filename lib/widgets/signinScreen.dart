import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voice_assistant/controller/dataBase/readValuesDB.dart';
import 'package:voice_assistant/controller/functions/googleLogin.dart';
import 'package:voice_assistant/controller/getxController.dart';
import 'package:voice_assistant/screens/sharePreference/loginScreen.dart';
import 'package:voice_assistant/screens/mainScreen.dart';
import 'package:voice_assistant/widgets/snackBar.dart';

class LoginBottomSheetState extends State<LoginBottomSheet> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final GlobalKey<FormState> fromKey = GlobalKey<FormState>();
  final getxObj = Get.find<getController>();
  late SharedPreferences sp;
  @override
  void initState() {
    call();
    super.initState();
  }

  void call() async {
    getxObj.passwordFlag.value = false;
    sp = await SharedPreferences.getInstance();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.60,
      minChildSize: 0.40,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) => Container(
        decoration: BoxDecoration(
          gradient: !getxObj.darkMode.value
              ? LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFFFFFFF), // Pure White
                    Color(0xFFF7F7F7), // Very Light Gray
                    Color(0xFFEFEFEF),
                  ],
                )
              : LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromARGB(255, 39, 64, 105),
                    Color(0xFF121A2F),
                    Color(0xFF0B0F1A),
                  ],
                ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
        ),
        child: ListView(
          controller: scrollController,

          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 20,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 5,
                  children: [
                    Text(
                      'Welcome Back',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Login to your account',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                ),
                Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: fromKey,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: _validatorCheck,

                        controller: _emailController,

                        cursorColor: Colors.blue,
                        textInputAction: TextInputAction.newline,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color.fromARGB(40, 33, 149, 243),
                          contentPadding: const EdgeInsets.fromLTRB(
                            12,
                            14,
                            0,
                            14,
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              width: 0.5,
                              color: Colors.red,
                            ),
                          ),
                          hintText: 'Email or Phone Number',
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            color: Colors.blueGrey,
                          ),
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 17,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              width: 0.5,
                              color: Colors.blue,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),

                            borderSide: BorderSide(
                              color: Colors.blue,
                              width: 0.5,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              width: 0.5,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),

                      Obx(
                        () => TextFormField(
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Fill the TextBox !!";
                            } else {
                              return null;
                            }
                          },
                          controller: _passwordController,
                          cursorColor: Colors.blue,
                          textInputAction: TextInputAction.newline,
                          keyboardType: TextInputType.multiline,
                          obscureText: getxObj.passwordFlag.value,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color.fromARGB(40, 33, 149, 243),
                            contentPadding: const EdgeInsets.fromLTRB(
                              12,
                              14,
                              0,
                              14,
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                width: 0.5,
                                color: Colors.red,
                              ),
                            ),
                            hintText: 'Password',

                            prefixIcon: Icon(
                              Icons.lock_outline,
                              color: Colors.blueGrey,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () => getxObj.passwordFlag.value =
                                  !getxObj.passwordFlag.value,
                              icon: Icon(
                                getxObj.passwordFlag.value
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: !getxObj.passwordFlag.value
                                    ? Colors.blueGrey
                                    : Colors.blue,
                              ),
                            ),

                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 17,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                width: 0.5,
                                color: Colors.blue,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),

                              borderSide: BorderSide(
                                color: Colors.blue,
                                width: 0.5,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                width: 0.5,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                              color: Color(0xFF50C9C3),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      if (fromKey.currentState!.validate()) {
                        _signInUser(
                          _emailController.text,
                          _passwordController.text,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 47, 139, 244),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.arrow_forward),
                      ],
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(child: Divider(color: Colors.blueGrey)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'or continue with',
                        style: TextStyle(color: Colors.blueGrey),
                      ),
                    ),
                    Expanded(child: Divider(color: Colors.blueGrey)),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () async {
                          final data = await GoogleLoginService()
                              .signInWithGoogleEmail();

                          if (data == null) {
                            showSnackbarFunction(
                              context,
                              "Try again!",
                              Colors.red,
                              Icons.cancel,
                            );
                          } else {
                            bool chekUserExits = await checkUserExists(
                              data.email,
                            );
                            if (chekUserExits) {
                              showSnackbarFunction(
                                context,
                                "Email id Not Exists!\nPlease Create Account",
                                Colors.red,
                                Icons.info,
                              );
                              GoogleLoginService().logout();
                            } else {
                              sp.setBool("googleLogin", true);
                              await sp.setString("isEmail", data.email);
                              Get.offAll(
                                () => MainScreen(data: {"email": data.email}),
                                transition: Transition.zoom,
                              );
                              showSnackbarFunction(
                                context,
                                "Login Successfully !!",
                                Colors.blue,
                                Icons.check_circle_outline,
                              );
                            }
                          }
                        },
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          side: BorderSide(color: Colors.grey[300]!),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/googleLogo.png",
                              height: 20,
                              width: 20,
                            ),
                            SizedBox(width: 3),
                            Text(
                              'Google',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _signInUser(email, password) async {
    bool chekUserExits = await checkUserExists(email);
    if (chekUserExits) {
      showSnackbarFunction(
        context,
        "Invalid Email or Phone No !!",
        Colors.red,
        Icons.info,
      );
    } else {
      bool check = await checkUserLogin(email, password);
      if (check) {
        await sp.setString("isEmail", email);
        Get.offAll(
          () => MainScreen(data: {"email": email}),
          transition: Transition.zoom,
        );
        showSnackbarFunction(
          context,
          "Login Successfully !!",
          Colors.blue,
          Icons.check_circle_outline,
        );
      } else {
        showSnackbarFunction(
          context,
          "Invalid Email or Phone No & Password!!",
          Colors.red,
          Icons.info,
        );
      }
    }
  }
}

String? _validatorCheck(value) {
  final emailCheck = !RegExp(
    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
  ).hasMatch(value.trim());
  final phCheck = !RegExp(r'^[6-9]\d{9}$').hasMatch(value.trim());
  if (emailCheck && phCheck) {
    return "Enter valid email or mobile number !!";
  } else {
    return null;
  }
}
