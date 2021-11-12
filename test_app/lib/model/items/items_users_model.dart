class UsersModel {

  int? id;
  String? dateCreated;
  String? dateUpdated;
  String? fullName;
  String? phone;
  String? email;
  String? address;
  dynamic type;
  List? userExperiences;
  List? userEducations;

  UsersModel({
    this.dateUpdated,
    this.dateCreated,
    this.id,
    this.email,
    this.type,
    this.address,
    this.fullName,
    this.phone,
    this.userEducations,
    this.userExperiences
  });

  factory UsersModel.fromJson(Map? json) => UsersModel(
    id: json?["id"],
    dateCreated: json?["date_created"],
    dateUpdated: json?["date_updated"],
    fullName: json?["fullname"],
    phone: json?["phone"],
    email: json?["email"],
    address: json?["address"],
    type: json?["type"],
    userExperiences: json?["user_experiences"],
    userEducations: json?["user_educations"],
  );



}