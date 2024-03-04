import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixvalley_delivery_boy/controller/wallet_controller.dart';
import 'package:sixvalley_delivery_boy/view/base/custom_loader.dart';
import 'package:sixvalley_delivery_boy/view/base/no_data_screen.dart';
import 'package:sixvalley_delivery_boy/view/screens/wallet/widget/transaction_card_widget.dart';

class TransactionListView extends StatelessWidget {
  const TransactionListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WalletController>(
      builder: (walletController) {


        return !walletController.isLoading? walletController.deliveryWiseEarned.isNotEmpty?
        ListView.builder(
          itemCount: walletController.deliveryWiseEarned.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (transactionContext, transactionIndex){
          return TransactionCardWidget(orders: walletController.deliveryWiseEarned[transactionIndex]);
        }): const NoDataScreen(): CustomLoader(height: Get.height-600,);
      }
    );
  }
}
