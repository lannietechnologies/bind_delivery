import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixvalley_delivery_boy/controller/order_controller.dart';
import 'package:sixvalley_delivery_boy/controller/wallet_controller.dart';
import 'package:sixvalley_delivery_boy/utill/dimensions.dart';
import 'package:sixvalley_delivery_boy/utill/images.dart';
import 'package:sixvalley_delivery_boy/view/base/custom_calender.dart';
import 'package:sixvalley_delivery_boy/view/base/custom_date_picker.dart';
import 'package:sixvalley_delivery_boy/view/base/custom_snackbar.dart';



class DeliverySearchFilterWidget extends StatelessWidget {
  final bool fromHistory;
  const DeliverySearchFilterWidget({Key? key, this.fromHistory = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  GetBuilder<WalletController>(
      builder: (walletController) {
        return GestureDetector(
          onTap: ()=> Get.dialog(const CustomCalender()),
          child: Padding(padding:  EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault,Dimensions.paddingSizeDefault,
                Dimensions.paddingSizeDefault,Dimensions.paddingSizeDefault),
            child: Row(children:  [
              Expanded(
                child: Container(
                  padding:  EdgeInsets.only(right: Dimensions.paddingSizeExtraSmall),
                  decoration: BoxDecoration(
                      color: fromHistory? Theme.of(context).colorScheme.secondary : Theme.of(context).primaryColor.withOpacity(.08),
                      borderRadius: BorderRadius.circular(50)),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       FittedBox(
                         child: CustomDatePicker(text: walletController.startDate,
                             image: Images.calenderIcon, isFromHistory: fromHistory,
                           selectDate:(){}),
                       ),
                      Icon(Icons.arrow_forward_rounded,size: Dimensions.iconSizeMedium,

                          color: fromHistory? Theme.of(context).primaryColor: Theme.of(context).colorScheme.secondary),
                       FittedBox(child: CustomDatePicker(text: walletController.endDate, image: Images.calenderIcon, isFromHistory: fromHistory)),
                    ],
                  ),
                ),
              ),
               SizedBox(width: Dimensions.paddingSizeSmall),
              GestureDetector(
                onTap: (){
                  if(walletController.startDate == 'dd-mm-yyyy'){
                    showCustomSnackBar('select_start_date_first'.tr);
                  }else if(walletController.endDate == 'dd-mm-yyyy'){
                    showCustomSnackBar('select_end_date_first'.tr);
                  }else{
                    if(fromHistory){
                      Get.find<OrderController>().setOrderTypeIndex(Get.find<OrderController>().orderTypeIndex,
                          startDate: walletController.startDate,endDate:  walletController.endDate);
                    }else{
                      walletController.selectedItemForFilter(walletController.selectedItem);
                    }

                  }
                },
                child: Container(padding:  EdgeInsets.all(Dimensions.paddingSizeDefault),
                  width: 40,height: 40,
                  decoration: BoxDecoration(
                      color: fromHistory? Theme.of(context).colorScheme.secondary : Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(50)

                  ),child: Image.asset(Images.filter, color: walletController.startDate == 'dd-mm-yyyy'?
                    Theme.of(context).hintColor: Colors.white)),
              ),

            ],
            ),
          ),
        );
      }
    );
  }

}



