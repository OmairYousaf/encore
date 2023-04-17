// ignore_for_file: avoid_print, depend_on_referenced_packages
import 'dart:async';
import 'dart:developer';
import 'package:connectivity_checker/connectivity_checker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../exception_handler/chi_exception_handler.dart';
import 'internet_connectivity.dart';

typedef Request = Map<String, dynamic>;
typedef APIResponse = Map<String, dynamic>;
typedef ModelFromJson = dynamic Function(Map<String, dynamic> resp);

class ApiClient {
  static ApiClient? _instance;
  String mBaseUrl;
  String mSiteCode;
  static ApiClient? get instance => _instance;
  static SharedPreferences? prefs; // Omair on Ahmad's desk
  static String? userAgent = 'Dart/2.16 (dart:io)';
  static String authToken = '';
  List<Map<String, dynamic>> apiDetailedMap = [];

  static StreamSubscription? connectivitySubscription;
  static late StreamSubscription notifySubscription;
  static bool isConnected = true;
  static String wBaseUrl = '';
  ApiClient(this.mSiteCode, this.mBaseUrl);
  static BaseOptions? options;
  static Dio? _dio;
  static CancelToken cancelToken = CancelToken();
  static Future<ApiClient> create(
      String siteCode, String siteUrl, bool isCancled) async {
    _dispose();
    _connectivityListener();
    prefs = await SharedPreferences.getInstance();
    authToken = prefs!.getString('token') ?? '';
    // String baseUrl = 'https://$siteCode.$siteUrl';
    String baseUrl = 'http://10.8.100.91:3000';
    wBaseUrl = baseUrl;
    options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
    );
    _dio = Dio(options);
    _dio!.interceptors
        .add(LogInterceptor(responseBody: true, requestBody: true));
    _instance = ApiClient(siteCode, siteUrl);
    if (isCancled) {
      cancelToken = CancelToken();
    }
    // debugPrint("----------- API Client Created -----------");

    return _instance!;
  }

  static _connectivityListener() async {
    ConnectivityWrapper.instance.addresses =
        InternetConnectivity.DEFAULT_ADDRESSES;

    connectivitySubscription =
        ConnectivityWrapper.instance.onStatusChange.listen((status) {
      log('InternetConnectivity ---- Internet ---> $status');
      switch (status) {
        case ConnectivityStatus.CONNECTED:
          isConnected = true;
          log('InternetConnectivity ----- Internet --> connected');
          break;
        case ConnectivityStatus.DISCONNECTED:
          isConnected = false;
          log('InternetConnectivity ----- Internet --> disconnected');
          break;
      }
    });

    isConnected = await ConnectivityWrapper.instance.isConnected;
  }

  static Map<String, String> makeHeader() {
    String token = authToken;
    return <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': token,
      'User-Agent': userAgent!.toLowerCase(),
    };
  }

  static Map<String, String> makeHeaderFile({int? file}) {
    // debugPrint('>>>>>>fileSize in api header >>>>>>>>> $file');
    String token = authToken;
    return <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Content-Length': file != null ? '${file + 5000}' : '',
      'Authorization': token
    };
  }

  static Future<APIResponse> login(Map<String, dynamic> request,
      {ModelFromJson? fromJson}) async {
    return CHIExceptionHandler.exceptionWrapper(() async {
      final Response resp;
      resp = await _dio!.post(
        "/rms/v1/auth/login",
        options: Options(headers: makeHeader()),
        cancelToken: cancelToken,
        data: request,
      );
      print(resp);
      if (resp.statusCode == 200) {
        var json = resp.data;
        print("POSTED TO: /rms-stable/v1/auth/login");
        authToken = json['auth_token'] ?? "";
        if (fromJson != null) json = fromJson(json);
        final APIResponse data = {"data": json, "status": 'Ok'};
        return data;
      } else {
        return {
          "status": "Error",
          "ErrorMessage": "Something went wrong! Login Failed"
        };
      }
    });
  }

  static Future<APIResponse> post<T>(
      {required Request request,
      required String endPoint,
      ModelFromJson? fromJson}) async {
    return CHIExceptionHandler.exceptionWrapper(() async {
      final Response resp;
      resp = await _dio!.post(
        endPoint,
        options: Options(headers: makeHeader()),
        cancelToken: cancelToken,
        data: request,
      );
      debugPrint("posted: $endPoint");
      if (resp.statusCode! > 199 && resp.statusCode! < 205) {
        var json = resp.data;
        String status = 'Ok';
        if (fromJson != null) json = fromJson(json);
        final APIResponse data = {"data": json, "status": status};
        return data;
      } else {
        return {
          "status": "Error",
          "ErrorMessage": "Oops! something went wrong"
        };
      }
    });
  }

  static Future<APIResponse> get<T>(
      {required Request request,
      required String endPoint,
      ModelFromJson? fromJson}) async {
    return CHIExceptionHandler.exceptionWrapper(() async {
      final Response resp;
      resp = await _dio!.get(
        endPoint,
        options: Options(headers: makeHeader()),
        cancelToken: cancelToken,
        queryParameters: request,
      );
      debugPrint("posted: $resp");
      if (resp.statusCode! > 199 && resp.statusCode! < 205) {
        var json = resp.data;
        if (fromJson != null) json = fromJson(json);
        final APIResponse data = {"data": json, "status": 'Ok'};
        return data;
      } else {
        return {
          "status": "Error",
          "ErrorMessage": "Oops! something went wrong"
        };
      }
    });
  }

  static Future<APIResponse> postMultipart<T>(
      {required FormData request,
      required String endPoint,
      ModelFromJson? fromJson,
      int? file}) async {
    return CHIExceptionHandler.exceptionWrapper(() async {
      final Response? resp;
      resp = await _dio!.post(
        endPoint,
        options: Options(headers: makeHeaderFile(file: file)),
        cancelToken: cancelToken,
        data: request,
      );
      // debugPrint("posted: $endPoint");
      if (resp.statusCode == 200) {
        var json = resp.data;
        final status = json['Status'];
        if (fromJson != null) json = fromJson(json);
        final APIResponse data = {"data": json, "status": status};
        return data;
      } else {
        return {
          "status": "Error",
          "ErrorMessage": "Oops! something went wrong"
        };
      }
    });
  }

  static void _dispose() {
    if (connectivitySubscription != null) {
      connectivitySubscription!.cancel();
    }
  }
}
