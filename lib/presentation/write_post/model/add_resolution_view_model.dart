class AddResolutionViewModel {
  int focusedStep = 0;
  int currentStep = 0;
  int maxStep = 5;

  List<bool> inputConditions = [false, false, false, true, true];

  String name = '';
  String goal = '';
  String action = '';

  double timesTemp = 7;
  int times = 7;
  String timesLabel = '매일매일';
  int pointColorIndex = 0;
  int iconIndex = 0;

  bool isMovableToNextStep = false;
}
