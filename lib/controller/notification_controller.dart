
import 'package:get/get.dart';
import 'package:sixvalley_delivery_boy/data/api/api_checker.dart';
import 'package:sixvalley_delivery_boy/data/model/response/notifications_model.dart';
import 'package:sixvalley_delivery_boy/data/repository/notification_repo.dart';


class NotificationController extends GetxController implements GetxService {
  final NotificationRepo notificationRepo;
  NotificationController({required this.notificationRepo});



  bool _isLoading = false;
  bool get isLoading => _isLoading;
  NotificationModel? _notificationModel;
  NotificationModel? get notificationModel => _notificationModel;
  List<Notifications>? _notificationList;
  List<Notifications>? get notificationList => _notificationList;

  Future<void> getNotificationList(int offset, {bool reload = true}) async {
    if(reload){
      _notificationList = [];
    }
    _isLoading = true;
    Response response = await notificationRepo.getNotificationList(offset);
    if (response.statusCode == 200) {
      if(offset == 1){
        _notificationModel =  NotificationModel.fromJson(response.body);
        _notificationList!.addAll(NotificationModel.fromJson(response.body).notifications!);
      }else{
        _notificationModel!.totalSize = NotificationModel.fromJson(response.body).totalSize;
        _notificationModel!.offset = NotificationModel.fromJson(response.body).offset;
        _notificationModel!.notifications!.addAll(NotificationModel.fromJson(response.body).notifications!);
      }
    } else {
      ApiChecker.checkApi(response);
    }
    _isLoading = false;
    update();
  }

  void saveSeenNotificationCount(int count) {
    notificationRepo.saveSeenNotificationCount(count);
  }

  int? getSeenNotificationCount() {
    return notificationRepo.getSeenNotificationCount();
  }

}
