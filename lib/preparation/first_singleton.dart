class FirstSingleton {
  FirstSingleton._internal();
  static final FirstSingleton _instance = FirstSingleton._internal();

  factory FirstSingleton() {
    return _instance;
  }
}

class AnotherSingleton {
  AnotherSingleton._privateConstructor();
  static final AnotherSingleton _instance =
      AnotherSingleton._privateConstructor();

  factory AnotherSingleton() {
    return _instance;
  }
}

class AnotherSingletonTwo {
  AnotherSingletonTwo._privateConstructor();

  static final AnotherSingletonTwo _instance =
      AnotherSingletonTwo._privateConstructor();

  static AnotherSingletonTwo get instnce => _instance;
}

class AnotherSingletonThree {
  // AnotherSingletonThree._privateConstructor();

  static final AnotherSingletonThree instance = AnotherSingletonThree();
  // AnotherSingletonThree._privateConstructor();
}
