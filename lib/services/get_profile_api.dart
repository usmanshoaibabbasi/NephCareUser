import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:neph_care_user/constants/base_url.dart';
import 'package:neph_care_user/constants/colors.dart';
import 'package:neph_care_user/modals/userprofile_modal.dart';
import 'package:neph_care_user/screens/bottom_navigation_bar/navigation_pages/Profile/profile_page.dart' as profilepage;
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/bottom_navigation_bar/navigation_pages/Profile/edit_profile.dart' as editprofile;

Future<String>  getprofileFunction() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var userid = prefs.getInt('user_id');
  //
  print(userid);
  var formData = FormData.fromMap({
    'user_id': userid,
  });

  const apiURL = baseUrl + 'get/profile';
  Response response;
  Dio dio = Dio();
  try {
    response = await dio.post(
      apiURL,
      data: formData,
    );
    if (response.data.toString() == '') {
      // setState(() {
      //   loading = false;
      // });
    }
    var resp = jsonDecode(jsonEncode(response.data).toString());

    print('resp');
    print(resp);
    print('hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh');
    if(response.data['error'] == false) {
      print('Enter in 200');
      var res1 = response.data['user'];
      UserProfileModal userdata = UserProfileModal(
        name: res1['name'] ?? '',
        email: res1['email'] ?? '',
        phone: res1['phone'] ?? '',
        image: res1['image'] ?? '',
      );
      profilepage.userProfileModal = userdata;
      editprofile.userProfileModal = userdata;
      // Fluttertoast.showToast(msg: 'Profile Get',
      //     backgroundColor: basicthemecolor);
    }
    if(response.data['error'] == true) {
      Fluttertoast.showToast(msg: 'Fail To Get Profile',
          backgroundColor: basicthemecolor);
    }

  } catch (e) {
    print(e);
    Fluttertoast.showToast(msg: 'Something Wrong',
        backgroundColor: basicthemecolor);
  }
  return '';

}