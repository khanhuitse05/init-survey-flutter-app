class Answer {
  String option;
  String result;

  Answer({this.option = '', this.result = ''});

  Answer.fromJson(Map<String, dynamic> json)
      : option = json['option'] ?? '',
        result = json['result'] ?? '';

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['option'] = option;
    data['result'] = result;
    return data;
  }
}
