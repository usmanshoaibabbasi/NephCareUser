import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:neph_care_user/constants/base_url.dart';
import 'package:neph_care_user/modals/my_wallet_modal.dart';
import 'package:neph_care_user/screens/bottom_navigation_bar/navigation_pages/Profile/my_wallet.dart' as profile;
import 'package:neph_care_user/screens/bottom_navigation_bar/navigation_pages/covid_test_request.dart' as req;
import 'package:shared_preferences/shared_preferences.dart';

Future<String>  walletFunction() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var token = prefs.getString('api_token');
  print(token);

  const apiURL = baseUrl + 'get/wallet';
  Response response;
  Dio dio = Dio();
  try {
    response = await dio.post(apiURL,
        options: Options(headers: {"Authorization": "Bearer $token"}));
    if (response.data.toString() == '') {
      // setState(() {
      //   loading = false;
      // });
    }
    var resp = jsonDecode(jsonEncode(response.data).toString());

    print('resp');
    print(resp);
    if(response.data['error'] == false) {
      var res1 = response.data['user'];
      MyWalletModal wallet = MyWalletModal(
        balance: res1['balance'] ?? 0,
      );
      profile.myWalletModal = wallet;
      req.myWalletModal = wallet;
      // setState(() {
      //   loading = false;
      //   myWalletModal = walletModal;
      // });
    }

  } catch (e) {
    // setState(() {});
    print(e);
  }
  return '';

}