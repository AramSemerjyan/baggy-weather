import 'package:flutter_weather/Models/User/user_model.dart';
import 'package:flutter_weather/Services/DB/data_base_service.dart';

abstract class UserStoreProtocol {
  Future<UserModel?> getCurrentUser();
  Future<bool> saveUser(UserModel u);
}

class UserStore extends DBService implements UserStoreProtocol {
  @override
  Future<UserModel?> getCurrentUser() async {
    final json = await getForKey('user');

    if (json != null) {
      return UserModel.fromJson(json);
    }

    return null;
  }

  @override
  Future<bool> saveUser(UserModel u) {
    return saveForKey('user', u.toJson());
  }
}
