class UserModel {
  static String? name;

  static void setName(String newName) {
    name = newName.trim().isNotEmpty ? newName : "User";
  }

  static String getName() => name ?? "User";
}