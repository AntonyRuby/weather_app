// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';

// import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:weather_app/authentication/bloc/authentication_bloc.dart';
// import 'package:weather_app/http/http_url.dart';

// class DioHelper {
//   Dio dio = Dio();

//   bool isMaintanence = false;
//   DioHelper() {
//     // dio.options.baseUrl = HttpUrl.baseUrl;
//     dio.options.followRedirects = true;
//     // dio.options.receiveDataWhenStatusError = true;

//     dio.options.headers[HttpHeaders.acceptHeader] = "application/json";
//     dio.options.validateStatus = (status) {
//       return status < 400;
//     };

//     dio.transformer = JsonTransformer();
//     //setup auth interceptor
//     _setupAuthInterceptor();
//     //setup log interceptor
//     _setupLogInterceptor();
//     // _setupRetryInterceptor();
//   }

//   static FutureOr<bool> checkDioRetry(DioError error) {
//     // AppUtils.showErrorToast(error.message);
//     return error.type == DioErrorType.DEFAULT;
//   }

//   // ignore: always_declare_return_types
//   _setupAuthInterceptor() async {
//     dio.interceptors.add(
//       InterceptorsWrapper(onRequest: (options) async {
//         final String accessToken = await PreferenceHelper.getAccessToken();
//         final String refreshToken = await PreferenceHelper.getRefreshToken();

//         final String entityId = await PreferenceHelper.getEntityId();
//         final String mobileNumber = await PreferenceHelper.getMobileNumber();

//         if (accessToken == null || refreshToken == null) {
//           //no token proceed with request
//           options.headers["Authorization"] = "Basic YWRtaW46YWRtaW4=";
//           return options;
//         } else {
//           options.headers["accesstoken"] = "JWT" + " " + accessToken;
//           options.headers["refreshtoken"] = "JWT" + " " + refreshToken;
//           options.headers["BUSINESSID"] = entityId;
//           options.headers["MOBILE"] = mobileNumber;
//           return options;
//         }
//       }, onError: (DioError error) async {
//         if (error.type == DioErrorType.RESPONSE) {
//           final GenericResponse response = GenericResponse.fromJson(
//               error.response.data as Map<String, dynamic>);
//           final ValidateApiEncryptModel encryptModel =
//               await response.getEncryptModel();

//           switch (error.response.statusCode) {
//             case 401:
//               if (encryptModel.exception != null) {
//                 if (encryptModel.exception.detailMessage ==
//                         "Unauthorized: Token mismatch" ||
//                     encryptModel.exception.detailMessage ==
//                         "UnAuthorized: User details mismatch") {
//                   _showToast('Session expired. Please Login');
//                   eventBus.fire(SessionLogout());
//                 }
//               }

//               break;
//             default:
//               if (encryptModel.exception != null) {
//                 _showToast(encryptModel.exception.detailMessage);
//               } else {
//                 _showToast(StringResource.somethingWentWrong);
//               }

//               break;
//           }
//         } else if (error.type == DioErrorType.DEFAULT) {
//           try {
//             final result = await InternetAddress.lookup('google.com');
//             if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
//               // _showToast('Something went wrong');
//             }
//           } on SocketException catch (_) {
//             _showToast('Please Check Network Connection');
//           }
//         } else if (error.type == DioErrorType.CONNECT_TIMEOUT) {
//           _showToast("TimeOut");
//         } else {
//           // _showToast(error.message);
//         }
//       }, onResponse: (Response response) async {
//         isMaintanence = false;

//         if (response.headers.value("accesstoken") != null) {
//           PreferenceHelper.setAccessToken(
//               response.headers.value("accesstoken"));
//         }

//         if (response.headers.value("refreshtoken") != null) {
//           PreferenceHelper.setRefresh(response.headers.value("refreshtoken"));
//         }

//         return response;
//       }),
//     );
//   }

//   Future<bool> isNetworkAvailable() async {
//     final connectionResult = await Connectivity().checkConnectivity();
//     if (connectionResult == ConnectivityResult.none) {
//       return false;
//     } else {
//       return true;
//     }
//   }

//   _showToast(String text) {
//     Fluttertoast.showToast(
//         msg: text,
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.BOTTOM,
//         backgroundColor: Colors.red,
//         textColor: Colors.white,
//         fontSize: 14.0);
//   }

//   // ignore: always_declare_return_types
//   _setupLogInterceptor() {
//     if (DebugMode.isInDebugMode) {
//       // ignore: avoid_redundant_argument_values
//       dio.interceptors.add(LogInterceptor(responseBody: false));
//     }
//   }
// }

// class JsonTransformer extends DefaultTransformer {
//   JsonTransformer() : super(jsonDecodeCallback: _parseJson);
// }

// Map<String, dynamic> _parseAndDecode(String response) {
//   return jsonDecode(response) as Map<String, dynamic>;
// }

// Future<Map<String, dynamic>> _parseJson(String text) {
//   return compute(_parseAndDecode, text);
// }

// Dio dio({bool isValidateAPi = false, bool isLoginApi = false}) {
//   // final Dio dio =
//   // DioHelper(isValidateApi: isValidateAPi, isloginApi: isLoginApi).dio;
//   // return dio;
// }
