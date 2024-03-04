import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sixvalley_delivery_boy/data/api/api_checker.dart';
import 'package:sixvalley_delivery_boy/data/api/api_client.dart';
import 'package:sixvalley_delivery_boy/data/model/response/chat_model.dart';
import 'package:sixvalley_delivery_boy/data/model/response/message_model.dart';
import 'package:sixvalley_delivery_boy/data/repository/chat_repo.dart';


class ChatController extends GetxController implements GetxService{

  final ChatRepo chatRepo;
  ChatController({required this.chatRepo});

  List<bool>? _showDate;
  List<XFile>? _imageFiles;
  bool _isSendButtonActive = false;
  final bool _isSeen = false;
  final bool _isSend = true;
  final bool _isMe = false;
  bool _isLoading= false;
  bool _isSending= false;
  bool get isSending=> _isSending;
  List <XFile>?_chatImage = [];
  int? _pageSize;
  int? _offset;
  ChatModel? _conversationModel;
  MessageModel? _messageModel;

  bool get isLoading => _isLoading;
  List<bool>? get showDate => _showDate;
  List<XFile>? get imageFiles => _imageFiles;
  bool get isSendButtonActive => _isSendButtonActive;
  bool get isSeen => _isSeen;
  bool get isSend => _isSend;
  bool get isMe => _isMe;
  int? get pageSize => _pageSize;
  int? get offset => _offset;
  List<XFile>? get chatImage => _chatImage;
  ChatModel? get conversationModel => _conversationModel;
  MessageModel? get messageModel => _messageModel;


  int _userTypeIndex = 0;
  int get userTypeIndex =>  _userTypeIndex;






  Future<void> getConversationList(int offset) async{
    if(offset == 1){
      _conversationModel = null;
      update();
    }

    Response response = await chatRepo.getConversationList(offset, _userTypeIndex == 0? 'seller' :_userTypeIndex == 1? 'customer':'admin');
    if(response.statusCode == 200) {
      if(offset == 1) {
        _conversationModel = ChatModel.fromJson(response.body);
      }else {
        _conversationModel!.totalSize = ChatModel.fromJson(response.body).totalSize;
        _conversationModel!.offset = ChatModel.fromJson(response.body).offset;
        _conversationModel!.chat!.addAll(ChatModel.fromJson(response.body).chat!);
      }
    }else {
      ApiChecker.checkApi(response);
    }
    update();

  }


  Future<void> searchConversationList(String searchChat) async{
    _isLoading = true;
    Response response = await chatRepo.searchChatList(  _userTypeIndex == 0? 'seller' :_userTypeIndex == 1? 'customer':'admin', searchChat);
    if(response.statusCode == 200) {
      _conversationModel = ChatModel(totalSize: 1, limit: '1', offset: '1', chat: []);
      response.body.forEach((chat) {
        _conversationModel!.chat!.add(Chat.fromJson(chat));

      });
    }else {
      ApiChecker.checkApi(response);
    }
    _isLoading = false;
    update();

  }



  void removeSearchMode() {

  }

  Future<void> getMessages(int offset, int? userId, {bool firstLoad = true}) async {
    String userType = 'admin';
    if(userId == 0){
      userType = 'admin';
    }else{
      userType = _userTypeIndex == 0 ? 'seller' :_userTypeIndex == 1? "customer" : "admin";
    }
    if(offset == 1){
      _messageModel = null;
    }
    _isLoading = true;
    Response _response = await chatRepo.getMessagesList(offset, userType, userId);
    if (_response.body != {} && _response.statusCode == 200) {
      if(offset == 1 ){
        _messageModel = MessageModel.fromJson(_response.body);
      }else{
        _messageModel!.totalSize =  MessageModel.fromJson(_response.body).totalSize;
        _messageModel!.offset =  MessageModel.fromJson(_response.body).offset;
        _messageModel!.message!.addAll(MessageModel.fromJson(_response.body).message!)  ;
      }

    } else {
      ApiChecker.checkApi(_response);
    }
    _isLoading = false;
    update();

  }



  void pickImage(bool isRemove) async {
    final ImagePicker _picker = ImagePicker();
    if(isRemove) {
      _imageFiles = [];
      _chatImage = [];
    }else {
      _imageFiles = await _picker.pickMultiImage(imageQuality: 30);
      if (_imageFiles != null) {
        _chatImage = imageFiles;
        _isSendButtonActive = true;
      }
    }
    update();
  }
  void removeImage(int index){
    chatImage!.removeAt(index);
    update();
  }

  void toggleSendButtonActivity() {
    _isSendButtonActive = !_isSendButtonActive;
    update();
  }



  Future<Response> sendMessage(String message, int userId) async {
    String userType = 'admin';
    if(userId == 0){
      userType = 'admin';
    }else{
      userType = _userTypeIndex == 0 ? 'seller' :_userTypeIndex == 1? "customer" : "admin";
    }
    _isSending = true;
    update();
    Response _response = await chatRepo.sendMessage(message, userId, userType, files);
    if (_response.statusCode == 200) {
      _isSendButtonActive = false;
      _isSending = false;
      getMessages(1, userId);
      _pickedImageFiles = [];
      pickedImageFileStored = [];
      files= [];
    }else{
      _isSendButtonActive = false;
      _isSending = false;
    }
    update();
    return _response;
  }


  void setUserTypeIndex(int index) {
    _userTypeIndex = index;
    getConversationList(1);
    update();
  }

  List <XFile> _pickedImageFiles =[];
  List <XFile>? get pickedImageFile => _pickedImageFiles;
  List <XFile>?  pickedImageFileStored = [];
  List<MultipartBody> files = [];
  void pickMultipleImage(bool isRemove,{int? index}) async {
    files = [];
    if(isRemove) {
      if(index != null){
        pickedImageFileStored!.removeAt(index);
      }
    }else {
      _pickedImageFiles = await ImagePicker().pickMultiImage(imageQuality: 40);
      pickedImageFileStored?.addAll(_pickedImageFiles);
      for(int i=0; i< pickedImageFileStored!.length; i++){
        files.add(MultipartBody('image[$i]', pickedImageFileStored![i]));
      }
    }
    update();
  }
}