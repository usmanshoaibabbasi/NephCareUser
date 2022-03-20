import 'package:flutter/material.dart';
import 'package:neph_care_user/constants/colors.dart';
import 'package:neph_care_user/constants/routes.dart';

class ChooseLoginSignupPage extends StatelessWidget {
  const ChooseLoginSignupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  width: size.width,
                  decoration: BoxDecoration(
                      // here
                      color: basicthemecolor,
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //doctor_patient_art.png
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 45),
                        child: Opacity(
                            opacity: 1,
                            child: Image.asset(
                              'assets/doctor_patient_art.png',
                            )),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        'Search Nurses',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 28),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Get the List of best Nurses\n& Babysitters around you',
                        style: TextStyle(
                            color: Colors.white,
                            // fontWeight: FontWeight.w800,
                            fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                // height: size.height,
                // decoration: BoxDecoration(
                //     color: theme.accentColor,
                //     borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
                // ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Let\'s get started'.toUpperCase(),
                      style: const TextStyle(
                          // color: theme.primaryColor
                          ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    SizedBox(
                        width: size.width,
                        height: 46,
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, signuproute);
                            },
                            style: ElevatedButton.styleFrom(
                                // here
                                primary: basicthemecolor),
                            child: const Text(
                              'Create An Account',
                              style: TextStyle(color: Colors.white),
                            ))),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: size.width,
                      // margin: EdgeInsets.symmetric(horizontal: ),
                      // padding: EdgeInsets.all(0),
                      color: Colors.grey.shade300,
                      child: TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, loginroute);
                          },
                          child: const Text(
                            'Sign In',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
