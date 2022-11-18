import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_poc/api_service/api_service.dart';
import 'package:riverpod_poc/models/package_model.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);
  static final packageFutureData = FutureProvider((ref) async {
    List<Package> packageData = await ApiService.getData();
    return packageData;
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final MediaQueryData _info = MediaQuery.of(context);
    final packageDataProvider = ref.watch(packageFutureData);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF12202F),
        toolbarHeight: _info.size.height * 0.1,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Pub Dev",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size(_info.size.width, _info.size.height * 0.05),
          child: TextFormField(
            decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: "Search Package"),
          ),
        ),
        actions: [
          // IconButton(
          //   icon: const Icon(Icons.search),
          //   onPressed: () {},
          // )
        ],
      ),
      body: packageDataProvider.when(data: (data) {
        return ListView.separated(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(
            horizontal: _info.size.width * 0.01,
            vertical: _info.size.height * 0.02,
          ),
          shrinkWrap: true,
          itemCount: data.length,
          itemBuilder: (_, index) {
            return InkWell(
              onTap: () {},
              child: Card(
                  elevation: 5,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: _info.size.width * 0.03,
                      vertical: _info.size.height * 0.01,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          data[index].packageName.toString(),
                          style: TextStyle(
                            fontSize: _info.textScaleFactor * 16,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: _info.size.height * 0.01,
                        ),
                        Text(data[index].packageDescription.toString()),
                      ],
                    ),
                  )),
            );
          },
          separatorBuilder: (_, index) {
            return SizedBox(
              height: _info.size.height * 0.01,
            );
          },
        );
      }, error: (e, _) {
        return const Center(child: Text("Something Went Wrong !"));
      }, loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }),
    );
  }
}
