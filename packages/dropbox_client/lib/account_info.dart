import 'package:dropbox_client/account_type.dart';
import 'package:dropbox_client/root_info.dart';

import 'account_name.dart';

class AccountInfo {
  String? accountId;
  AccountName? name;
  String? email;
  bool? emailVerified;
  bool? disabled;
  String? country;
  String? locale;
  String? referralLink;
  bool? isPaired;
  AccountType? accountType;
  RootInfo? rootInfo;

  AccountInfo(
      this.accountId,
      this.name,
      this.email,
      this.emailVerified,
      this.disabled,
      this.country,
      this.locale,
      this.referralLink,
      this.isPaired,
      this.accountType,
      this.rootInfo);

  AccountInfo.fromMap(Map<String, dynamic> json) {
    accountId = json["account_id"];
    name = AccountName.fromMap(json["name"]);
    email = json["email"];
    emailVerified = json["email_verified"];
    disabled = json["disabled"];
    country = json["country"];
    locale = json["locale"];
    referralLink = json["referral_link"];
    isPaired = json["is_paired"];
    accountType = AccountType.fromMap(json["account_type"]);
    rootInfo = RootInfo.fromMap(json["root_info"]);
  }

  Map<String, dynamic> toMap() {
    return {
      "account_id": accountId,
      "name": name?.toMap(),
      "email": email,
      "email_verified": emailVerified,
      "disabled": disabled,
      "country": country,
      "locale": locale,
      "referral_link": referralLink,
      "is_paired": isPaired,
      "account_type": accountType?.toMap(),
      "root_info": rootInfo?.toMap(),
    };
  }
}
