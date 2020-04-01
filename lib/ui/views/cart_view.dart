import 'package:carvings/ui/shared/shared_styles.dart';
import 'package:carvings/ui/shared/ui_helpers.dart';
import 'package:carvings/ui/widgets/busy_button.dart';
import 'package:carvings/ui/widgets/cart_card.dart';
import 'package:carvings/ui/widgets/loading_card.dart';
import 'package:carvings/ui/widgets/note_text.dart';
import 'package:carvings/viewmodels/cart_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider_architecture/viewmodel_provider.dart';

class CartView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<CartViewModel>.withConsumer(
      viewModel: CartViewModel(),
      onModelReady: (model) => model.getCartItems(),
      builder: (context, model, child) => PlatformScaffold(
        backgroundColor: Colors.white,
        body: RefreshIndicator(
          onRefresh: () async => model.getCartItems(),
          child: Padding(
            padding: defaultPadding(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Your Cart', style: headerTextStyle),
                verticalSpaceMedium,
                model.cartItems != null
                ? Expanded(
                  child: model.cartItems.length != 0
                    ? ListView.separated(
                        itemBuilder: (context, i) => Dismissible(
                          key: Key(model.cartItems[i].foodId.toString()), 
                          child: CartCard(
                            item: model.cartItems[i],
                            isCartItem: true,
                            onChanged: (int value) { model.updateCartItem(i, value); },
                          ),
                          direction: DismissDirection.endToStart,
                          onDismissed: (_) => model.removeFromCart(i),
                          background: Container(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: EdgeInsets.only(right: 16),
                                child: FaIcon(FontAwesomeIcons.trashAlt, size: 20,),
                              ),
                            )
                          ),
                        ),
                        itemCount: model.cartItems.length,
                        separatorBuilder:(context, i) => smallSpacedDivider,
                      )
                    : ListView(
                        children: [
                          NoteText('Your cart is empty! You don\'t even wanna have a samosa? Or a tea even?')
                        ]
                      )
                  )
                : LoadingCard(),
                verticalSpaceMedium,
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                      BusyButton(
                        busy: model.busy,
                        enabled: model.cartItems != null && model.cartItems.length > 0,
                        title: 'Place Order', 
                        onPressed: () {
                          model.placeOrder();
                        }
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}