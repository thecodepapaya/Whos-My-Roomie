import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:whos_my_roomie/Utils/Person.dart';

class RoomieFinder {
  String _username, _roomiename; //, _name, _graduationYear, _collegeName;
  int _compatibility, _finalScore = 0;
  DocumentReference userdata, roomiedata;
  Person user = Person();
  Person roomie = Person();

  StreamController<Text> streamListController = StreamController<Text>();
  Sink get compatibilitySink => streamListController.sink;
  Stream<Text> get compatibilityStream => streamListController.stream;

  RoomieFinder(String username, String roomiename) {
    _compatibility = 0;
    this._username = username;
    this._roomiename = roomiename;
    userdata = Firestore.instance.collection("UserData").document(_username);
    roomiedata =
        Firestore.instance.collection("UserData").document(_roomiename);
    fetchData();
  }

  fetchData() async {
    await userdata.get().then((DocumentSnapshot doc) {
      user.gender = doc['Your gender'];
      user.cleanliness = doc['Cleanliness Habits'];
      user.sleepingSchedule = doc['Sleeping habits'];
      user.cporcpi = doc['CP vs CPI'];
      user.gamer = doc['Gaming habits'];
      user.studyHabits = doc['Study Habits'];
      user.personalBelongings = doc['Sharing Habits'];
      user.diet = doc['Dietary Habits'];
      user.bathing = doc['Bathing Habits'];
      user.socialBehaviour = doc['Social Behavious'];
      user.acousticProperties = doc['Noisy-ness'];
      user.tvWatcher = doc['Movie Mania'];
      print("Received user details");
    }).then((_) {
      user.giveScore();
    });
    await roomiedata.get().then((DocumentSnapshot doc) {
      user.gender = doc['Your gender'];
      roomie.cleanliness = doc['Cleanliness Habits'];
      roomie.sleepingSchedule = doc['Sleeping habits'];
      roomie.cporcpi = doc['CP vs CPI'];
      roomie.gamer = doc['Gaming habits'];
      roomie.studyHabits = doc['Study Habits'];
      roomie.personalBelongings = doc['Sharing Habits'];
      roomie.diet = doc['Dietary Habits'];
      roomie.bathing = doc['Bathing Habits'];
      roomie.socialBehaviour = doc['Social Behavious'];
      roomie.acousticProperties = doc['Noisy-ness'];
      roomie.tvWatcher = doc['Movie Mania'];
      print("Received roomie details");
    }).then((_) {
      roomie.giveScore();
      _finalScore = _calculateFinalScore();
      putToStream();
    });
    // user.giveScore();
    // roomie.giveScore();
  }

  putToStream() {
    compatibilitySink.add(roommateCompatibility());
  }

  Text roommateCompatibility() {
    //_finalScore = _calculateFinalScore();
    _compatibility = ((1 - ((_finalScore) / 26)) * 100).toInt();
    // 26 is the maxiamum possible score one can get in the score test while the minimum is 0
    //  total score actually represents the total "imcompatibility" between the individuals
    // hence we subtract the _finalScore/26 from 1
    return Text(
      "Compatibility $_compatibility %",
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  int _calculateFinalScore() {
    // user.giveScore();_
    // roomie.giveScore();
    int difference = totalScore(user, roomie);
    print("Total Score: $difference");
    return difference;
  }

  int totalScore(Person user, Person roomie) {
    int _totalScore = (user.genderScore - roomie.genderScore).abs() +
        (user.cleanlinessScore - roomie.cleanlinessScore).abs() +
        (user.sleepingScheduleScore - roomie.sleepingScheduleScore).abs() +
        (user.cporcpiScore - roomie.cporcpiScore).abs() +
        (user.gamerScore - roomie.gamerScore).abs() +
        (user.studyHabitsScore - roomie.studyHabitsScore).abs() +
        (user.personalBelongingsScore - roomie.personalBelongingsScore).abs() +
        (user.dietScore - roomie.dietScore).abs() +
        (user.bathingScore - roomie.bathingScore).abs() +
        (user.socialBehaviourScore - roomie.socialBehaviourScore).abs() +
        (user.acousticPropertiesScore - roomie.acousticPropertiesScore).abs() +
        (user.tvWatcherScore - roomie.tvWatcherScore).abs();
    return _totalScore;
  }
}
