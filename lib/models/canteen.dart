class Canteen {
  final int id;
  final String name;
  final String description;
  final List<Category> categories;

  Canteen({this.id, this.name, this.description, this.categories});

  Canteen.fromData(Map<String, dynamic> data)
    : id = data['CanteenID'],
      name = data['CanteenName'],
      description = data['CanteenDescription'],
      categories = Category.fromList(data['Categories']);

  Map<String, dynamic> toJson() {
    return {
      'CanteenID' : id,
      'CanteenName' : name,
      'CanteenDescription' : description,
    };
  }
}

class Category {
  final int categoryId;
  final String categoryName;

  Category.fromData(Map<String, dynamic> data)
    : categoryId = data['CategoryID'],
      categoryName = data['CategoryName'];

  Category({this.categoryId, this.categoryName});

  static List<Category> fromList(List<dynamic> list)
    => list.map((item) => Category.fromData(item)).toList();


}