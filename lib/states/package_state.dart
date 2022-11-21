import 'package:riverpod_poc/models/package_model.dart';

abstract class PackageState{
}

class LoadingState extends PackageState{
  // LoadingState():super(allPackageData: []);
  LoadingState();
}

class LoadedState extends PackageState{
  // LoadedState({required List<Package> allPackage}):super(allPackageData: allPackage);

  final List<Package> allPackageData;
  LoadedState({required this.allPackageData});
}
