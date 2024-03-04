import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixvalley_delivery_boy/controller/notification_controller.dart';
import 'package:sixvalley_delivery_boy/view/base/custom_home_app_bar.dart';
import 'package:sixvalley_delivery_boy/view/base/custom_loader.dart';
import 'package:sixvalley_delivery_boy/view/base/no_data_screen.dart';
import 'package:sixvalley_delivery_boy/view/screens/notification/widget/notification_card_item.dart';



class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.find<NotificationController>().getNotificationList(1);

    return Scaffold(
      appBar: CustomRiderAppBar(title: 'notification'.tr),
      body: GetBuilder<NotificationController>(builder: (notificationController) {

        return RefreshIndicator(
          onRefresh: () async {
            await notificationController.getNotificationList(1);
          },
          child: !notificationController.isLoading? notificationController.notificationList!.isNotEmpty?
          Scrollbar(child: SingleChildScrollView(child: Center(child: SizedBox(width: 1170, child:
           ListView.builder(
            itemCount: notificationController.notificationList!.length,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              bool _addTitle = false;
              return NotificationCardWidget(notificationModel: notificationController.notificationList![index],addTitle: _addTitle);
            },
          ))))):const NoDataScreen(): const CustomLoader(),
        );
      }),
    );
  }
}
