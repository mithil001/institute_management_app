/*
 *  Created by Mithil Devkar
 *  Internet Alert Service
 */

import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import '../dialogs/confirmation_dialog.dart';
import 'internet_service.dart';

class InternetAlert with WidgetsBindingObserver {
  InternetAlert._();

  static final InternetAlert _instance = InternetAlert._();

  factory InternetAlert() => _instance;

  StreamSubscription<List<ConnectivityResult>>? _subscription;

  bool _dialogVisible = false;

  //==========================================================================
  // START LISTENING
  //==========================================================================

  void start() {
    WidgetsBinding.instance.addObserver(this);

    _checkConnection();

    _subscription = Connectivity()
        .onConnectivityChanged
        .listen((_) => _checkConnection());
  }

  //==========================================================================
  // APP RESUME
  //==========================================================================

  @override
  void didChangeAppLifecycleState(
      AppLifecycleState state,
      ) {
    if (state == AppLifecycleState.resumed) {
      Future.delayed(
        const Duration(milliseconds: 300),
        _checkConnection,
      );
    }
  }

  //==========================================================================
  // CONNECTION CHECK
  //==========================================================================

  Future<void> _checkConnection() async {
    final connected =
    await InternetConnection().hasInternetAccess;

    InternetService.to.hasInternet.value = connected;

    if (!connected) {
      if (!_dialogVisible || Get.isDialogOpen != true) {
        _dialogVisible = true;
        _showDialog();
      }
    } else {
      if (_dialogVisible && Get.isDialogOpen == true) {
        Get.back();
      }

      _dialogVisible = false;
    }
  }

  //==========================================================================
  // DIALOG
  //==========================================================================

  void _showDialog() {
    ConfirmationDialog.show(
      title: "No Internet Connection",
      message:
      "Please check your internet connection and try again.",
      confirmText: "Retry",
      showCancel: false,
      onConfirm: () async {
        await _checkConnection();
      },
    );
  }

  // DISPOSE

  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    _subscription?.cancel();
  }
}