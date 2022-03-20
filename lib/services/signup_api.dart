import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:neph_care_user/constants/base_url.dart';
import 'package:dio/dio.dart';
import 'package:neph_care_user/constants/colors.dart';
import 'package:neph_care_user/constants/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<String> SignUpApi(String name, String email, String password, context) async {
  var apiURL = baseUrl + 'user/register';
  var formData = FormData.fromMap({
    'name': name,
    'email': email,
    'password': password,
    'type': 'doctor',
    'genre': 1,
  });
  Dio dio = Dio();
  Response responce;
  // print(formData);
  try {
    responce = await dio.post(
      apiURL,
      data: formData,
    );
    if (responce.statusCode == 200) {
      if (responce.data['error'] == false) {
        var res1 = responce.data['user'];
        print(res1);
        var apitoken = res1['api_token'] ?? '';
        var id = res1['id'] ?? 0;
        var name = res1['name'] ?? '';
        var email = res1['email'] ?? '';
        var phone = res1['phone'] ?? '';

        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('api_token', apitoken);
        prefs.setInt('user_id', id);
        prefs.setString('name', name);
        prefs.setString('email', email);
        prefs.setString('phone', phone);
        CircularProgressIndicator(
          color: basicthemecolor,
        );
        Navigator.pushReplacementNamed(context, bottomnavigationroute);
        Fluttertoast.showToast(msg: "Signup Successfull", backgroundColor: basicthemecolor);
        return '';
      } else if (responce.data['error'] == true) {
        Fluttertoast.showToast(msg: "${responce.data["error_data"]}");
        return '';
      } else {
        Fluttertoast.showToast(msg: "${responce.data["error_data"]}");
        return '';
      }
    }
  } catch (e) {
    // print(e);
    Fluttertoast.showToast(msg: "Something Wrong");
    return 'Something Wrong';
  }
  Fluttertoast.showToast(msg: "some thing wrong");
  return 'some thing wrong';
}
