import 'package:flutter/material.dart';
import 'package:SmartGarage/style/global.dart';
import 'package:SmartGarage/style/pieces.dart';
import 'package:SmartGarage/functions/functions.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/UI/firebase_animated_list.dart';
import 'package:firebase_core/firebase_core.dart';

// final FirebaseApp app = FirebaseApp(
//   name: null,
//   options: FirebaseOptions(
//     googleAppID: '1:140734416997:ios:81cfb7452313381f225e8c',
//     databaseURL: 'https://garage-b6ec3.firebaseio.com',
//     gcmSenderID: '140734416997',
//   )
// );


FirebaseDatabase database = new FirebaseDatabase();
final ref = FirebaseDatabase.instance.reference();

homePage(BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width,
    child: SingleChildScrollView(

      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top:25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(iconSize: 55, icon: Icon(Icons.settings)),
                Text('garage', style: garageTitle),
                IconButton(
                  icon: Icon(Icons.ios_share),
                  iconSize: 55,
                  onPressed: () {
                    navigateToSharePage(context);
                }),
              ],
            ),
          ),
          
          Container(
            margin: EdgeInsets.only(top:60),
            child: StreamBuilder(
              stream: ref.onValue,
              builder: (context, AsyncSnapshot<Event> snapshot) {
                if (snapshot.hasData) {
                  DataSnapshot dataValues = snapshot.data.snapshot;
                  Map<dynamic, dynamic> values = dataValues.value;
                  int currentStatus = values['status']['status'];
                  String currentStatusStr = currentStatus.toString();
                  // print(currentStatus);
                  if(currentStatus == 1){
                    return garageStatus(1);
                  }
                  else{
                    return garageStatus(2);
                  }
                }
                return garageStatus(3);
              }
            ),
          ),
          Container(
            margin: EdgeInsets.only(top:25),
            child: StreamBuilder(
              stream: ref.onValue,
              builder: (context, AsyncSnapshot<Event> snapshot) {
                if (snapshot.hasData) {
                  DataSnapshot dataValues = snapshot.data.snapshot;
                  Map<dynamic, dynamic> values = dataValues.value;
                  int currentStatus = values['status']['status'];
                  String currentStatusStr = currentStatus.toString();
                  // print(currentStatus);
                  if(currentStatus == 1){
                    return openButton(1, context);
                  }
                  else{
                    return openButton(2, context);
                  }
                }
                return openButton(3,  context);
              }
            ),
          ),
              
          Container(
            height: 320,
            margin:EdgeInsets.only(top:30, left: 15, right: 15),
            decoration: BoxDecoration (
              border: Border.all(color: Colors.black87),
              borderRadius: BorderRadius.all(Radius.circular(30))
            ),
            child: SingleChildScrollView(
              child: Column(
                children:[ 
                  Text('Activity Log', style: addButton),
                  Container(
                    margin: EdgeInsets.only(bottom: 30),
                    child: StreamBuilder(
                      stream: ref.child('log').orderByKey().limitToFirst(4).onValue,
                      builder: (context, AsyncSnapshot<Event> snapshot) {
                        List lists = [];
                        if (snapshot.hasData) {
                          lists.clear();
                          DataSnapshot dataValues = snapshot.data.snapshot;
                          var values = dataValues.value;

                          // print(values);


                          values.forEach((key, values) {
                              lists.add(values);
                          });
                          
                          // for (var item in values) {
                          //   print(item);
                          //   if(item != null){
                          //     lists.add(item);
                          //   }
                          // }
                          // values = values[1];
                          // print(lists);

                          return new ListView.builder(
                            shrinkWrap: true,
                            itemCount: lists.length,
                            itemBuilder: (BuildContext context, int index) {
                              
                              return Card(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(),
                                      child: garageActivity(lists[index]["action"].toString(), lists[index]["time"])
                                    ),

                                  ],
                                ),
                              );
                            }
                          );
                        }
                        return CircularProgressIndicator();
                      }
                    ),
                  ),
                  // garageActivity()
                ]
              )
            )
          ),
            
          Container(
            height: 300,
            margin:EdgeInsets.only(top:30, left: 15, right: 15),
            decoration: BoxDecoration (
              border: Border.all(color: Colors.black87),
              borderRadius: BorderRadius.all(Radius.circular(30))
            ),
            child: SingleChildScrollView(
              child: Column(
                children:[ 
                  Text('Other Garages:', style: addButton),
                  Container(
                    margin: EdgeInsets.only(bottom: 30),
                    child: StreamBuilder(
                      stream: ref.child('sharing').orderByKey().limitToFirst(5).onValue,
                      builder: (context, AsyncSnapshot<Event> snapshot) {
                        List lists = [];
                        List completeList = [];

                        if (snapshot.hasData) {
                          lists.clear();
                          DataSnapshot dataValues = snapshot.data.snapshot;
                          var values = dataValues.value;

                          // print(values);


                          // values.forEach((key, values) {
                          //   if(values['user'] == loggedIn()){
                          //     lists.add(values);
                          //   }
                          // });
                          
                          for (var item in values) {
                            if(item != null){
                              lists.add(item);
                            } 
                          }
                          for (var item in lists) {
                            print(item['shared']);
                            if(item['shared'] == loggedIn()){
                              completeList.add(item);
                              print("adding");
                            }
                          }


                          // values = values[1];
                          // print(lists);
                          if(completeList.length == 0){
                            return Center(child: Text("no garages shared with you"),);
                          }
                          return new ListView.builder(
                            shrinkWrap: true,
                            itemCount: completeList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: (){
                                  changeGarageStatus(2, context);
                                },
                                child: Card(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(),
                                        child: sharedWithMe(completeList[index]["user"], completeList[index]["permissionType"])
                                      ),

                                    ],
                                  )
                                ),
                              );
                            }
                          );
                        }
                        return CircularProgressIndicator();
                      }
                    ),
                  ),
                  // garageActivity()
                ]
              )
            )
          ),
        ],
      ),
    )
  );
}