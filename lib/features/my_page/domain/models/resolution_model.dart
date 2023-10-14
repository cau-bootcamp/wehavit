class ResolutionModel {
  ResolutionModel({
    required this.goal,
    required this.action,
    required this.period,
    required this.startDate,
  });

  bool isActive = true;

  String goal;
  String action;
  int period;
  DateTime startDate;

  // List<> confirmationList;
}
