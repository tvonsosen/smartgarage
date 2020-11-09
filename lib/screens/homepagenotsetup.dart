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

homePageNotSet(BuildContext context) {

  return Container(
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 45),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // IconButton(iconSize: 55, icon: Icon(Icons.settings)),
                  Container(
                      margin: EdgeInsets.only(left: 30, right: 30),
                      child: Text('garage', style: garageTitle)),
                  // IconButton(
                  //     icon: Icon(Icons.ios_share),
                  //     iconSize: 55,
                  //     onPressed: () {
                  //       navigateToSharePage(context);
                  //     }),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 60),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:[
                Container(
                  width: 20,
                  height: 20,
                  margin: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    shape: BoxShape.circle
          ),
        ),
                  Text("Garage Not Setup", style: currentStatusStyle),
                ],
                ),
               
            ), 
                
           
          
          
            Container(
              margin: EdgeInsets.only(top:50),
              width: 100,
              height:60,
              child: RaisedButton(
                child: Text('Setup'),
                shape: StadiumBorder(),
                onPressed: (){
                  
                },

              
                  ),
                    
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
      ));
}