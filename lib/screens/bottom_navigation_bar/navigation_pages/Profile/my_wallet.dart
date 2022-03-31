import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:neph_care_user/constants/colors.dart';
import 'package:neph_care_user/modals/my_wallet_modal.dart';
import 'package:neph_care_user/services/my_wallet_api.dart';
import 'package:http/http.dart' as http;

class MyWallet extends StatefulWidget {
  MyWallet({Key? key}) : super(key: key);

  @override
  State<MyWallet> createState() => _MyWalletState();
}

// var balance;
late final MyWalletModal myWalletModal;
var loading = true;

class _MyWalletState extends State<MyWallet> {
  Map<String, dynamic>? paymentIntentData;

  @override
  void initState() {
    setState(() {
      loading = true;
    });
    walletFunction().then((value) => {
          setState(() {
            loading = false; // Future is completed with a value.
          })
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loading == true
          ? Center(child: CircularProgressIndicator())
          : Container(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 30),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.13,
                    decoration: BoxDecoration(
                      color: basicthemecolor,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40),
                      ),
                      border: Border.all(color: basicthemecolor),
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(0, 2),
                          color: HexColor('#404B63').withOpacity(0.1),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            alignment: Alignment.centerRight,
                            width: 50,
                            child: const Icon(
                              CupertinoIcons.chevron_back,
                              size: 24,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const Text(
                          'Account',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 16),
                        ),
                        Container(
                          alignment: Alignment.topRight,
                          width: 50,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Balance',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black54,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              myWalletModal.balance.toString() == ''
                                  ? '\$ 0.0'
                                  : '\$ ' + myWalletModal.balance.toString(),
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const Text(
                              ' USD',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Recharge your wallet by adding amount through card",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: Colors.black54,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Please add one.",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: Colors.black54,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(40),
                              bottomRight: Radius.circular(40),
                              topRight: Radius.circular(40),
                              topLeft: Radius.circular(40),
                            ),
                            border: Border.all(color: basicthemecolor),
                          ),
                          child: InkWell(
                            onTap: () async {
                              await makePayment();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  CupertinoIcons.creditcard,
                                  size: 16,
                                  color: basicthemecolor,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  'Recharge Wallet',
                                  style: TextStyle(
                                    color: basicthemecolor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }

  Future<void> makePayment() async {
    try {
      print('Enter in try makePayment');
      paymentIntentData = await createPaymentIntent('20', 'USD');
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: paymentIntentData!['client_secret'],
              applePay: true,
              googlePay: true,
              merchantCountryCode: 'US',
              merchantDisplayName: 'Usman'));
      displayPaymentShee();
    } catch (e) {
      print('Exception makePayment:' + e.toString());
    }
  }

  displayPaymentShee() async {
    try {
      await Stripe.instance.presentPaymentSheet(
          parameters: PresentPaymentSheetParameters(
              clientSecret: paymentIntentData!['client_secret'],
              confirmPayment: true));
      setState(() {
        paymentIntentData = null;
      });
      Fluttertoast.showToast(
          msg: "Paid Successfully", backgroundColor: basicthemecolor);
    } on StripeException catch (e) {
      print('Exception displayPaymentSheet:' + e.toString());
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                content: Text('Cancelled'),
              ));
    }
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      print('Enter in try createPaymentIntet');
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card',
      };
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization':
                'Bearer sk_test_51KgsnSJhPUloAqcPALqkMme9bNj7JzTaFREoPCj7n0mQ0tdLdIGxWvcvBH1m8FpIOGwOAYqzEdoKkEVXY2N3izoC00bmItssbP',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      return jsonDecode(response.body.toString());
    } catch (e) {
      print('Exception createPaymentIntent:' + e.toString());
    }
  }

  calculateAmount(String amount) {
    final price = int.parse(amount) * 100;
    return price.toString();
  }
}
