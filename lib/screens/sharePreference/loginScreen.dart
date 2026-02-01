import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:rainbow_edge_lighting/rainbow_edge_lighting.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:text_gradiate/text_gradiate.dart';
import 'package:voice_assistant/controller/getxController.dart';
import 'package:voice_assistant/screens/mainScreen.dart';
import 'package:voice_assistant/widgets/signUpScreen.dart';
import 'package:voice_assistant/widgets/signinScreen.dart';
import 'package:voice_assistant/widgets/snackBar.dart';

void showSignUpBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SignUpBottomSheet(),
      );
    },
  );
}

void showLoginBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: const LoginBottomSheet(),
      );
    },
  );
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

late SharedPreferences sp;

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    call();
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );
    super.initState();
  }

  void call() async {
    sp = await SharedPreferences.getInstance();
  }

  final getxObj = Get.find<getController>();
  @override
  Widget build(BuildContext context) {
    // final colorsScheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
        ),
        child: Container(
          height: double.infinity,
          width: double.infinity,
          // decoration: BoxDecoration(
          //   gradient: LinearGradient(
          //     begin: Alignment.topCenter,
          //     end: Alignment.bottomCenter,
          //     colors: [Color(0xFF0B2233), Color(0xFF071B2A), Color(0xFF05131E)],
          //   ),
          // ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                // Robot Icon with Circle
                Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    Positioned.fill(
                      child: Center(
                        child: ImageFiltered(
                          imageFilter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
                          child: Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color(0xFF5B8CFF).withOpacity(0.20),
                            ),
                          ),
                        ),
                      ),
                    ),

                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: 150,
                          width: 150,
                          padding: EdgeInsets.all(25),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(300),
                            border: Border.all(
                              color: Colors.blueAccent,
                              width: 2,
                            ),
                            image: DecorationImage(
                              image: AssetImage("assets/appLogo.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(112, 0, 0, 0),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        RainbowEdgeLighting(
                          glowEnabled: true,
                          radius: 200,
                          thickness: 6,
                          speed: 0.5,

                          colors: smoothLoop(const [
                            Color(0xFF3B4CFF),
                            Color(0xFF5B3BFF),
                            Color(0xFF3B9DFF),
                          ]),
                          clip: false,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage("assets/appLogo.png"),
                                fit: BoxFit.cover,
                              ),
                            ),
                            alignment: Alignment.center,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                SizedBox(height: 40),
                TextGradiate(
                  text: Text(
                    "Sign in to continue",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  colors: [Color(0xFF7B61FF), Color(0xFF5A8DFF)],
                  gradientType: GradientType.linear,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                SizedBox(height: 12),
                Text(
                  'Your smart assistant is ready',
                  style: TextStyle(fontSize: 17, color: Colors.blueGrey),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.17),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: OutlinedButton(
                          onPressed: () => showSignUpBottomSheet(context),
                          style: OutlinedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(
                              40,
                              33,
                              149,
                              243,
                            ),
                            foregroundColor: getxObj.darkMode.value
                                ? Colors.white
                                : Colors.black,
                            side: BorderSide(color: Colors.blue, width: 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
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

                      SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: () => showLoginBottomSheet(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(
                              40,
                              33,
                              149,
                              243,
                            ),
                            foregroundColor: getxObj.darkMode.value
                                ? Colors.white
                                : Colors.black,
                            side: BorderSide(color: Colors.blue, width: 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 0,
                          ),
                          child: Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),

                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: () {
                            getxObj.loaderLoginGuest.value = true;
                            loginGuest();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(
                              40,
                              33,
                              149,
                              243,
                            ),
                            foregroundColor: getxObj.darkMode.value
                                ? Colors.white
                                : Color(0xFF1E40FF),
                            side: BorderSide(
                              color: Color(0xFF1E40FF),
                              width: 1,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 0,
                          ),
                          child: Obx(
                            () => Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              spacing: 7,
                              children: [
                                getxObj.loaderLoginGuest.value
                                    ? SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 3,
                                        ),
                                      )
                                    : SizedBox(),
                                Icon(
                                  Icons.person_outline,
                                  size: 25,
                                  color: getxObj.darkMode.value
                                      ? Colors.white
                                      : Color(0xFF1E40FF),
                                ),
                                Text(
                                  'Continue as Guest',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 48),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void loginGuest() async {
    Timer.periodic(Duration(seconds: 3), (timer) {
      if (!mounted) return;
      getxObj.loaderLoginGuest.value = false;

      showSnackbarFunction(
        context,
        "Login as a Guest Successfully",
        Colors.blue,
        Icons.check_circle_outline,
      );
      sp.setString("isEmail", "");
      Get.offAll(
        () => MainScreen(data: {"email": ""}),
        transition: Transition.zoom,
      );
    });
  }
}

class LoginBottomSheet extends StatefulWidget {
  const LoginBottomSheet({super.key});
  @override
  State<LoginBottomSheet> createState() => LoginBottomSheetState();
}

class SignUpBottomSheet extends StatefulWidget {
  const SignUpBottomSheet({super.key});
  @override
  State<SignUpBottomSheet> createState() => SignUpBottomSheetState();
}
