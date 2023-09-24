class AccountName {
  String? givenName;
  String? surname;
  String? familiarName;
  String? displayName;
  String? abbreviatedName;

  AccountName(this.givenName, this.surname, this.familiarName, this.displayName,
      this.abbreviatedName);

  AccountName.fromMap(Map<String, dynamic> json) {
    givenName = json["given_name"];
    surname = json["surname"];
    familiarName = json["familiar_name"];
    displayName = json["display_name"];
    abbreviatedName = json["abbreviated_name"];
  }

  Map<String, dynamic> toMap() {
    return {
      "given_name": givenName,
      "surname": surname,
      "familiar_name": familiarName,
      "display_name": displayName,
      "abbreviated_name": abbreviatedName,
    };
  }
}
