import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_poc/api_service/api_service.dart';
import 'package:riverpod_poc/models/package_model.dart';
import 'package:riverpod_poc/states/package_state.dart';

class PackageController extends StateNotifier<PackageState>
{
  PackageController(super.state){
    callApi();
  }

  void callApi()async{
    List<Package> allData = await ApiService.getData();
    state = LoadedState(allPackageData: allData);
  }

  void searchApi({required String keyWord})async{
    List<Package> allData = (state as LoadedState).allPackageData;
    state = LoadingState();
    List<Package> modifiedPackage = allData.where((element)=>element.packageName.contains(keyWord)).toList();
    state = LoadedState(allPackageData: modifiedPackage);
  }
}

final packageFutureData = StateNotifierProvider<PackageController,PackageState>((ref){
  return PackageController(LoadingState());
});

