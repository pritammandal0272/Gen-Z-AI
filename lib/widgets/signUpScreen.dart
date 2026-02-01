import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voice_assistant/controller/dataBase/insertValueDB.dart';
import 'package:voice_assistant/controller/dataBase/readValuesDB.dart';
import 'package:voice_assistant/controller/functions/googleLogin.dart';
import 'package:voice_assistant/controller/getxController.dart';
import 'package:voice_assistant/screens/mainScreen.dart';
import 'package:voice_assistant/screens/sharePreference/loginScreen.dart';
import 'package:voice_assistant/widgets/snackBar.dart';

class SignUpBottomSheetState extends State<SignUpBottomSheet> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> fromKey = GlobalKey<FormState>();
  final loginGetx = getController();
  late SharedPreferences sp;

  @override
  void initState() {
    call();
    super.initState();
  }

  void call() async {
    sp = await SharedPreferences.getInstance();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  final getxObj = Get.find<getController>();

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.73,
      minChildSize: 0.5,
      maxChildSize: 0.95,
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
              spacing: 20,
              crossAxisAlignment: CrossAxisAlignment.start,
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
                  spacing: 2,
                  children: [
                    Text(
                      'Create Account',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Sign up to get started',
                      style: TextStyle(fontSize: 16, color: Colors.blueGrey),
                    ),
                  ],
                ),

                Column(
                  children: [
                    Form(
                      key: fromKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Column(
                        spacing: 13,
                        children: [
                          TextFormField(
                            controller: _nameController,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "Fill the TextBox !!";
                              } else {
                                return null;
                              }
                            },
                            style: TextStyle(color: Colors.white),
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
                              hintText: 'Enter Full Name',
                              prefixIcon: Icon(
                                Icons.person_outline,
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

                          TextFormField(
                            controller: _emailController,
                            validator: _validatorCheck,
                            style: TextStyle(color: Colors.white),
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

                          Obx(
                            () => TextFormField(
                              controller: _passwordController,
                              obscureText: loginGetx.passwordFlag.value,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return "Fill the TextBox !!";
                                } else {
                                  return null;
                                }
                              },
                              style: TextStyle(color: Colors.white),
                              cursorColor: Colors.blue,
                              textInputAction: TextInputAction.newline,
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: const Color.fromARGB(
                                  40,
                                  33,
                                  149,
                                  243,
                                ),
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
                                  onPressed: () =>
                                      loginGetx.passwordFlag.value =
                                          !loginGetx.passwordFlag.value,
                                  icon: Icon(
                                    loginGetx.passwordFlag.value
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: !loginGetx.passwordFlag.value
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

                          Obx(
                            () => TextFormField(
                              controller: _confirmPasswordController,
                              obscureText: loginGetx.confirmPasswordFlag.value,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return "Fill the TextBox !!";
                                } else {
                                  return null;
                                }
                              },
                              style: TextStyle(color: Colors.white),
                              cursorColor: Colors.blue,
                              textInputAction: TextInputAction.newline,
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: const Color.fromARGB(
                                  40,
                                  33,
                                  149,
                                  243,
                                ),
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
                                hintText: 'Confirm Password',
                                prefixIcon: Icon(
                                  Icons.lock_outline,
                                  color: Colors.blueGrey,
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () =>
                                      loginGetx.confirmPasswordFlag.value =
                                          !loginGetx.confirmPasswordFlag.value,
                                  icon: Icon(
                                    loginGetx.confirmPasswordFlag.value
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: !loginGetx.confirmPasswordFlag.value
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
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      if (fromKey.currentState!.validate()) {
                        _signUpUser(
                          _nameController.text,
                          _emailController.text,
                          _passwordController.text,
                          _confirmPasswordController.text,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 53, 141, 241),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
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
                          bool checkEmailExist = await checkUserExists(
                            data?.email,
                          );
                          if (data != null) {
                            if (checkEmailExist) {
                              showSnackbarFunction(
                                context,
                                "Set Password",
                                Colors.teal,
                                Icons.info,
                              );
                              _emailController.text = data.email;
                              _nameController.text = data.displayName;
                              await GoogleLoginService().logout();
                            } else {
                              showSnackbarFunction(
                                context,
                                "Email allready Exits!",
                                Colors.red,
                                Icons.cancel,
                              );
                              await GoogleLoginService().logout();
                            }
                          } else {
                            showSnackbarFunction(
                              context,
                              "Login Failed!",
                              Colors.red,
                              Icons.cancel,
                            );
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

                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account? ',
                        style: TextStyle(color: Colors.blueGrey),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                            color: Color(0xFF4A90E2),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _signUpUser(name, email, password, confirmPassword) async {
    if (password != confirmPassword) {
      showSnackbarFunction(
        context,
        "Confirm Password not Matched",
        Colors.red,
        Icons.info,
      );
    } else {
      bool checkEmailExist = await checkUserExists(email);
      if (checkEmailExist) {
        final check = await insertValueDB(name, email, password, "");
        if (check) {
          showSnackbarFunction(
            context,
            "Account Create Successfully",
            Colors.blue,
            Icons.check_circle_outline,
          );
          await sp.setString("isEmail", email);
          Get.offAll(
            () => MainScreen(data: {"email": email}),
            transition: Transition.zoom,
          );
        } else {
          showSnackbarFunction(
            context,
            "Account Not Created!",
            Colors.deepOrange,
            Icons.info,
          );
        }
      } else {
        showSnackbarFunction(
          context,
          "Email or Phone No allready Exits !!",
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
