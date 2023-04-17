// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:connectivity_checker/connectivity_checker.dart';


const int DEFAULT_PORT = 53;
const Duration DEFAULT_TIMEOUT = const Duration(seconds: 10);

class InternetConnectivity {
  static InternetConnectivity? _instance;

  bool isConnected = true;
  StreamSubscription<ConnectivityStatus>? connectivitySubscription;

  InternetConnectivity() {
    onCancelSubscription();
    connectivityListener();
  }

  static InternetConnectivity get instance => _instance ??= InternetConnectivity();

  static const Map<String, String> dnsParameters = {
    'name': 'google.com',
    'type': 'A',
    'dnssec': '1',
  };

  static const Map<String, String> dnsHeaders = {
    'Accept': 'application/dns-json',
    'Cache-Control': 'no-cache',
    'Content-Type': 'application/json',
  };

  static const Duration DEFAULT_INTERVAL = Duration(seconds: 30);

  static final List<AddressCheckOptions> DEFAULT_ADDRESSES = [
    AddressCheckOptions(
      InternetAddress('1.1.1.1'),
      port: DEFAULT_PORT,
      timeout: DEFAULT_TIMEOUT,
    ),
    AddressCheckOptions(
      InternetAddress('8.8.4.4'),
      port: DEFAULT_PORT,
      timeout: DEFAULT_TIMEOUT,
    ),
    AddressCheckOptions(
      InternetAddress('208.67.222.222'),
      port: DEFAULT_PORT,
      timeout: DEFAULT_TIMEOUT,
    ),
  ];

  void connectivityListener() async {

    ConnectivityWrapper.instance.addresses = DEFAULT_ADDRESSES;
    ConnectivityWrapper.instance.checkInterval = DEFAULT_INTERVAL;


    connectivitySubscription = ConnectivityWrapper.instance.onStatusChange.listen((status) {
      log('-----------InternetConnectivity---- Stream---> $status');
      switch (status) {
        case ConnectivityStatus.CONNECTED:
          isConnected = true;
          log('-----------InternetConnectivity----- Stream--> connected');
          break;
        case ConnectivityStatus.DISCONNECTED:
          isConnected = false;
          log('-----------InternetConnectivity----- Stream--> disconnected');
          break;
      }
    });

    isConnected = await ConnectivityWrapper.instance.isConnected;
  }

  static Future<bool> isInternetConnected() async {
    bool connected = await ConnectivityWrapper.instance.isConnected;
    log('-----------Internet Available ? -----> $connected--');
    return connected;
  }

  onCancelSubscription() {
    if (connectivitySubscription != null) {
      connectivitySubscription!.cancel();
    }
  }
}
