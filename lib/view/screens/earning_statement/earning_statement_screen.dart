import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixvalley_delivery_boy/controller/order_controller.dart';
import 'package:sixvalley_delivery_boy/controller/wallet_controller.dart';
import 'package:sixvalley_delivery_boy/view/base/custom_home_app_bar.dart';
import 'package:sixvalley_delivery_boy/view/base/sliver_deligate_widget.dart';
import 'package:sixvalley_delivery_boy/view/screens/earning_statement/widget/earning_filter_button.dart';
import 'package:sixvalley_delivery_boy/view/screens/earning_statement/widget/earning_statement_list_view.dart';

class EarningStatementScreen extends StatelessWidget {
  const EarningStatementScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.find<WalletController>().getOrderWiseDeliveryCharge('', '', 1,'');
    return Scaffold(
      appBar: CustomRiderAppBar(title: 'earning_statement'.tr, isBack: true),
      body: RefreshIndicator(
        onRefresh: () async{
          Get.find<OrderController>().setEarningFilterIndex(Get.find<OrderController>().orderTypeFilterIndex);
        },
        child: CustomScrollView(
          slivers: [

            SliverPersistentHeader(
                pinned: true,
                delegate: SliverDelegate(
                    containerHeight: 80,
                    child: const EarningFilterButtonWidget())),
            SliverToBoxAdapter(child: Column(children:  [

              GetBuilder<WalletController>(
                builder: (walletController) {
                  return EarningStatementListView(walletController: walletController);
                }
              ),

            ],),)
          ],

        ),
      ),
    );
  }
}
