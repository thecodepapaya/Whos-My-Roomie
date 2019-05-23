import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:whos_my_roomie/Pages/Dashboard.dart';

class FillForm extends StatefulWidget {
  FillForm({@required this.username});

  final String username;
  @override
  _FillFormState createState() => _FillFormState();
}

class _FillFormState extends State<FillForm> {
  var database;

  // String _gender;
  // String _sleepingSchedule;
  // String _cpiORcoding;
  // String _sharingPersonalBelonging;
  // String _studyPatterns;
  // String _gamer;
  // String _tvSeries;
  // String _socialBehaviour;
  // String _bathingHabits;
  // String _responsible;
  // String _diet;
  // String _acousticProperties;

  Gender gender = Gender();
  Cleanliness cleanliness = Cleanliness();
  SleepingSchedule sleepingSchedule = SleepingSchedule();
  CpiOrCP cporcpi = CpiOrCP();
  Gamer gamer = Gamer();
  StudyHabits studyHabits = StudyHabits();
  PersonalBelongings personalBelongings = PersonalBelongings();
  Diet diet = Diet();
  Bathing bathing = Bathing();
  SocialBehaviour socialBehaviour = SocialBehaviour();
  AcousticProperties acousticProperties = AcousticProperties();
  TVWatcher tvWatcher = TVWatcher();

  @override
  void initState() {
    database =
        Firestore.instance.collection("UserData").document(widget.username);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 30),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Select the most appropriate answers from below",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                _dropdownBuilder("Your gender", gender, genderOptions()),
                _dropdownBuilder(
                    "Cleanliness Habits", cleanliness, cleanlinessOptions()),
                _dropdownBuilder("Sleeping habits", sleepingSchedule,
                    sleepingScheduleOptions()),
                _dropdownBuilder("CP vs CPI", cporcpi, cpOrCpiOptions()),
                _dropdownBuilder("Gaming habits", gamer, gamerOptions()),
                _dropdownBuilder(
                    "Study Habits", studyHabits, studyHabitOptions()),
                _dropdownBuilder("Sharing Habits", personalBelongings,
                    personalBelongingsOptions()),
                _dropdownBuilder("Dietary Habits", diet, dietOptions()),
                _dropdownBuilder("Bathing Habits", bathing, bathingOptions()),
                _dropdownBuilder("Social Behavious", socialBehaviour,
                    socialBehaviourOptions()),
                _dropdownBuilder("Noisy-ness", acousticProperties,
                    acousticPropertiesOptions()),
                _dropdownBuilder("Movie Mania", tvWatcher, tvWatcherOptions()),
                Padding(
                  padding: EdgeInsets.all(30),
                  child: MaterialButton(
                    color: Colors.lightBlueAccent,
                    child: Text("Submit"),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    onPressed: () {
                      _validateAll();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _dropdownBuilder(String hint, var dropdownValue, List optionList) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(20),
          //child: Text(question),
        ),
        DropdownButton(
          isExpanded: true,
          hint: Text(hint),
          value: dropdownValue.value,
          items: optionList,
          onChanged: (var newVal) {
            setState(() {
              dropdownValue.value = newVal;
              print("dropdown Value: ${dropdownValue.value}");
            });
          },
        ),
      ],
    );
  }

  _validateAll() {
    if (gender.value == null ||
        cleanliness.value == null ||
        sleepingSchedule.value == null ||
        cporcpi.value == null ||
        gamer.value == null ||
        studyHabits.value == null ||
        personalBelongings.value == null ||
        diet.value == null ||
        bathing.value == null ||
        socialBehaviour.value == null ||
        acousticProperties.value == null ||
        tvWatcher.value == null) {
      Fluttertoast.showToast(
        msg: "All fields are required",
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.grey,
        textColor: Colors.black87,
      );
    } else {
      database.updateData({
        "Your gender": gender.value,
        "Cleanliness Habits": cleanliness.value,
        "Sleeping habits": sleepingSchedule.value,
        "CP vs CPI": cporcpi.value,
        "Gaming habits": gamer.value,
        "Study Habits": studyHabits.value,
        "Sharing Habits": personalBelongings.value,
        "Dietary Habits": diet.value,
        "Bathing Habits": bathing.value,
        "Social Behavious": socialBehaviour.value,
        "Noisy-ness": acousticProperties.value,
        "Movie Mania": tvWatcher.value,
        "formfilled": true,
      });
      Fluttertoast.showToast(
        msg: "All fields submitted",
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.grey,
        textColor: Colors.black87,
      );
      // Navigator.pop(context);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (BuildContext context) =>
                Dashboard(username: widget.username),
          ),
          (Route<dynamic> route) => false);
    }
  }

  List<DropdownMenuItem<String>> genderOptions() {
    return [
      DropdownMenuItem(
        value: "Female",
        child: Text("Female"),
      ),
      DropdownMenuItem(
        value: "Male",
        child: Text("Male"),
      ),
      DropdownMenuItem(
        value: "Non binary",
        child: Text("Non binary"),
      ),
    ];
  }

  List<DropdownMenuItem<String>> cleanlinessOptions() {
    return [
      DropdownMenuItem(
        value: "I cannot tolerate anything out of perfect order in my room",
        child: Text(
          "I cannot tolerate anything out of perfect order in my room",
        ),
      ),
      DropdownMenuItem(
        value: "I can tolerate a slight disorder in my room",
        child: Text(
          "I can tolerate a slight disorder in my room",
        ),
      ),
      DropdownMenuItem(
        value: "Entropy is a force of nature, and I do not go againt it",
        child: Text(
          "Entropy is a force of nature, and I do not go againt it",
        ),
      ),
    ];
  }

  List<DropdownMenuItem<String>> sleepingScheduleOptions() {
    return [
      DropdownMenuItem(
        value: "I basically sleep through the whole day",
        child: Text(
          "I basically sleep through the whole day",
        ),
      ),
      DropdownMenuItem(
        value: "I sleep for almost 8 hours a day",
        child: Text(
          "I sleep for almost 8 hours a day",
        ),
      ),
      DropdownMenuItem(
        value: "I usually wake up till late nights",
        child: Text(
          "I usually wake up till late nights",
        ),
      ),
      DropdownMenuItem(
        value: "I follow the 'early to bed and early to rise formula'",
        child: Text(
          "I follow the 'early to bed and early to rise formula'",
          maxLines: 4,
          softWrap: true,
        ),
      ),
      DropdownMenuItem(
        value: "What is sleep? Do you sleep?",
        child: Text(
          "What is sleep? Do you sleep?",
        ),
      ),
    ];
  }
}

List<DropdownMenuItem<String>> cpOrCpiOptions() {
  return [
    DropdownMenuItem(
      value: "I want a good CPI at the end of 4 years",
      child: Text(
        "I want a good CPI at the end of 4 years",
      ),
    ),
    DropdownMenuItem(
      value: "I want to be good at Competetive programming",
      child: Text(
        "I want to be good at Competetive programming",
      ),
    ),
  ];
}

List<DropdownMenuItem<String>> gamerOptions() {
  return [
    DropdownMenuItem(
      value: "I can play games all day long if I got the chance",
      child: Text(
        "I can play games all day long if I got the chance",
      ),
    ),
    DropdownMenuItem(
      value: "I'm a casual player, I play once in a while",
      child: Text(
        "I'm a casual player, I play once in a while",
      ),
    ),
    DropdownMenuItem(
      value: "I don't play games at all",
      child: Text(
        "I don't play games at all",
      ),
    ),
  ];
}

List<DropdownMenuItem<String>> studyHabitOptions() {
  return [
    DropdownMenuItem(
      value: "I study regularly all the time",
      child: Text(
        "I study regularly all the time",
      ),
    ),
    DropdownMenuItem(
      value: "I study sometimes but not regularly",
      child: Text(
        "I study sometimes but not regularly",
      ),
    ),
    DropdownMenuItem(
      value: "I always study only a day before the exams",
      child: Text(
        "I always study only a day before the exams",
      ),
    ),
    DropdownMenuItem(
      value: "I don't study at all",
      child: Text(
        "I don't study at all",
      ),
    ),
  ];
}

List<DropdownMenuItem<String>> personalBelongingsOptions() {
  return [
    DropdownMenuItem(
      value:
          "I cannot tolerate anybody using my belongings without my permission",
      child: Text(
        "I cannot tolerate anybody using my belongings without my permission",
      ),
    ),
    DropdownMenuItem(
      value:
          "I don't have any problem as long as my belongings are returned in one peice",
      child: Text(
        "I don't have any problem as long as my belongings are returned in one peice",
      ),
    ),
    DropdownMenuItem(
      value:
          "I have absolutely no problem if anybody uses my personal belongings",
      child: Text(
        "I have absolutely no problem if anybody uses my personal belongings",
      ),
    ),
  ];
}

List<DropdownMenuItem<String>> dietOptions() {
  return [
    DropdownMenuItem(
      value:
          "I'm a vegan / I cannot tolerate any non vegetarian food in my room",
      child: Text(
        "I'm a vegan / I cannot tolerate any non vegetarian food in my room",
      ),
    ),
    DropdownMenuItem(
      value:
          "I'm a vegatarian / I can tolerate small amount of non-vegetarian food in my room",
      child: Text(
        "I'm a vegatarian / I can tolerate small amount of non-vegetarian food in my room",
      ),
    ),
    DropdownMenuItem(
      value: "I'm non-vegetarian / I don't care what my roommate eats",
      child: Text(
        "I'm non-vegetarian / I don't care what my roommate eats",
      ),
    ),
  ];
}

List<DropdownMenuItem<String>> bathingOptions() {
  return [
    DropdownMenuItem(
      value: "I cannot live peacefully without bathing twice a day",
      child: Text(
        "I cannot live peacefully without bathing twice a day",
      ),
    ),
    DropdownMenuItem(
      value: "I bath daily but I do not have any problem skipping a day",
      child: Text(
        "I bath daily but I do not have any problem skipping a day",
      ),
    ),
    DropdownMenuItem(
      value: "I bath only when I think I absolutely need to",
      child: Text(
        "I bath only when I think I absolutely need to",
      ),
    ),
  ];
}

List<DropdownMenuItem<String>> socialBehaviourOptions() {
  return [
    DropdownMenuItem(
      value: "I like to spend my day alone in my room without disturbances",
      child: Text(
        "I like to spend my day alone in my room without disturbances",
      ),
    ),
    DropdownMenuItem(
      value: "I like to go out occasionally and have fun outdoors",
      child: Text(
        "I like to go out occasionally and have fun outdoors",
      ),
    ),
    DropdownMenuItem(
      value: "I hardly stay in my own room",
      child: Text(
        "I hardly stay in my own room",
      ),
    ),
  ];
}

List<DropdownMenuItem<String>> acousticPropertiesOptions() {
  return [
    DropdownMenuItem(
      value: "I like to play music and media on high volume always",
      child: Text(
        "I like to play music and media on high volume always",
      ),
    ),
    DropdownMenuItem(
      value: "I like loud music but I prefer it with headphones",
      child: Text(
        "I like loud music but I prefer it with headphones",
      ),
    ),
    DropdownMenuItem(
      value: "I love total silence",
      child: Text(
        "I love total silence",
      ),
    ),
  ];
}

List<DropdownMenuItem<String>> tvWatcherOptions() {
  return [
    DropdownMenuItem(
      value:
          "I've finished watching GOT, F.R.I.E.N.D.S, Bib Bang theory and a dozen other animes",
      child: Text(
        "I've finished watching GOT, F.R.I.E.N.D.S, Bib Bang theory and a dozen other animes",
      ),
    ),
    DropdownMenuItem(
      value: "I watch TV series and / or animes in my free time",
      child: Text(
        "I watch TV series and / or animes in my free time",
      ),
    ),
    DropdownMenuItem(
      value: "I do not watch any TV series or anime",
      child: Text(
        "I do not watch any TV series or anime",
      ),
    ),
  ];
}

//wrapper classes to utilise pass by reference in dropdownBuilder func
//and reduce the boilerplate code
class Gender {
  String value;
}

class Cleanliness {
  String value;
}

class SleepingSchedule {
  String value;
}

class CpiOrCP {
  String value;
}

class Gamer {
  String value;
}

class StudyHabits {
  String value;
}

class PersonalBelongings {
  String value;
}

class Diet {
  String value;
}

class Bathing {
  String value;
}

class SocialBehaviour {
  String value;
}

class AcousticProperties {
  String value;
}

class TVWatcher {
  String value;
}
