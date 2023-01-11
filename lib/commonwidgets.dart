import 'package:flutter/material.dart';

class appdrawer extends StatefulWidget{
  @override
  drawer createState()=> drawer();
}

class drawer extends State<appdrawer>{
  @override
  Widget build(BuildContext context) {
    return Material(child: Drawer(
        child: Container(
          color: Colors.lightGreenAccent,
          child: Column(
            children: [
              SizedBox(height: 30),
              DrawerHeader(
                  child:
                  Container(height: 140, width: 140,  )),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(10.0),
                child: new Text("AssalamuAlikum \n This app is developed as\nan experiment if u have\n any problem contact \nsalman3xs@gmail.com",style: TextStyle(fontSize: 24),),
              ),
              Material(
                borderRadius: BorderRadius.circular(500),
                child: InkWell(
                  splashColor: Colors.black,
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.black,
                    child: Icon(Icons.arrow_back, color: Colors.white),
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 65,
                    color: Colors.black,
                    child: Center(
                      child: Text(
                        "BETA",
                        style: TextStyle(fontSize: 24, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        )),
    );
  }
}