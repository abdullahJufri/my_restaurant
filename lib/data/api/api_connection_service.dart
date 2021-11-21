import 'package:flutter/material.dart';
import 'dart:async';
import 'package:data_connection_checker/data_connection_checker.dart';

class DataService {
  bool connected;
  String message;
  DataConnectionStatus dataConnectionStatus;
  DataService({this.connected, this.message, this.dataConnectionStatus});
}

class ConnectionService {
  Future<DataService> connectionService(BuildContext context) async {
    bool connected;
    String message = '';
    final connection = await DataConnectionChecker().connectionStatus;
    if (connection == DataConnectionStatus.connected) {
      connected = true;
    } else {
      connected = false;
      message = 'Disconnect, please turn on your internet.';
    }
    return DataService(connected: connected, message: message);
  }
}
