import 'package:dairy_app/core/constants/exports.dart';
import 'package:dairy_app/features/auth/core/exports.dart';

class LoggedInUser extends Equatable {
  final String email;
  final String id;

  const LoggedInUser({required this.email, required this.id});

  // Method to create a Guest User
  static LoggedInUser getGuestUserModel() {
    return LoggedInUser(
        email: GuestUserDetails.guestUserEmail,
        id: GuestUserDetails.guestUserId);
  }

  @override
  List<Object?> get props => [email, id];
}
