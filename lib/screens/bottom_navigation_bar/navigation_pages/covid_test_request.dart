import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:neph_care_user/constants/base_url.dart';
import 'package:neph_care_user/constants/colors.dart';
import 'package:neph_care_user/helpers/email_validation.dart';
import 'package:neph_care_user/modals/my_wallet_modal.dart';
import 'package:neph_care_user/services/covidtest_req_api.dart';
import 'package:neph_care_user/services/my_wallet_api.dart';
import 'package:neph_care_user/widgets/container_border.dart';
import 'package:neph_care_user/widgets/my_wallet_api.dart';
import 'package:neph_care_user/widgets/show_dialog.dart';
import 'package:neph_care_user/widgets/textfield.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CovidTestRequest extends StatefulWidget {
  const CovidTestRequest({Key? key}) : super(key: key);

  @override
  State<CovidTestRequest> createState() => _CovidTestRequestState();
}
late final MyWalletModal myWalletModal;
class _CovidTestRequestState extends State<CovidTestRequest> {
  bool hidePassword = true;
  String address = '';
  String phone = '';
  String error = '';
  final formKey = GlobalKey<FormState>();
  var loading;

  @override
  void initState() {
    setState(() {
      loading = true;
    });
    walletFunction().then((value) => {
      setState(() {
        loading = false;
      })
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(" Request Covid Test"),
        centerTitle: true,
        backgroundColor: basicthemecolor,
        leading: IconButton(
          onPressed: () {
            // Navigator.pop(context);
          },
          icon: const Icon(CupertinoIcons.chevron_back),
          color: Colors.white,
        ),
      ),
        body: loading == true ? Center(child: CircularProgressIndicator()) :
      Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(15),
                alignment: Alignment.center,
                decoration: containerBorder,
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        textAlignVertical: TextAlignVertical.bottom,
                        textInputAction: TextInputAction.next,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        decoration: inputField1(
                          label1: 'Phone',
                          context: context,
                          prefixicon: Icon(
                            CupertinoIcons.phone,
                            color: basicthemecolor,
                            size: 22,
                          ),
                        ),
                        validator: (val) =>
                            val!.length < 5 ? 'Phone more than 5 digit' : null,
                        onChanged: (val) {
                          setState(() {
                            phone = val;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        maxLines: 8,
                        keyboardType: TextInputType.streetAddress,
                        textAlignVertical: TextAlignVertical.bottom,
                        textInputAction: TextInputAction.next,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        decoration: inputField1(
                          label1: 'Address',
                          context: context,
                          prefixicon: Container(
                            transform: Matrix4.translationValues(0, -65, 0),
                            child: Icon(
                              CupertinoIcons.mail,
                              color: basicthemecolor,
                              size: 22,
                            ),
                          ),
                        ),
                        validator: (val) => val!.length < 15
                            ? 'Address should be at least 15 character long'
                            : null,
                        onChanged: (val) {
                          setState(() {
                            address = val;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
              margin: const EdgeInsets.all(15),
              width: size.width,
              height: 46,
              child: ElevatedButton(
                child: Text(
                  "Request Covid Test".toUpperCase(),
                  style: const TextStyle(color: Colors.white),
                ),
                  style: ElevatedButton.styleFrom(primary: basicthemecolor),
                  onPressed: () {
                  if(myWalletModal.balance < 20){
                    Fluttertoast.showToast(
                        msg: 'Your Wallet Amount is ' + myWalletModal.balance.toString() +'\$ Less than 20\$',
                        backgroundColor: basicthemecolor,
                      gravity: ToastGravity.BOTTOM,
                    );
                  } else
                    {
                      if (formKey.currentState!.validate()) {
                        showDialog(
                            context: context,
                            builder: (BuildContext Context) {
                              return simpledialog(
                                onTapAccept: () async {
                                  if (formKey.currentState!.validate()) {
                                    var a = await CovidTestReqApi(address, phone, context);
                                    setState(() {
                                      error = a;
                                    });
                                    if(error == 'success'){
                                      formKey.currentState?.reset();
                                    }
                                  }
                                },
                                onTapDecline: () {
                                  Navigator.pop(context, false);
                                },
                              );
                            });
                      }
                    }
                  },
              )),
        ],
      ),
    );
  }
}
