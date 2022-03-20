import 'package:fluttertoast/fluttertoast.dart';
import 'package:neph_care_user/constants/base_url.dart';
import 'package:dio/dio.dart';
import 'package:neph_care_user/constants/colors.dart';
import 'package:http_parser/http_parser.dart';
import 'package:neph_care_user/constants/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

Future<String> updateProfileApi(String name, String email,  String phone, var _image, context) async {
  print('Enter in function');
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var token = prefs.getString('api_token');
  //
  print(token);
  var filename = _image.path.split('/').last;
  print('file name');
  print(filename);
  var apiURL = baseUrl + 'user/update';
  var formData = FormData.fromMap({
    'name': name,
    'email': email,
    'phone': phone,
    'image': await MultipartFile.fromFile(_image.path,
        filename: filename, contentType:
        MediaType('image', 'png'))
  });
  Dio dio = Dio();
  Response responce;
  // print(formData);
  try {
    print('Enter in try');
    responce = await dio.post(
      apiURL,
      options: Options(headers: {
        "Authorization": "Bearer $token"}),
      data: formData,
    );
      print('Enter in 200');
      if (responce.data['error'] == false) {
        print('enter in 200');
        var res1 = responce.data['user'];
        print(res1);
        Fluttertoast.showToast(msg: "Updated Successfully",
            backgroundColor: basicthemecolor);
        Navigator.pushReplacementNamed(context, bottomnavigationroute);
      }
    } catch (e) {
    // print(e);
    Fluttertoast.showToast(msg: "some thing wrong", backgroundColor: basicthemecolor);
    return 'some thing wrong';
  }
  return 'some thing wrong';
}
