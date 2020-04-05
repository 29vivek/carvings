import 'package:carvings/ui/views/cart_view.dart';
import 'package:carvings/ui/views/browse_view.dart';
import 'package:carvings/ui/views/pending_view.dart';
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
  
  final _views = [
    BrowseView(),
    SearchView(),
    CartView(),
    ProfileView(),
  ];

  final _adminViews = [
    BrowseView(),
    SearchView(),
    PendingView(),
    ProfileView(),
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
          itemCount: model.role == 'User' ? _views.length : _adminViews.length,
          itemBuilder: (_, index) => model.role == 'User' ? _views[index] : _adminViews[index],
        ),
        bottomNavBar: PlatformNavBar(
          android: (_) => MaterialNavBarData(
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: false,
            showUnselectedLabels: false,
          ),
          currentIndex: model.index,
          items: <BottomNavigationBarItem> [
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.utensils),
              title: NoteText('Browse'),
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.search,),
              title: NoteText('Search'),
            ),
            BottomNavigationBarItem(
              icon: model.role == 'User' ? FaIcon(FontAwesomeIcons.shoppingBasket,) : FaIcon(FontAwesomeIcons.bolt),
              title: model.role == 'User' ? NoteText('Cart') : NoteText('Pending'),
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.userAlt,),
              title: NoteText('Profile'),
            ),
          ],
          itemChanged: (int tab) {
            FocusScope.of(context).unfocus();
            // nice little hack #iforgotthecount
            model.changeTab(tab);
          } ,
        ),
      ),
    );
  }
}