import 'package:flutter/material.dart';
import 'package:SmartGarage/style/global.dart';
import 'package:SmartGarage/functions/functions.dart';
import 'package:date_format/date_format.dart';


openButton(int buttonStatus, BuildContext context){
  if (buttonStatus == 1){
    return MaterialButton(
      height: 300,
      color: Colors.white12,
      minWidth: 300,
      shape: StadiumBorder(),
      child: Text("OPEN", style: garageButton),
      splashColor: Colors.grey,
      onPressed: () {
        changeGarageStatus(0,context);
    });
  }


  else if (buttonStatus == 2){
    return MaterialButton(
      height: 300,
      color: Colors.white12,
      minWidth: 300,
      shape: StadiumBorder(),
      child: Text("CLOSE", style: garageButton),
      splashColor: Colors.grey,
      onPressed: () {
        changeGarageStatus(1, context);
    });
  }


  else{
    return MaterialButton(
      height: 300,
      color: Colors.white12,
      minWidth: 300,
      shape: StadiumBorder(),
      child: Text("ERROR", style: garageButton),
      splashColor: Colors.grey,
    );
  }
  


}






garageStatus(int garageStatus){
  if(garageStatus == 1){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children:[
        Container(
          width: 20,
          height: 20,
          margin: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.green,
            shape: BoxShape.circle
          ),
        ),
        Text("Current Status: Closed", style: currentStatusStyle),
      ]
    );
  }
  else if(garageStatus == 2){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children:[
        Container(
          width: 20,
          height: 20,
          margin: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.red,
            shape: BoxShape.circle
          ),
        ),
        Text("Current Status: Open", style: currentStatusStyle),
      ]
    );  }
  else{
    return Row(
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
        Text("Current Status: Unknown", style: currentStatusStyle),
      ]
    );  }
}
garageActivity(String action, int time){
  DateTime date = DateTime.fromMillisecondsSinceEpoch(time*1000);

  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children:[
      Container(
        width: 20,
        height: 20,
        margin: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.green,
          shape: BoxShape.circle
        ),
      ),
      
      Text(formatDate(date, [hh, ':', nn, ' ', am, ', ', M, ' ', dd]) + " - " + action, style: currentStatusStyle),
    ]
  );
}






shared(String shared, int permissions){
  if(permissions == 1){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children:[
        Container(
          width: 20,
          height: 20,
          margin: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.lightGreen,
            shape: BoxShape.circle
          ),
        ),
        Text(shared + "(Unlimited Access)")
      ]
    );
  }
  else if(permissions == 2){
    return Row(
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
        Text(shared + "(Expiring Soon)")
      ]
    );
  }
  else if(permissions == 3){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children:[
        Container(
          width: 20,
          height: 20,
          margin: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.red,
            shape: BoxShape.circle
          ),
        ),
        Text(shared + "'s Garage(Expired)")
      ]
    );
  }
  else if(permissions == 4){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children:[
        Container(
          width: 20,
          height: 20,
          margin: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.lightBlue,
            shape: BoxShape.circle
          ),
        ),
        Text(shared + "'s Garage(Permission Req.)")
      ]
    );
  }
  
}



sharedWithMe(String shared, int permissions){
  if(permissions == 1){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children:[
        Container(
          width: 20,
          height: 20,
          margin: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.lightGreen,
            shape: BoxShape.circle
          ),
        ),
        Text(shared + "'s Garage(Unlimited Access)")
      ]
    );
  }
  else if(permissions == 2){
    return Row(
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
        Text(shared + "'s Garage(Expiring Soon)")
      ]
    );
  }
  else if(permissions == 3){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children:[
        Container(
          width: 20,
          height: 20,
          margin: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.red,
            shape: BoxShape.circle
          ),
        ),
        Text(shared + "(Expired)")
      ]
    );
  }
  else if(permissions == 4){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children:[
        Container(
          width: 20,
          height: 20,
          margin: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.lightBlue,
            shape: BoxShape.circle
          ),
        ),
        Text(shared + "(Permission Req.)")
      ]
    );
  }
  
}








shareLog(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children:[
        Container(
          width: 20,
          height: 20,
          margin: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.deepPurple,
            shape: BoxShape.circle
          ),
        ),
        Text("masonhorder@gmail.com", style: currentStatusStyle),
      ]
    );
  }