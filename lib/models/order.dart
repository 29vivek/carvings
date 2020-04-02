class Order {
  final int orderId;
  final List<OrderItem> items;
  final int total;
  final String when;
  final String status;

  Order({this.orderId, this.items, this.total, this.when, this.status});

  Order.fromData(Map<String, dynamic> data)
  : orderId = data['OrderID'],
    total = data['OrderTotal'],
    when = data['OrderTime'],
    items = OrderItem.fromList(data['Items']),
    status = data['OrderStatus'];

}

class OrderItem {
  final int orderItemId;
  final int foodId;
  final String foodName;
  final int price;
  final int quantity;
  final String canteenName;
  final int didRateFood;

  OrderItem({this.orderItemId, this.foodId, this.foodName, this.price, this.quantity, this.canteenName, this.didRateFood});

  OrderItem.fromData(dynamic data)
  : orderItemId = data['OrderItemID'],
    foodId = data['FoodID'],
    foodName = data['Name'],
    price = data['Price'],
    quantity = data['Quantity'],
    canteenName = data['CanteenName'],
    didRateFood = data['DidRateFood'];

  static List<OrderItem> fromList(List<dynamic> data) {
    var items = List<OrderItem>();
    for(var item in data) {
      items.add(OrderItem.fromData(item));
    }
    return items;
  }  

}