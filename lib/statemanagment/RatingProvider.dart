import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:onion/const/values.dart';
import 'package:onion/myHttpGlobal/MyHttpGlobal.dart';
import 'package:onion/statemanagment/auth_provider.dart';

class RatingProvider extends ChangeNotifier {
  Dio dio = new Dio();

  Auth auth;
  RatingProvider(this.auth);

  Future<bool> addRating({
    @required ownerId,
    @required typeId,
    @required type,
    text,
    @required double value,
  }) async {
    final StringBuffer url = new StringBuffer("$BASE_URL/ratings/add");

    try {
      dio.options.headers = {
        "token": auth.token,
      };

      Response state = await dio.post(url.toString(), data: {
        "ownerId": ownerId,
        "typeId": typeId,
        "type": type,
        "text": text,
        "value": value,
      });

      print("rating ${state.data}");
      notifyListeners();
      return true;
    } on DioError catch (e) {
      print("rating errors");

      print(e.response);

      return false;
    }
  }
}
