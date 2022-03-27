import 'dart:convert';

import 'package:dairy_app/features/auth/domain/entities/logged_in_user.dart';

class LoggedInUserModel extends LoggedInUser {
  LoggedInUserModel({required String email, required String id})
      : super(email: email, id: id);

  factory LoggedInUserModel.fromJson(Map<String, String> jsonMap) {
    return LoggedInUserModel(email: jsonMap["email"]!, id: jsonMap['id']!);
  }

  Map<String, String> toJson() {
    return {"email": email, "id": id};
  }
}
