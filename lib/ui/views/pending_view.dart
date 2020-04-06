import 'package:carvings/ui/shared/shared_styles.dart';
import 'package:carvings/ui/shared/ui_helpers.dart';
import 'package:carvings/ui/widgets/loading_card.dart';
import 'package:carvings/ui/widgets/note_text.dart';
import 'package:carvings/ui/widgets/order_card.dart';
import 'package:carvings/ui/widgets/text_link.dart';
import 'package:carvings/viewmodels/pending_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider_architecture/provider_architecture.dart';

class PendingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<PendingViewModel>.withConsumer(
      viewModel: PendingViewModel(), 
      onModelReady: (model) => model.getPendingOrders(),
      builder: (context, model, child) => PlatformScaffold(
        backgroundColor: Colors.white,
        body: RefreshIndicator(
          onRefresh: () async => model.getPendingOrders(),
          child: Padding(
            padding: defaultPadding(context),
            child: CustomScrollView(
              slivers: <Widget>[
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        'Pending Orders',
                        style: headerTextStyle,
                      ),
                      verticalSpaceMedium,
                      TextLink('Complete all Pending Orders', 
                        onPressed: () => model.completeOrder(),
                      ),
                      verticalSpaceMedium,
                    ],
                  ),
                ),  
                model.pendingOrders != null
                  ? model.pendingOrders.length > 0 
                  ? SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, i) => Column(
                          children: <Widget>[
                            OrderCard(
                              order: model.pendingOrders[i],
                              onComplete: () => model.completeOrder(orderId: model.pendingOrders[i].orderId),
                            ),
                            verticalSpaceSmall,
                          ],
                        ),
                        childCount: model.pendingOrders.length,
                      )
                    )
                  : SliverToBoxAdapter(child: NoteText('You\'re all caught up!'))
                  : SliverToBoxAdapter(
                      child: Column(
                        children: <Widget>[
                          LoadingCard(),
                          verticalSpaceSmall,
                          LoadingCard()
                        ],
                      )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}