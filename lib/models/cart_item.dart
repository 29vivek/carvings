class CartItem {
  final int foodId;
  final String foodName;
  final String canteeenName;
  final int quantity;
  final int price;

  CartItem({this.foodId, this.foodName, this.canteeenName, this.quantity, this.price});

  CartItem.fromData(Map<String, dynamic> data)
  : foodId = data['FoodID'],
    foodName = data['Name'],
    canteeenName = data['CanteenName'],
    quantity = data['Quantity'],
    price = data['Price'];

  Map<String, dynamic> toJson() {
    return {
      'FoodID' : foodId,
      'Name' : foodName,
      'CanteenName': canteeenName,
      'Quantity' : quantity,
      'Price' : price,
    };
  }
}