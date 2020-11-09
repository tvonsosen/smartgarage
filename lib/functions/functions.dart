import 'package:flutter/material.dart';
import 'package:SmartGarage/main.dart';
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


Future navigateToSharePage(context) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => SharePage()));
}

buttonStatus() {
  // ! dynamic button
  return "open";
}

changeGarageStatus(int state, BuildContext context) async{
  ref.child('activate').update({
    'activate': true,
  });
  String stateStr;
  String logState;
  int currentTime = ((((new DateTime.now()).millisecondsSinceEpoch).toInt())/1000).toInt();

  if(state == 0){
    stateStr = "Opening";
    logState = "Opened";
  }
  else if(state == 1){
    stateStr = "Closing";
    logState = "Closed";
  }
  else if(state == 2){
    stateStr = "Activating";
    logState = loggedIn();

  }

  ref.child('log').push().set({
    "action": logState,
    "time": currentTime,
  }).then((_) {
    Scaffold.of(context).showSnackBar(
      SnackBar(content: Text(stateStr + ' Garage')));
  });  

}


addEmail() {
  //! for add button
  print("added");
}

editEmails() {
  // ! to edit the email list
  print('edited');
}


loggedIn(){
  return "mason";
}

removePerson(String key){
  ref.child(key).remove();
}