import 'package:flutter/material.dart';
import 'package:sixvalley_delivery_boy/controller/wallet_controller.dart';
import 'package:sixvalley_delivery_boy/view/base/custom_loader.dart';
import 'package:sixvalley_delivery_boy/view/base/no_data_screen.dart';
import 'package:sixvalley_delivery_boy/view/screens/earning_statement/widget/earning_statement_card.dart';

class EarningStatementListView extends StatelessWidget {
  final WalletController? walletController;
  const EarningStatementListView({Key? key, this.walletController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      !walletController!.isLoading? walletController!.deliveryWiseEarned.isNotEmpty?
      ListView.builder(
        itemCount: walletController!.deliveryWiseEarned.length,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index){
        return EarningStatementCard(ordersWiseEarned: walletController!.deliveryWiseEarned[index]);
      }) : const NoDataScreen() : const CustomLoader(height: 500,)
    ],);
  }
}
