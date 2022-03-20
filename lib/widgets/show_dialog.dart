import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

SimpleDialog simpledialog ({required Function onTapAccept,required Function onTapDecline,}){
  return SimpleDialog(
    title: Column(
      children: const [
        Text("New Request"),
        SizedBox(height: 10,),
        Text("Are you sure You want to Proceed This Request",style:TextStyle(fontSize: 15),textAlign: TextAlign.justify,),

      ],
    ),

    children: <Widget>[
      Row(
        mainAxisAlignment:
        MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          SimpleDialogOption(
            onPressed: () => onTapAccept(),
            child: const Text(
              'Accept',
              style: TextStyle(
                  fontWeight: FontWeight.bold,fontSize: 18,color: Colors.blue),
            ),
          ),
          SimpleDialogOption(
            onPressed: () => onTapDecline(),
            child: const Text('Decline',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.blue),),
          ),
        ],
      ),
    ],
  );
}