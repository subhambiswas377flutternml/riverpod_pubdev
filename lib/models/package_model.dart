import 'package:freezed_annotation/freezed_annotation.dart';

part 'package_model.freezed.dart';
part 'package_model.g.dart';

@freezed
class Package with _$Package{

  factory Package({required String packageName, required String packageDescription}) = _Package;

  factory Package.fromJson(Map<String, dynamic> data) => _$PackageFromJson(data);
}