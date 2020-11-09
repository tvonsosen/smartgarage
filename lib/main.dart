import 'package:SmartGarage/screens/homepagenotsetup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:SmartGarage/screens/homepage.dart';
import 'package:SmartGarage/style/global.dart';
import 'package:SmartGarage/functions/functions.dart';
import 'package:SmartGarage/style/pieces.dart';
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

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: homePage(context));
  }
}

class SharePage extends StatefulWidget {
  @override
  _SharePageState createState() => _SharePageState();
}

class _SharePageState extends State<SharePage> {
  int selectedRadio;
  int selectedRadio2;
// ! this is to initialize state, and select selected raido value when radio button is clicked
  @override
  void initState() {
    super.initState();
    selectedRadio = 0;
    selectedRadio2 = 0;
  }

  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  setSelectedRadio2(int val1) {
    setState(() {
      selectedRadio2 = val1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 45),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        icon: Icon(Icons.arrow_back_ios_sharp),
                        iconSize: 50,
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                    Container(
                        margin: EdgeInsets.only(left: 17, right: 17),
                        child: Text('garage', style: garageTitle)),
                    IconButton(
                        icon: Icon(Icons.arrow_back_ios_sharp),
                        color: Colors.white,
                        iconSize: 50,
                        onPressed: () {
                          // Navigator.pop(context);
                        }),
                    // * back button
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Container(
                  margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  child: Column(
                    children: [
                      Text('Share Your Garage', style: addButton),

                      TextField(
                          autofocus: true,
                          style: TextStyle(height: 1.5, fontSize: 18),
                          obscureText: false,
                          decoration: InputDecoration(
                            hintText: 'Email to Share',
                            border: OutlineInputBorder(),
                          )),

                      // * Radio buttons and their titles, permission time period/permission to use
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          children: [
                            Text('Permission:', style: switchButton),
                            RadioListTile(
                                value: 1,
                                groupValue: selectedRadio,
                                activeColor: Colors.deepPurple,
                                title: Text("24 hours"),
                                onChanged: (val) {
                                  print(val);
                                  setSelectedRadio(val);
                                  //setSelecteedButton(val):
                                }),
                            RadioListTile(
                              value: 2,
                              groupValue: selectedRadio,
                              activeColor: Colors.deepPurple,
                              title: Text("Forever"),
                              onChanged: (val) {
                                print(val);
                                setSelectedRadio(val);
                              },
                            ),
                            Text('Ask for Permission?', style: switchButton),
                            RadioListTile(
                                value: 3,
                                groupValue: selectedRadio2,
                                activeColor: Colors.deepPurple,
                                title: Text("No"),
                                onChanged: (val1) {
                                  print(val1);
                                  setSelectedRadio2(val1);
                                }),
                            RadioListTile(
                              value: 4,
                              groupValue: selectedRadio2,
                              activeColor: Colors.deepPurple,
                              title: Text("Yes"),
                              onChanged: (val1) {
                                print(val1);
                                setSelectedRadio2(val1);
                              },
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                          icon: Icon(Icons.add),
                          iconSize: 65,
                          onPressed: () {
                            addEmail();
                          }),

                      Container(
                        height: 320,
                        margin:EdgeInsets.only(top:30, left: 0, right: 0),
                        decoration: BoxDecoration (
                          border: Border.all(color: Colors.black87),
                          borderRadius: BorderRadius.all(Radius.circular(30))
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            children:[ 
                              Text('Shared With', style: addButton),
                              Container(
                                margin: EdgeInsets.only(bottom: 30),
                                child: StreamBuilder(
                                  stream: ref.child('sharing').orderByKey().limitToFirst(5).onValue,
                                  builder: (context, AsyncSnapshot<Event> snapshot) {
                                    List lists = [];
                                    if (snapshot.hasData) {
                                      lists.clear();
                                      DataSnapshot dataValues = snapshot.data.snapshot;
                                      var values = dataValues.value;

                                      print(values);


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
                                      
                                      // values = values[1];
                                      // print(lists);

                                      return new ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: lists.length,
                                        itemBuilder: (BuildContext context, int index) {
                                          return InkWell(
                                            onTap: (){
                                              removePerson(lists[index]["shared"]);
                                            },
                                            child: Card(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Container(
                                                    margin: EdgeInsets.only(),
                                                    child: shared(lists[index]["shared"], lists[index]["permissionType"])
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}