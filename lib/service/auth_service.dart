
import 'package:dio/dio.dart';
import 'package:quiz_eng/config/get.dart';
import 'package:quiz_eng/model/auth_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthService {
  Dio req = Dio();
  late Response response;
  String baseurl = "https://6650d71420f4f4c442764720.mockapi.io/username";

  Future<bool> logIn(authModel user);
}

class AuthSeviceImp extends AuthService {
  @override
  Future<bool> logIn(authModel user) async {
    try {
      response = await req.post(baseurl, data: user.toMap());
      if (response.statusCode == 200) {
        core
            .get<SharedPreferences>()
            .setString('username', response.data['username']);
        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      print(e.message);
      return false;
    }
  }
}