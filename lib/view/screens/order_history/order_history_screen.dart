import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixvalley_delivery_boy/controller/order_controller.dart';
import 'package:sixvalley_delivery_boy/controller/wallet_controller.dart';
import 'package:sixvalley_delivery_boy/data/model/response/order_model.dart';
import 'package:sixvalley_delivery_boy/utill/dimensions.dart';
import 'package:sixvalley_delivery_boy/view/base/custom_home_app_bar.dart';
import 'package:sixvalley_delivery_boy/view/base/custom_loader.dart';
import 'package:sixvalley_delivery_boy/view/base/no_data_screen.dart';
import 'package:sixvalley_delivery_boy/view/screens/order_history/widget/order_history_header_widget.dart';
import 'package:sixvalley_delivery_boy/view/screens/order_history/widget/order_history_item_widget.dart';


class OrderHistoryScreen extends StatefulWidget {
  final bool fromMenu;
  const OrderHistoryScreen({Key? key, this.fromMenu = false}) : super(key: key);

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  @override
  void initState() {
    if(widget.fromMenu){
      Get.find<OrderController>().setOrderTypeIndex(0);
      Get.find<OrderController>().setOrderTypeIndex(0, startDate: '',endDate:  '');
    }

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomRiderAppBar(title: 'order_history'.tr),

        body: RefreshIndicator(onRefresh: () async{
          Get.find<OrderController>().searchOrderController.clear();
          Get.find<OrderController>().setOrderTypeIndex(Get.find<OrderController>().orderTypeIndex,
              startDate: Get.find<WalletController>().startDate == "dd-mm-yyyy"? "" :Get.find<WalletController>().startDate,
              endDate:  Get.find<WalletController>().endDate =="dd-mm-yyyy"? "" :Get.find<WalletController>().endDate);

        },
        child: CustomScrollView(
          slivers: [

            SliverToBoxAdapter(child: Column(children: [
              const OrderHistoryHeaderWidget(),
              Container(
                transform: Matrix4.translationValues(0.0, -50.0, 0.0),
                child: GetBuilder<OrderController>(builder: (orderController) {

                  List<OrderModel> orders = [];
                  if(orderController.orderTypeIndex == 2){
                    orders = orderController.pauseOrderHistory;
                  }else if(orderController.orderTypeIndex == 3){
                    orders = orderController.deliveredOrderHistory;
                  }else{
                    orders = orderController.allOrderHistory;
                  }

                  return !orderController.isLoading? orders.isNotEmpty ?
                  ListView.builder(
                    shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: orders.length,
                      padding:  EdgeInsets.all(Dimensions.paddingSizeSmall),
                      itemBuilder: (context, index){
                        return OrderHistoryItemWidget(orderModel: orders[index]);
                      })   :
                   Padding(padding: EdgeInsets.only(top: Dimensions.paddingSizeOverLarge),
                    child: const NoDataScreen(),) :const CustomLoader(height: 500,);
                }

                ),
              )

            ],),)
          ],

        )));
  }
}
