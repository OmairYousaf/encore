import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../network/api_client.dart';

class CHIExceptionHandler {
  static Future<APIResponse> exceptionWrapper(Future<APIResponse> Function() method) async {
    try {
      // debugPrint("--------------------------------");
      // debugPrint("POST TO:  $endpoint ");
      // debugPrint("--------------------------------");
      if (!ApiClient.isConnected) {
        int count = 0;
        while (true) {
          log('---------------------waiting for connection---------------------');
          await Future.delayed(const Duration(milliseconds: 1500));
          count += 1;
          if (ApiClient.isConnected) {
            break;
          }
          if (count == 5) {
            return {"status": "Error", "ErrorMessage": "Internet connection not available"};
          }
        }
      }
      return await method();
    } on TimeoutException catch (_) {
      return _jsonError('API Request timed out');
    } on SocketException catch (e) {
      return _jsonError(e.message);
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectionTimeout) {
        debugPrint(e.message);
        return _jsonError('Connection Time Out');
      }
      if (e.type == DioErrorType.sendTimeout) {
        debugPrint(e.message);
        return _jsonError('Request Time Out');
      }
      if (e.type == DioErrorType.receiveTimeout) {
        debugPrint(e.message);
        return _jsonError('Response Time Out');
      }
      if (e.type == DioErrorType.unknown) {
        debugPrint(e.message);
        final error = e.error as SocketException;
        return _jsonError(error.message);
      }
      if (CancelToken.isCancel(e)) {
        debugPrint('Request canceled! ${e.message}');
        return _jsonError(e.message);
        // return _jsonError('Unknown Error');
      } else {
        return _jsonError(e.response == null ? e.message : e.response!.data['message'] ?? '');
        // return _jsonError('Unknown Error');
      }
    } catch (e) {
      return _jsonError("$e");
    }
  }

  static Map<String, dynamic> _jsonError(String? errorMessage) {
    return {
      'status': 'Error',
      'message': errorMessage,
      'ErrorCode': -1,
    };
  }
}
