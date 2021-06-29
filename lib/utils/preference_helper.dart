// import 'dart:convert';

// import 'package:flutter/foundation.dart';

// import 'constant.dart';

// class PreferenceHelper {

//   static Future<String> getRefreshToken() {
//     return storage.read(key: Constants.RefreshToken);
//   }

//   static Future<String> getUserName() {
//     return storage.read(key: Constants.Name);
//   }

//   // set entityId

//   // static void setEntityId(String entityId) {
//   //   storage.write(key: Constants.EntityId, value: entityId);
//   // }

//   // set access token

//   static void setAccessToken(String token) {
//     storage.write(key: Constants.AccessToken, value: token);
//   }

//   // set refresh token

//   static void setRefresh(String token) {
//     storage.write(key: Constants.RefreshToken, value: token);
//   }

//   // set finger print

//   static void setFingerPrint(String name) {
//     storage.write(key: Constants.FingerPrint, value: name);
//   }

//   static Future<User> getUser() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String value = prefs.getString("user");
//     if (value?.isEmpty ?? true) {
//       return null;
//     } else {
//       Map<String, dynamic> map = await _parseJson(value);
//       return User.fromJson(map);
//     }
//   }

//   static saveUser(User user) async {
//     if (user == null) return;
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     final String userString = jsonEncode(user);

//     await prefs.setString("user", userString);
//   }

//   static Map<String, dynamic> _parseAndDecode(String response) {
//     return jsonDecode(response) as Map<String, dynamic>;
//   }

//   static Future<Map<String, dynamic>> _parseJson(String text) {
//     return compute(_parseAndDecode, text);
//   }
// }
