// data holder class for people

class Person {
  // String name, graduationYear, collegeName, username;
  String gender;
  String cleanliness;
  String sleepingSchedule;
  String cporcpi;
  String gamer;
  String studyHabits;
  String personalBelongings;
  String diet;
  String bathing;
  String socialBehaviour;
  String acousticProperties;
  String tvWatcher;

  int genderScore;
  int cleanlinessScore;
  int sleepingScheduleScore;
  int cporcpiScore;
  int gamerScore;
  int studyHabitsScore;
  int personalBelongingsScore;
  int dietScore;
  int bathingScore;
  int socialBehaviourScore;
  int acousticPropertiesScore;
  int tvWatcherScore;

  int _totalScore;

  int totalScore(Person roomie) {
    _totalScore = (this.genderScore - roomie.genderScore).abs() +
        (this.cleanlinessScore - roomie.cleanlinessScore).abs() +
        (this.sleepingScheduleScore - roomie.sleepingScheduleScore).abs() +
        (this.cporcpiScore - roomie.cporcpiScore).abs() +
        (this.gamerScore - roomie.gamerScore).abs() +
        (this.studyHabitsScore - roomie.studyHabitsScore).abs() +
        (this.personalBelongingsScore - roomie.personalBelongingsScore).abs() +
        (this.dietScore - roomie.dietScore).abs() +
        (this.bathingScore - roomie.bathingScore).abs() +
        (this.socialBehaviourScore - roomie.socialBehaviourScore).abs() +
        (this.acousticPropertiesScore - roomie.acousticPropertiesScore).abs() +
        (this.tvWatcherScore - roomie.tvWatcherScore).abs();
    return _totalScore;
  }

  void giveScore() {
    giveGenderScore();
    giveCleanlinessScore();
    giveSleepingScheduleScore();
    giveCporcpiScore();
    giveGamerScore();
    giveStudyHabitsScore();
    givePersonalBelongingsScore();
    giveDietScore();
    giveBathingScore();
    giveSocialBehaviourScore();
    giveAcousticPropertiesScore();
    giveTvWatcherScore();
  }

  void giveGenderScore() {
    switch (gender) {
      case "Female":
        genderScore = 0;
        break;
      case "Non binary":
        genderScore = 1;
        break;
      case "Male":
        genderScore = 2;
        break;
    }
  }

  void giveCleanlinessScore() {
    switch (cleanliness) {
      case "I cannot tolerate anything out of perfect order in my room":
        cleanlinessScore = 0;
        break;
      case "I can tolerate a slight disorder in my room":
        cleanlinessScore = 1;
        break;
      case "Entropy is a force of nature, and I do not go againt it":
        cleanlinessScore = 2;
        break;
    }
  }

  void giveSleepingScheduleScore() {
    switch (sleepingSchedule) {
      case "I basically sleep through the whole day":
        sleepingScheduleScore = 0;
        break;
      case "I sleep for almost 8 hours a day":
        sleepingScheduleScore = 1;
        break;
      case "I usually wake up till late nights":
        sleepingScheduleScore = 2;
        break;
      case "I follow the 'early to bed and early to rise' formula":
        sleepingScheduleScore = 3;
        break;
      case "What is sleep? Do you sleep?":
        sleepingScheduleScore = 3;
        break;
    }
  }

  void giveCporcpiScore() {
    switch (cporcpi) {
      case "I want a good CPI at the end of 4 years":
        cporcpiScore = 0;
        break;
      case "I want to be good at Competitive programming":
        cporcpiScore = 1;
        break;
    }
  }

  void giveGamerScore() {
    switch (gamer) {
      case "I can play games all day long if I got the chance":
        gamerScore = 0;
        break;
      case "I'm a casual player, I play once in a while":
        gamerScore = 1;
        break;
      case "I don't play games at all":
        gamerScore = 2;
        break;
    }
  }

  void giveStudyHabitsScore() {
    switch (studyHabits) {
      case "I study regularly all the time":
        studyHabitsScore = 0;
        break;
      case "I study sometimes but not regularly":
        studyHabitsScore = 1;
        break;
      case "I always study only a day before the exams":
        studyHabitsScore = 2;
        break;
      case "I don't study at all":
        studyHabitsScore = 3;
        break;
    }
  }

  void givePersonalBelongingsScore() {
    switch (personalBelongings) {
      case "I cannot tolerate anybody using my belongings without my permission":
        personalBelongingsScore = 0;
        break;
      case "I don't have any problem as long as my belongings are returned in one peice":
        personalBelongingsScore = 1;
        break;
      case "I have absolutely no problem if anybody uses my personal belongings":
        personalBelongingsScore = 2;
        break;
    }
  }

  void giveDietScore() {
    switch (diet) {
      case "I'm a vegan / I cannot tolerate any non vegetarian food in my room":
        dietScore = 0;
        break;
      case "I'm a vegatarian / I can tolerate small amount of non-vegetarian food in my room":
        dietScore = 1;
        break;
      case "I'm non-vegetarian / I don't care what my roommate eats":
        dietScore = 2;
        break;
    }
  }

  void giveBathingScore() {
    switch (bathing) {
      case "I cannot live peacefully without bathing twice a day":
        bathingScore = 0;
        break;
      case "I bath daily but I do not have any problem skipping a day":
        bathingScore = 1;
        break;
      case "I bath only when I think I absolutely need to":
        bathingScore = 2;
        break;
    }
  }

  void giveSocialBehaviourScore() {
    switch (socialBehaviour) {
      case "I like to spend my day alone in my room without disturbances":
        socialBehaviourScore = 0;
        break;
      case "I like to go out occasionally and have fun outdoors":
        socialBehaviourScore = 1;
        break;
      case "I hardly stay in my own room":
        socialBehaviourScore = 2;
        break;
    }
  }

  void giveAcousticPropertiesScore() {
    switch (acousticProperties) {
      case "I like to play music and media on high volume always":
        acousticPropertiesScore = 0;
        break;
      case "I like loud music but I prefer it with headphones":
        acousticPropertiesScore = 1;
        break;
      case "I love total silence":
        acousticPropertiesScore = 2;
        break;
    }
  }

  void giveTvWatcherScore() {
    switch (tvWatcher) {
      case "I've finished watching GOT, F.R.I.E.N.D.S, Bib Bang theory and a dozen other animes":
        tvWatcherScore = 0;
        break;
      case "I watch TV series and / or animes only in my free time":
        tvWatcherScore = 1;
        break;
      case "I do not watch any TV series or anime":
        tvWatcherScore = 2;
        break;
    }
  }
}
