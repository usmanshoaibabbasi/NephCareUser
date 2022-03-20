import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:neph_care_user/constants/base_url.dart';
import 'package:dio/dio.dart';
import 'package:neph_care_user/constants/colors.dart';
import 'package:neph_care_user/constants/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<String> CovidTestReqApi(String address, String phone, context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var userId = prefs.getInt('user_id');
  //
  var apiURL = baseUrl + 'covid/request';
  var formData = FormData.fromMap({
    'user_id': userId,
    'contact': phone,
    'address': address,
  });
  Dio dio = Dio();
  Response responce;
  // print(formData);
  try {
    responce = await dio.post(
      apiURL,
      data: formData,
    );
    print(responce.data);
    if (responce.statusCode == 200) {
      var res1;
      if (responce.data['success'] == true) {
        res1 = responce.data['success_message'];
        print(res1);
        Fluttertoast.showToast(msg: res1, backgroundColor: basicthemecolor);
        Navigator.pop(context, false);
        return 'success';
      } else if (responce.data['success'] == false) {
        res1 = responce.data['error_message'];
        Fluttertoast.showToast(msg: res1, backgroundColor: basicthemecolor);
        Navigator.pop(context, false);
        return 'failure';
      } else {
        Fluttertoast.showToast(msg: res1, backgroundColor: basicthemecolor);
        Navigator.pop(context, false);
        return 'failure';
      }
    }
  } catch (e) {
    // print(e);
    Fluttertoast.showToast(msg: "some thing wrong", backgroundColor: basicthemecolor);
    return 'failure';
  }
  Fluttertoast.showToast(msg: "some thing wrong", backgroundColor: basicthemecolor);
  return 'failure';
}
