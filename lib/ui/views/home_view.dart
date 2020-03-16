import 'package:carvings/ui/views/cart_view.dart';
import 'package:carvings/ui/views/browse_view.dart';
import 'package:carvings/ui/views/profile_view.dart';
import 'package:carvings/ui/views/search_view.dart';
import 'package:carvings/ui/widgets/lazy_indexed_stack.dart';
import 'package:carvings/ui/widgets/note_text.dart';
import 'package:carvings/viewmodels/home_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider_architecture/provider_architecture.dart';

class HomeView extends StatelessWidget {
  
  final _userViews = [
    BrowseView(),
    SearchView(),
    CartView(),
    ProfileView(),
  ];

  final _adminViews = [

  ];

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<HomeViewModel>.withConsumer(
      viewModel: HomeViewModel(),
      onModelReady: (model) => model.findRole(),
      builder: (context, model, child) => PlatformScaffold(
        body: LazyIndexedStack(
          reuse: true,
          index: model.index, 
          itemCount: model.role == 'User' ? _userViews.length : _adminViews.length,
          itemBuilder: (_, index) => model.role == 'User' ? _userViews[index] : _adminViews[index],
        ),
        bottomNavBar: PlatformNavBar(
          currentIndex: model.index,
          items: <BottomNavigationBarItem> [
            BottomNavigationBarItem(
              icon: PlatformWidget(
                android: (_) => FaIcon(FontAwesomeIcons.utensilSpoon, color: Colors.grey[600],),
                ios: (_) => FaIcon(FontAwesomeIcons.utensilSpoon, color: Colors.grey[600],),
              ),
              activeIcon: PlatformWidget(
                android: (_) => FaIcon(FontAwesomeIcons.utensilSpoon, color: Theme.of(context).primaryColor),
                ios: (_) => FaIcon(FontAwesomeIcons.utensilSpoon, color: Theme.of(context).primaryColor,),
              ),
              title: NoteText('Browse'),
            ),
            BottomNavigationBarItem(
              icon: PlatformWidget(
                android: (_) => FaIcon(FontAwesomeIcons.search, color: Colors.grey[600],),
                ios: (_) => FaIcon(FontAwesomeIcons.search, color: Colors.grey[600],),
              ),
              activeIcon: PlatformWidget(
                android: (_) => FaIcon(FontAwesomeIcons.search, color: Theme.of(context).primaryColor),
                ios: (_) => FaIcon(FontAwesomeIcons.search, color: Theme.of(context).primaryColor,),
              ),
              title: NoteText('Search'),
            ),
            BottomNavigationBarItem(
              icon: PlatformWidget(
                android: (_) => Icon(Icons.shopping_cart, color: Colors.grey[600],),
                ios: (_) => Icon(CupertinoIcons.shopping_cart, color: Colors.grey[600],),
              ),
              activeIcon: PlatformWidget(
                android: (_) => Icon(Icons.shopping_cart, color: Theme.of(context).primaryColor),
                ios: (_) => Icon(CupertinoIcons.shopping_cart, color: Theme.of(context).primaryColor),
              ),
              title: NoteText('Cart'),
            ),
            BottomNavigationBarItem(
              icon: PlatformWidget(
                android: (_) => Icon(Icons.person, color: Colors.grey[600],),
                ios: (_) => Icon(CupertinoIcons.person, color: Colors.grey[600],),
              ),
              activeIcon: PlatformWidget(
                android: (_) => Icon(Icons.person, color: Theme.of(context).primaryColor),
                ios: (_) => Icon(CupertinoIcons.person, color: Theme.of(context).primaryColor),
              ),
              title: NoteText('Profile'),
            ),
          ],
          itemChanged: model.changeTab,
        ),
      ),
    );
  }
}