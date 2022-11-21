import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_poc/controllers/package_controller.dart';
import 'package:riverpod_poc/states/package_state.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);
  static final TextEditingController searchController = TextEditingController();

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
            controller: searchController,
            decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: "Search Package"),
          ),
        ),
        actions: [
          IconButton(
            onPressed: (){
              ref.read(packageFutureData.notifier).searchApi(keyWord: searchController.text.trim());
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: 
      
      
      
      packageDataProvider is LoadingState ? const Center(child: CircularProgressIndicator())
          :ListView.separated(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(
            horizontal: _info.size.width * 0.01,
            vertical: _info.size.height * 0.02,
          ),
          shrinkWrap: true,
          itemCount: (packageDataProvider as LoadedState).allPackageData.length,
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
                          packageDataProvider.allPackageData[index].packageName.toString(),
                          style: TextStyle(
                            fontSize: _info.textScaleFactor * 16,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: _info.size.height * 0.01,
                        ),
                        Text(packageDataProvider.allPackageData[index].packageDescription.toString()),
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
        
          ),
        
      
    );
  }
}
