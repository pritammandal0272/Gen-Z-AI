import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voice_assistant/controller/dataBase/insertValueDB.dart';
import 'package:voice_assistant/controller/dataBase/readValuesDB.dart';
import 'package:voice_assistant/widgets/snackBar.dart';

import '../getxController.dart';

class FirebaseController {
  static final _firebase = FirebaseFirestore.instance;
  static final getxObj = Get.find<getController>();
  static Future<bool> signupFirebase(
    BuildContext context,
    Map<String, dynamic> signupData,
  ) async {
    getxObj.isLogedInLoader.value = true;

    try {
      QuerySnapshot value = await _firebase
          .collection("users")
          .where("email", isEqualTo: signupData["email"])
          .get();

      if (value.docs.isEmpty) {
        await _firebase.collection("users").add(signupData);

        if (context.mounted) {
          showSnackbarFunction(
            context,
            "Signed up successfully",
            Colors.green,
            Icons.check,
          );
        }

        return true;
      } else {
        if (context.mounted) {
          showSnackbarFunction(
            context,
            "Email already exists",
            Colors.red,
            Icons.error,
          );
        }

        return false;
      }
    } catch (e) {
      if (context.mounted) {
        showSnackbarFunction(
          context,
          "Error signing up",
          Colors.red,
          Icons.error,
        );
      }

      log("mm" + e.toString());
      return false;
    } finally {
      getxObj.isLogedInLoader.value = false;
    }
  }

  static Future<bool> loginFirebase(
    BuildContext context,
    Map<String, dynamic> signinData,
  ) async {
    getxObj.isLogedInLoader.value = true;
    try {
      QuerySnapshot value = await FirebaseFirestore.instance
          .collection("users")
          .where("email", isEqualTo: signinData["email"])
          .get();

      if (value.docs.isEmpty) {
        if (context.mounted) {
          showSnackbarFunction(
            context,
            "Email does not exist",
            Colors.red,
            Icons.error,
          );
        }

        return false;
      } else {
        final user = value.docs.first.data() as Map<String, dynamic>;

        if (user["password"] == signinData["password"]) {
          bool chekUserExits = await checkUserExists(user["email"]);
          if (chekUserExits) {
            await insertValueDB(
              user["name"],
              user["email"],
              user["password"],
              "",
            );
          }
          if (context.mounted) {
            showSnackbarFunction(
              context,
              "Logged in successfully",
              Colors.green,
              Icons.check,
            );
          }

          return true;
        } else {
          if (context.mounted) {
            showSnackbarFunction(
              context,
              "Incorrect password",
              Colors.red,
              Icons.error,
            );
          }

          return false;
        }
      }
    } catch (e) {
      if (context.mounted) {
        showSnackbarFunction(context, "Login error", Colors.red, Icons.error);
      }

      log(e.toString());
      return false;
    } finally {
      getxObj.isLogedInLoader.value = false;
    }
  }

  static Future updateProfile(BuildContext context, type, data) async {
    try {
      QuerySnapshot userQuery = await _firebase
          .collection("users")
          .where("email", isEqualTo: data["email"])
          .get();
      if (userQuery.docs.isNotEmpty) {
        DocumentReference userReference = userQuery.docs.first.reference;
        if (type == "name") {
          getxObj.isLogedInLoader.value = true;
          await userReference.update({"name": data["name"]});
          showSnackbarFunction(
            context,
            "Name Changes Successfully",
            Colors.blue,
            Icons.check_circle,
          );
        } else if (type == "email") {
          getxObj.isChangeEmailLoader.value = true;
          await userReference.update({"email": data["changeEmail"]});
          showSnackbarFunction(
            context,
            "Email Changes Successfully",
            Colors.blue,
            Icons.check_circle,
          );
        } else if (type == "password") {
          getxObj.isChangePasswordLoader.value = true;
          QuerySnapshot userQueryData = await _firebase
              .collection("users")
              .where("email", isEqualTo: data["email"])
              .get();
          final oldpassword = userQueryData.docs.first["password"];
          if (oldpassword == data["oldpassword"]) {
            await userReference.update({"password": data["newpassword"]});
            showSnackbarFunction(
              context,
              "Password Changes Successfully",
              Colors.blue,
              Icons.check_circle,
            );
            return true;
          } else {
            showSnackbarFunction(
              context,
              "Old Password Not Matched!",
              Colors.red,
              Icons.cancel,
            );
            return false;
          }
        }
      }
    } catch (e) {
      showSnackbarFunction(
        context,
        "Error updating profile",
        Colors.red,
        Icons.error,
      );
      log(e.toString());
    } finally {
      getxObj.isLogedInLoader.value = false;
      getxObj.isChangeEmailLoader.value = false;
      getxObj.isChangePasswordLoader.value = false;
    }
  }
}
