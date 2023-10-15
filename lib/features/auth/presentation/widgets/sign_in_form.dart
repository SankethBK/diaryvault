import 'package:dairy_app/core/constants/exports.dart';
import 'package:dairy_app/features/auth/core/exports.dart';
import 'package:dartz/dartz.dart' as dz;

class SignInForm extends StatefulWidget {
  static String get route => '/auth';
  final void Function() flipCard;
  final String? lastLoggedInUserId;

  const SignInForm({
    Key? key,
    required this.flipCard,
    this.lastLoggedInUserId,
  }) : super(key: key);

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  bool inItialized = false;

  late AuthFormBloc bloc;

  Future<dz.Either<ForgotPasswordFailure, bool>> submitForgotPasswordEmail(
      String forgotPasswordEmail) async {
    return await bloc.submitForgotPasswordEmail(forgotPasswordEmail);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!inItialized) {
      bloc = BlocProvider.of<AuthFormBloc>(context);
      bloc.add(ResetAuthForm());
      inItialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthFormBloc, AuthFormState>(
      bloc: bloc,
      listener: (context, state) {
        if (state is AuthFormSubmissionFailed &&
            state.errors.containsKey("general")) {
          showToast(
            state.errors["general"]![0],
          );
        }
      },
      builder: (context, state) {
        String? _getEmailErrors() {
          if (state is AuthFormSubmissionFailed &&
              state.errors.containsKey("email")) {
            return state.errors["email"]![0];
          }
          return null;
        }

        String? _getPasswordErrors() {
          if (state is AuthFormSubmissionFailed &&
              state.errors.containsKey("password")) {
            return state.errors["password"]?[0];
          }
          return null;
        }

        void _onEmailChanged(String email) =>
            bloc.add(AuthFormInputsChangedEvent(email: email));

        void _onPasswordChanged(String password) =>
            bloc.add(AuthFormInputsChangedEvent(password: password));

        void _onSubmitted() => bloc.add(AuthFormSignInSubmitted(
            lastLoggedInUserId: widget.lastLoggedInUserId));

        final linkColor =
            Theme.of(context).extension<AuthPageThemeExtensions>()!.linkColor;

        return GlassMorphismCover(
          borderRadius: BorderRadius.circular(16.0),
          child: FormDimensions(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    AppLocalizations.of(context).logIn,
                    style: const TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AuthEmailInput(
                        getEmailErrors: _getEmailErrors,
                        onEmailChanged: _onEmailChanged,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      AuthPasswordInput(
                        getPasswordErrors: _getPasswordErrors,
                        onPasswordChanged: _onPasswordChanged,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      SubmitButton(
                        isLoading: (state is AuthFormSubmissionLoading),
                        onSubmitted: _onSubmitted,
                        buttonText: "Submit",
                      )
                    ],
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          forgotPasswordPopup(
                              context, submitForgotPasswordEmail);
                        },
                        child: Text(
                          AppLocalizations.of(context).forgotPassword,
                          style: TextStyle(
                            color: linkColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      AuthChangePage(
                        infoText: AppLocalizations.of(context).dontHaveAccount,
                        flipPageText: AppLocalizations.of(context).signUp,
                        flipCard: widget.flipCard,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
