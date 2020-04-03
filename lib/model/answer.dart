class Answer {
  String option;
  String result;

  Answer({this.option, this.result});

  Answer.fromJson(Map<String, dynamic> json) {
    this.option = json['option'];
    this.result = json['result'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['option'] = this.option;
    data['result'] = this.result;
    return data;
  }
}
