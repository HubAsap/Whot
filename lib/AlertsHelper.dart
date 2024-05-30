// ignore_for_file: file_names, prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, prefer_adjacent_string_concatenation

import 'package:flutter/material.dart';

class AlertHelper {

  static infoDialog(context, double deviceScreenWidth) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        // return object of type Dialog
        return Dialog(
          elevation: 0.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: Container(
            height: 400.0,
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text("How To",
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                ),),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text("Goto Market",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                    ),),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 4),
                  child: Text("Swipe down on the market deck of cards.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                      fontWeight: FontWeight.normal,
                    ),),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text("Play",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                    ),),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 4),
                  child: Text("Swipe up on your deck of cards to remove card from deck or double tap on your deck of card to place them on the center deck.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                      fontWeight: FontWeight.normal,
                    ),),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text("Return Card To My Cards",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                    ),),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 4),
                  child: Text("Swipe right on your deck of cards or tap once to return card to your deck of cards.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                      fontWeight: FontWeight.normal,
                    ),),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static alertDialog(context, double deviceScreenWidth, String header, String body) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // return object of type Dialog
        return Dialog(
          elevation: 0.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: Container(
            height: 100.0,
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text(header,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                    ),),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 4),
                  child: Text(body,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                      fontWeight: FontWeight.normal,
                    ),),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

