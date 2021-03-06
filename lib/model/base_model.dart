class BaseModel {
  int id;
  String title;
  String description;
  String date;
  String maker;

  BaseModel({this.id, this.title, this.description, this.date, this.maker});

  BaseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    date = json['date'];
    maker = json['maker'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['date'] = this.date;
    data['maker'] = this.maker;
    return data;
  }
}
