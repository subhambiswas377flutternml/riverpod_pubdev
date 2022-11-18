class Package {
  String? packageName;
  String? packageDescription;

  Package({required this.packageDescription, required this.packageName});

  factory Package.fromJson(Map<String, dynamic> data) {
    return Package(
        packageName: data["name"], packageDescription: data["description"]);
  }
}
