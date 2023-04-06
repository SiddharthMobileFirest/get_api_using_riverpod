import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reverpode_freezed_example/res/app_urls/app_urls.dart';

import '../data/network/network_api_services.dart';
import '../model/data_model.dart';

class DataRepository {
  final _apiService = NetworkApiServices();
  List<DataModel> data = [];
  Future<List<DataModel>> dataApi() async {
    dynamic response = await _apiService.getApi(AppUrls.listUserDataUrl);
    final List result = response["data"];

    return result.map((e) => DataModel.fromjson(e)).toList();
  }
}
final dataProvider = Provider<DataRepository>((ref) => DataRepository());