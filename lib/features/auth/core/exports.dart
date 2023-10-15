/// Core
export 'package:dairy_app/features/auth/core/constants.dart';

/// -- Failures
export 'package:dairy_app/features/auth/core/failures/failures.dart';

/// -- Validators
export 'package:dairy_app/features/auth/core/validators/email_validator.dart';
export 'package:dairy_app/features/auth/core/validators/password_validator.dart';

/// Data

/// -- Data Sources
export 'package:dairy_app/features/auth/data/datasources/local%20data%20sources/local_data_source_template.dart';
export 'package:dairy_app/features/auth/data/datasources/remote%20data%20sources/remote_data_source_template.dart';

/// -- Models
export 'package:dairy_app/features/auth/data/models/logged_in_user_model.dart';
export 'package:dairy_app/features/auth/data/models/user_config_model.dart';

/// -- Repositories

/// Domain
/// -- Entities
export 'package:dairy_app/features/auth/domain/entities/logged_in_user.dart';

/// -- Repositories
export 'package:dairy_app/features/auth/domain/repositories/authentication_repository.dart';

/// -- Use Cases

/// Presentation
/// -- Bloc
export 'package:dairy_app/features/auth/presentation/bloc/auth_form/auth_form_bloc.dart';
export 'package:dairy_app/features/auth/presentation/bloc/auth_session/auth_session_bloc.dart';
export 'package:dairy_app/features/auth/presentation/bloc/cubit/theme_cubit.dart';

/// -- Pages
export 'package:dairy_app/features/auth/presentation/pages/auth_page.dart';

/// -- Widgets
export 'package:dairy_app/features/auth/presentation/widgets/privacy_policy.dart';
export 'package:dairy_app/features/auth/presentation/widgets/quit_app_dialog.dart';
export 'package:dairy_app/features/auth/presentation/widgets/sign_in_form.dart';
export 'package:dairy_app/features/auth/presentation/widgets/sign_up_form.dart';
export 'package:dairy_app/features/auth/presentation/widgets/email_input_field.dart';
export 'package:dairy_app/features/auth/presentation/widgets/password_input_field.dart';
export 'package:dairy_app/features/auth/presentation/widgets/email_change_popup.dart';
export 'package:dairy_app/features/auth/presentation/widgets/password_enter_popup.dart';
export 'package:dairy_app/features/auth/presentation/widgets/password_reset_popup.dart';
export 'package:dairy_app/features/auth/presentation/widgets/auth_change.dart';
export 'package:dairy_app/features/auth/presentation/widgets/forgot_password_popup.dart';
export 'package:dairy_app/features/auth/presentation/widgets/form_dimensions.dart';
export 'package:dairy_app/features/auth/presentation/widgets/guest_sign_up.dart';
export 'package:dairy_app/features/auth/presentation/widgets/security_settings.dart';
export 'package:dairy_app/features/auth/presentation/widgets/setup_account.dart';
