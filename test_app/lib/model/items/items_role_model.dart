class RoleModel {

  int? id;
  String? dateCreated;
  String? dateUpdated;
  String? description;
  String? title;
  String? requirement;

  RoleModel({
    this.title,
    this.id,
    this.dateCreated,
    this.dateUpdated,
    this.description,
    this.requirement
  });

  factory RoleModel.fromJson(Map? json) => RoleModel(
    id: json?["id"],
    dateCreated: json?["date_created"],
    dateUpdated: json?["date_updated"],
    description: json?["description"],
    title: json?["title"],
    requirement: json?["requirement"],
  );

  Map toJson() => {
    "title" : title,
    "description" : description,
    "requirement" : requirement
  };

}