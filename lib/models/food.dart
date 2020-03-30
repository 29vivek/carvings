class Food {

  final int id;
  final String name;
  final int price;
  final bool availability;
  final num rating;
  final int numberRatings;
  final String category;
  final String canteenName;

  Food({this.id, this.name, this.price, this.availability, this.rating, this.numberRatings, this.category, this.canteenName});

  Food.fromData(Map<String, dynamic> data) 
    : id = data['FoodID'],
      name = data['Name'],
      price = data['Price'],
      availability = data['Availability'] > 0 ? true : false,
      rating = data['Rating'],
      numberRatings = data['NumberRatings'],
      category = data['Category'],
      canteenName = data['CanteenName'];

  Map<String, dynamic> toJson() {
    return {
      'FoodID' : id,
      'Name' : name,
      'Price' : price,
      'Availability' : availability ? 1 : 0,
      'Rating' : rating,
      'NumberRatings' : numberRatings,
      'Category' : category,
      'CanteenName' : canteenName,
    };
  }
  
}