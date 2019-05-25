import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whos_my_roomie/Utils/Person.dart';

class RoomieFinder {
  String _username, _roomiename; //, _name, _graduationYear, _collegeName;
  int _compatibility, _finalScore;
  DocumentReference userdata, roomiedata;
  Person user = Person();
  Person roomie = Person();

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
    });
    // user.giveScore();
    // roomie.giveScore();
  }

  int _calculateFinalScore() {
    user.giveScore();
    roomie.giveScore();
    int difference = (user.totalScore(roomie));
    return difference;
  }

  int roommateCompatibility() {
    _finalScore = _calculateFinalScore();
    _compatibility = (1 - ((_finalScore) / 26) * 100).toInt();
    //26 is the maxiamum possible score one can get in the score test while the minimum is 0
    return _compatibility;
  }
}
