enum Gender {
  Male,
  Female,
}
enum Sect {
  Sunni,
  Shia,
}

enum Religiousness {
  VeryPractising,
  Practising,
  SomewhatPractising,
  NotPractising,
}

enum Modesty {
  Hijab,
  Modest,
  None,
}

enum Prayer {
  Always,
  Usually,
  Sometimes,
  Never,
}

enum Halal {
  Always,
  Usually,
  Sometimes,
  Never,
}

enum Drinks {
  Always,
  Usually,
  Sometimes,
  Never,
}

enum Smokes {
  Always,
  Usually,
  Sometimes,
  Never,
}

class EnumHelper {
  static Prayer PrayerFromString(String frequency) {
    switch(frequency) {
      case "always":
        return Prayer.Always;
      case "usually":
        return Prayer.Usually;
      case "sometimes":
        return Prayer.Sometimes;
      case "never":
        return Prayer.Never;
    }
    throw Exception("The following Prayer is not valid:" + frequency);
  }

  static Halal HalalFromString(String frequency) {
    switch(frequency) {
      case "always":
        return Halal.Always;
      case "usually":
        return Halal.Usually;
      case "sometimes":
        return Halal.Sometimes;
      case "never":
        return Halal.Never;
    }
    throw Exception("The following Halal is not valid:" + frequency);
  }

  static Drinks DrinksFromString(String frequency) {
    switch(frequency) {
      case "always":
        return Drinks.Always;
      case "usually":
        return Drinks.Usually;
      case "sometimes":
        return Drinks.Sometimes;
      case "never":
        return Drinks.Never;
    }
    throw Exception("The following Drinks is not valid:" + frequency);
  }

  static Smokes SmokesFromString(String frequency) {
    switch(frequency) {
      case "always":
        return Smokes.Always;
      case "usually":
        return Smokes.Usually;
      case "sometimes":
        return Smokes.Sometimes;
      case "never":
        return Smokes.Never;
    }
    throw Exception("The following Smokes is not valid:" + frequency);
  }

  static Gender GenderFromString(String gender) {
    switch(gender) {
      case "male":
        return Gender.Male;
      case "female":
        return Gender.Female;
    }
    throw Exception("The following Gender is not valid:" + gender);
  } 

  static Sect SectFromString(String sect) {
    switch(sect) {
      case "sunni":
        return Sect.Sunni;
      case "shia":
        return Sect.Shia;
    }
    throw Exception("The following Sect is not valid:" + sect);
  } 

  static Religiousness ReligiousnessFromString(String religiousness) {
    switch(religiousness) {
      case "verypractising":
        return Religiousness.VeryPractising;
      case "practising":
        return Religiousness.Practising;
      case "somewhatpractising":
        return Religiousness.SomewhatPractising;
      case "notpractising":
        return Religiousness.NotPractising;
    }
    throw Exception("The following Religiousness is not valid:" + religiousness);
  } 

  static Modesty ModestyFromString(String modesty) {
    switch(modesty) {
      case "hijab":
        return Modesty.Hijab;
      case "modest":
        return Modesty.Modest;
      case "none":
        return Modesty.None;
    }
    throw Exception("The following Modesty is not valid:" + modesty);
  } 

}