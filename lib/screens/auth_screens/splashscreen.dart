import 'dart:async';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:neph_care_user/constants/routes.dart';
import 'package:neph_care_user/screens/auth_screens/choose_login_signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final player = AudioPlayer();
  var user_id;

  @override
  void initState() {
    playAudio();
    super.initState();
    loadData();
  }

  playAudio() {
    player.setVolume(1);
    player.setAsset("assets/heart_beat.mp3");
    player.play();
  }

  @override
  void dispose() {
    player.stop();
    super.dispose();
  }

  Future loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    user_id = prefs.getInt('user_id');

    if (user_id == null || user_id == 0) {
      Timer(Duration(seconds: 5), () {
        Navigator.pushReplacementNamed(context, chooseloginsignuproute);
      });
    } else {
      Timer(Duration(seconds: 7), () {
        Navigator.pushReplacementNamed(context, bottomnavigationroute);
      });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      // key: _con.scaffoldKey,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: Hero(
                  tag: "Logo ",
                  child: Container(
                      width: 150,
                      height: 150,
                      child: Image.asset(
                        "assets/doctor_logo.gif",
                        width: 140,
                        gaplessPlayback: true,
                      ))),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
