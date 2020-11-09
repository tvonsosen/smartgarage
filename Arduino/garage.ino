#include <Arduino.h>
#include "FirebaseESP8266.h"
#include <ESP8266WiFi.h>


#define FIREBASE_HOST "garage-b6ec3.firebaseio.com"
#define FIREBASE_AUTH "QmPxfJZ5hnJQXkeLsqxMlJSHlTXN3m1AivH6Nayf"
#define WIFI_SSID "Horder"
#define WIFI_PASSWORD "Skmadley"
#define LED 12


#define echoPin 13 // attach pin D2 Arduino to pin Echo of HC-SR04
#define trigPin 16 //attach pin D3 Arduino to pin Trig of HC-SR04

// defines variables
long duration; // variable for the duration of sound wave travel
int distance;

int currentState;
int lastState;

FirebaseData firebaseData;

int varRelayPin = 12; // Relay Pin


long microsecondsToInches(long microseconds) {
  return microseconds / 74 / 2;
}

long microsecondsToCentimeters(long microseconds) {
  return microseconds / 29 / 2;
}

void activateGarage() {
  // opens/closes the garage
  digitalWrite(varRelayPin, HIGH);   
  delay(1000);                       
  digitalWrite(varRelayPin, LOW);    
}
void setActivateFalse() {
  Firebase.setBool(firebaseData, "/activate/activate", false);
}



void changeStatus(int state){
  Firebase.setInt(firebaseData, "/status/status", state);
}








void setup() {
  pinMode(LED,OUTPUT);
  digitalWrite(LED,0);
  Serial.begin(9600);
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);

  while (WiFi.status() != WL_CONNECTED) {
    delay(100);
  }

  Serial.println();
  Firebase.begin(FIREBASE_HOST, FIREBASE_AUTH);
  Firebase.reconnectWiFi(true);
  if (!Firebase.beginStream(firebaseData, "/activate/activate")){
    delay(100);
  }
  pinMode(echoPin, INPUT);
  pinMode(trigPin, OUTPUT);
}




void loop(){
  

  Firebase.getBool(firebaseData,"/activate/activate");
  if (firebaseData.boolData()){
    activateGarage();
    setActivateFalse();
  }
  Serial.println(firebaseData.boolData());
  
  digitalWrite(trigPin, LOW);
  delayMicroseconds(2);
  digitalWrite(trigPin, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigPin, LOW);
  duration = pulseIn(echoPin, HIGH);
  distance = duration * 0.034 / 2; 
  Serial.print("Distance: ");
  Serial.print(distance);
  Serial.println(" cm");

  if(distance < 37){
    currentState = 0;
  }
  else{
    currentState = 1;
  }
  if(currentState != lastState){
    changeStatus(currentState);
    lastState = currentState;
  }




  delay(3000);

}

