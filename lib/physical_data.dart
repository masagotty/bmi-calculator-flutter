import 'package:flutter/foundation.dart';

enum Gender { male, female, none }

class PhysicalData extends ChangeNotifier {
  Gender _selectedGender = Gender.none;
  int _height = 180;
  int _weight = 70;
  int _age = 25;

  Gender get getGender {
    return _selectedGender;
  }

  int get getHeight {
    return _height;
  }

  int get getWeight {
    return _weight;
  }

  int get getAge {
    return _age;
  }

  void changeHeight(inputHeight) {
    _height = inputHeight;
    notifyListeners();
  }

  void incrementWeight() {
    _weight++;
    notifyListeners();
  }

  void decrementWeight() {
    _weight--;
    notifyListeners();
  }

  void incrementAge() {
    _age++;
    notifyListeners();
  }

  void decrementAge() {
    _age--;
    notifyListeners();
  }

  void toggleMale() {
    _selectedGender = Gender.male;
    notifyListeners();
  }

  void toggleFemale() {
    _selectedGender = Gender.female;
    notifyListeners();
  }
}
