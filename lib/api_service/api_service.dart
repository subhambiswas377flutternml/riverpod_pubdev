import 'package:http/http.dart' as http;
import 'package:riverpod_poc/models/package_model.dart';
import 'dart:convert' as convert;

class ApiService {
  static Future<List<Package>> getData() async {
    try {
      final packageData =
          await http.get(Uri.parse('https://pub.dev/api/packages'));
      if (packageData.statusCode == 200) {
        List data = convert.jsonDecode(packageData.body)["packages"];
        List<Package> allPackageData = [];
        for (int i = 0; i < data.length; i++) {
          allPackageData.add(Package.fromJson(data[i]["latest"]["pubspec"]));
        }
        return allPackageData;
      } else {
        return [];
      }
    } catch (e) {
      rethrow;
    }
  }
}
