import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sixvalley_delivery_boy/data/api/api_client.dart';
import 'package:sixvalley_delivery_boy/utill/app_constants.dart';

class ChatRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  ChatRepo({required this.apiClient, required this.sharedPreferences});


  Future<Response> getConversationList(int offset, String userType) async {
    return apiClient.getData('${AppConstants.chatListUri}$userType?limit=10&offset=$offset');
  }

  Future<Response> searchConversationList(String name) async {
    return apiClient.getData(AppConstants.searchConversationListUri + '?name=$name&limit=20&offset=1');
  }

  Future<Response> getMessagesList(int offset, String userType, int? id) async {
    return await apiClient.getData('${AppConstants.messageListUri}$userType/$id?offset=$offset&limit=10');
  }

  Future<Response> searchChatList(String userType, String search) async {
    return await apiClient.getData('${AppConstants.chatSearch}$userType?search=$search');
  }

  Future<Response> sendMessage(String message, int? userId, String userType, List<MultipartBody> files) async {
    return apiClient.postMultipartData('${AppConstants.sendMessageUri}$userType',
      {'message': message, 'id': userId.toString() }, files
    );
  }

}