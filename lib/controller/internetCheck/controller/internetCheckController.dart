import 'dart:async';
import 'dart:developer';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:voice_assistant/controller/getxController.dart';

List<ConnectivityResult> _connectionStatus = [ConnectivityResult.none];
final Connectivity connectivity = Connectivity();
// late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

Future<void> initConnectivity() async {
  late List<ConnectivityResult> result;
  // Platform messages may fail, so we use a try/catch PlatformException.
  try {
    result = await connectivity.checkConnectivity();
  } on PlatformException catch (e) {
    log('Couldn\'t check connectivity status', error: e);
    return;
  }

  return updateConnectionStatus(result);
}

Future<void> updateConnectionStatus(List<ConnectivityResult> result) async {
  final getxObj = Get.find<getController>();
  _connectionStatus = result;
  final bool data =
      _connectionStatus.isNotEmpty &&
      _connectionStatus[0] != ConnectivityResult.none;
  getxObj.checkInterNet.value = data;
}
