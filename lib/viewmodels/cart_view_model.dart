import 'package:carvings/locator.dart';
import 'package:carvings/models/cart_item.dart';
import 'package:carvings/services/authentication_service.dart';
import 'package:carvings/services/database_service.dart';
import 'package:carvings/services/dialog_service.dart';
import 'package:carvings/services/food_service.dart';
import 'package:carvings/viewmodels/base_model.dart';

class CartViewModel extends BaseModel {

  DatabaseService _databaseService = locator<DatabaseService>();
  AuthenticationService _authenticationService = locator<AuthenticationService>();
  FoodService _foodService = locator<FoodService>();
  DialogService _dialogService = locator<DialogService>();
  
  List<CartItem> _cartItems;
  List<CartItem> get cartItems => _cartItems;
  
  void getCartItems() async {

    _cartItems = null;
    notifyListeners();
    // have to do it twice, idk why

    _cartItems = await _databaseService.getCartItems();
    notifyListeners();
    
  }

  void placeOrder() async {

    setBusy(true);

    Map<String, dynamic> bundle = {
      'user' : _authenticationService.currentUser.id,
      'number' : _cartItems.length,
      'items' : {},
      'total' : 0
    };
    int orderTotal = 0;
    for(var item in _cartItems) {
      bundle['items']['${item.foodId}'] = item.quantity;
      orderTotal += item.quantity * item.price;
    }
    bundle['total'] = orderTotal;

    print(bundle);

    var result = await _foodService.placeOrder(bundle: bundle);
    if(result is String) {
      _dialogService.showDialog(
        title: 'Error Occurred!',
        description: result,
      );
    } else {
      _dialogService.showDialog(
        title: 'Success!',
        description: 'Order placed successfully! Your total bill amounts up to ₹$orderTotal.',
      );
      await _databaseService.clearCart();
      _cartItems = await _databaseService.getCartItems();
    }

    setBusy(false);

  }

  void updateCartItem(int i, int value) async {

    await _databaseService.updateCartItemQuantity(_cartItems[i].foodId, value);
    notifyListeners();

  }

  void removeFromCart(int i) async {

    await _databaseService.deleteCartItem(_cartItems[i].foodId);
    getCartItems();

  }

}