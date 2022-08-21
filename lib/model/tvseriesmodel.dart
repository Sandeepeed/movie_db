
class TvSeriesModel{
  final String? name;
  final int? id;
  final String? description;
  final String? imgUrl;
  final  rating;

  TvSeriesModel({this.id,  this.name, this.description, this.rating, this.imgUrl});
  factory TvSeriesModel.fromMap(Map<String, dynamic> jsonData)
  {
    return TvSeriesModel(
      id: jsonData['id'],
      imgUrl:jsonData['poster_path'],
      description: jsonData['overview'],
      name: jsonData['name'],
      rating: jsonData['vote_average'],
    );
  }
}