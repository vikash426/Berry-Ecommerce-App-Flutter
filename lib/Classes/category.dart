
class Category{
  int id;
  String name;

  Category({this.id,this.name});
  factory Category.fromJson(Map<String, dynamic> json){
    return Category(
      id:json['category_id'] as int,
      name: json['category_name'] as String
    );
  }
}