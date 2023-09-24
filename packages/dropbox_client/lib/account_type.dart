class AccountType {
  String? tag;

  AccountType(this.tag);

  AccountType.fromMap(Map<String, dynamic> json) {
    tag = json[".tag"];
  }

  Map<String, dynamic> toMap() {
    return {
      ".tag": tag,
    };
  }
}
