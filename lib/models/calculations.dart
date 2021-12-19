class Calculations {
  int id = 0;
  double calcHistory = 0;
  String date = '';
  

  Calculations(this.id, this.date, this.calcHistory);

  Calculations.fromJson(Map<String, dynamic> sessionMap) {
    id = sessionMap['id'] ?? 0;
    date = sessionMap['date'] ?? '';
    calcHistory = sessionMap['calcHistory'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'calcHistory': calcHistory,
    };
  }
}
