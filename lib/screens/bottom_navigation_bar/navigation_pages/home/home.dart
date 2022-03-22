import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:neph_care_user/constants/base_url.dart';
import 'package:neph_care_user/constants/colors.dart';
import 'package:neph_care_user/modals/home_modal.dart';
import 'package:neph_care_user/screens/bottom_navigation_bar/navigation_pages/home/home_card.dart';
import 'package:neph_care_user/widgets/waiting_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}


class _HomeState extends State<Home> {
  // bool isLoading = false;
  // bool hasMore = true;
  // int cPage = 1;

  List<HomeModal> homeList = [];
  late Future requestList;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    setState(() {
      requestList = homeApiFunc();
    });
    // scrollController.addListener(() {
    //   if (scrollController.position.pixels ==
    //       scrollController.position.maxScrollExtent) {
    //     if (isLoading == false && hasMore == true) {
    //       cPage++;
    //       setState(() {
    //         requestList = homeApiFunc();
    //       });
    //     }
    //   }
    // });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: Visibility(
      //   visible: (cPage == 1)
      //       ? false
      //       : (hasMore == false)
      //       ? true
      //       : isLoading,
      //   child: Container(
      //     margin: const EdgeInsets.only(top: 0, bottom: 10.0, left: 0.0),
      //     padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 3.0),
      //     height: 20,
      //     decoration: BoxDecoration(
      //       borderRadius: BorderRadius.circular(35.0),
      //       color: const Color(0xFFFF1A00).withOpacity(0.95),
      //     ),
      //     child: Text(
      //       (hasMore == true) ? 'Loading More ...' : 'No More Available',
      //       style: const TextStyle(color: Color(0xFFFFFFFF), fontSize: 12),
      //       textAlign: TextAlign.center,
      //     ),
      //   ),
      // ),
      appBar: AppBar(
        title: Text("History"),
        centerTitle: true,
        backgroundColor: basicthemecolor,
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 0.0),
        child: FutureBuilder(
          future: requestList,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Container(
                  margin: const EdgeInsets.only(bottom: 20.0),
                  child: const Center(child: WaitingCard()));
            } else {
              return ListView.builder(
                controller: scrollController,
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return HomeCard(
                    homeIndex: snapshot.data[index],
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
  Future<List<HomeModal>> homeApiFunc() async {
    //
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var user_id = prefs.getInt('user_id');
    print(user_id);
    //
    var formData = FormData.fromMap({
      'user_id': user_id,
      'user_type': "doctor",
    });
    //
    var apiURL = baseUrl + 'get/covid/request';
    Response sr;
    Dio dio = Dio();
    try {
      setState(() {
        // isLoading = true;
      });
      sr = await dio.post(apiURL, data: formData,);
      setState(() {
        // isLoading = false;
      });
      if (sr.data.toString() == '[]') {
        setState(() {
          // hasMore = false;
        });
        Fluttertoast.showToast(msg: 'No Data Found', backgroundColor: basicthemecolor);
      }
      var resp = jsonDecode(jsonEncode(sr.data).toString());
      print(resp);
      var response1 = resp['user_requests'];
      print(response1);

      // if(hasMore == true) {
        for (var r in response1) {
          HomeModal homeModal = HomeModal(
            userName: r["user_name"] ?? 'null',
            requestId: r["request_id"] ?? 0,
            requestStatus: r["request_status"] ?? 'null',
            testStatus: r["test_status"] ?? 'null',
            nursephone: r["nurse_phone"] ?? 'null',
            nursename: r["nurse_name"] ?? 'null',
            testfile: r["test_file"] ?? 'null',
          );
          homeList.add(homeModal);
        // }
      }
    } catch (e) {
      setState(() {
        // isLoading = false;
      });
      Fluttertoast.showToast(msg: 'some thing wrong catch', backgroundColor: basicthemecolor);
      print(e);
    }
    return homeList;
  }
}
