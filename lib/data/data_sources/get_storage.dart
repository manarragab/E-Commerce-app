import 'package:ecommerce_app/data/const/export.dart';
import 'package:ecommerce_app/data/models/auth/user/user_data.dart';
import 'package:get_storage/get_storage.dart';

class GetStorageData {
  GetStorage getStorage;

  GetStorageData(this.getStorage);

  final String _user = 'user';
  final String _userChat = 'user_chat';

  UserData? getUser() {
    if (getStorage.hasData(_user)) {
      UserData login = UserData.fromJson(getStorage.read(_user));
      // Print.info('login db:: ${login.toJson()}');
      return login;
    } else {
      return null;
    }
  }

  setUser(UserData? UserData) {
    //  Print.info('insert user:: ${UserData?.toJson()}');
    sPrint.error('insert user ${UserData?.toJson()}', StackTrace.current);
    getStorage.write(_user, UserData?.toJson());
  }

  removeUser() {
    getStorage.remove(_user);
    getStorage.remove("token");
  }

void init(){
  getStorage = GetStorage();
}
  Future<void> setToken(String token , String refreshToken) async {
  await getStorage.write("token", token);
  await getStorage.write("refresh_token", refreshToken);
}

 String? getToken()  {
  return getStorage.read("token") ;

}
String? getRefreshToken()  {
  return getStorage.read("refresh_token") ;
}

 void deleteToken()  {
   getStorage.remove("token");
   getStorage.remove("refresh_token");
}


//Payment auth token
  Future<void> setPaymentToken(String token ) async {
  await getStorage.write("payment_token", token);
}
String getPaymentToken()  {
  return getStorage.read("payment_token");
}



 void setWishlist(var wishlist ) async {
  await getStorage.write("wishlist", wishlist);
}

dynamic getWishlist()  {
  return getStorage.read("wishlist"); 
}


}