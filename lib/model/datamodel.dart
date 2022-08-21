class MovieModel{
  int? id;
  String? imgUrl;
  String? description;
  String? title;
  final rating;
  MovieModel({this.id,this.imgUrl,this.description,this.title,this.rating});
  factory MovieModel.fromMap(Map<String, dynamic> jsonData)
  {
    return MovieModel(
      id: jsonData['id'],
      imgUrl:jsonData['poster_path'],
      description: jsonData['overview'],
      title: jsonData['title'],
      rating: jsonData['vote_average'],
    );
  }
}