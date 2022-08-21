class CastModel {
  String? name;
  String? profilePath;
  String? actorName;
  CastModel({this.name, this.profilePath, this.actorName});
  factory CastModel.fromMap(Map<String,dynamic> jsonData)
  {
    return CastModel(
        name: jsonData['character'],
        profilePath: jsonData['profile_path'],
        actorName: jsonData['original_name']
    );
  }
}