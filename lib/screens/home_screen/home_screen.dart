import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reverpode_freezed_example/model/data_model.dart';

import '../../riverpod/data_provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final userData = ref.watch(userDataProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Riverpod"),
      ),
      body: userData.when(
          data: (data) {
            List<DataModel> userList = data.map((e) => e).toList();
            return ListView.separated(
              separatorBuilder: (context, index) => const Divider(),
              itemCount: userList.length,
              itemBuilder: (BuildContext context, int index) {
                return dataListTile(
                    imageUrl: userList[index].avatar,
                    firstName: userList[index].firstName,
                    email: userList[index].email);
              },
            );
          },
          error: (error, stackTrace) => errorTile(error: error.toString()),
          loading: () => const Center(
                child: CircularProgressIndicator(),
              )),
    );
  }

  Widget dataListTile(
      {required String imageUrl,
      required String firstName,
      required String email}) {
    return ListTile(
      leading: Image.network(
        imageUrl,
        fit: BoxFit.cover,
        height: 50,
        width: 50,
      ),
      title: Text(firstName),
      subtitle: Text(email),
    );
  }

  Widget errorTile({required String error}) {
    return Center(
      child: Card(
        color: Colors.red,
        child: SizedBox(
          height: 50,
          width: 300,
          child: Center(
            child: Text(
              error,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}
