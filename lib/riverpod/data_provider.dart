import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reverpode_freezed_example/data_repository/data_repository.dart';
import 'package:reverpode_freezed_example/model/data_model.dart';

final userDataProvider = FutureProvider<List<DataModel>>((ref) async {
  return ref.watch(dataProvider).dataApi();
});
