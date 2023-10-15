import 'package:dairy_app/core/constants/exports.dart';

/// specifies size of form and gradients
class FormDimensions extends StatelessWidget {
  const FormDimensions({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final authFormGradientStartColor = Theme.of(context)
        .extension<AuthPageThemeExtensions>()!
        .authFormGradientStartColor;

    final authFormGradientEndColor = Theme.of(context)
        .extension<AuthPageThemeExtensions>()!
        .authFormGradientEndColor;

    return Container(
      height: 362.0,
      width: 312.0,
      constraints: const BoxConstraints(
        maxWidth: 500,
        maxHeight: 500,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        gradient: LinearGradient(
          colors: [
            authFormGradientStartColor,
            authFormGradientEndColor,
          ],
          begin: AlignmentDirectional.topStart,
          end: AlignmentDirectional.bottomEnd,
        ),
        border: Border.all(
          width: 1.5,
          color: Colors.white.withOpacity(0.2),
        ),
      ),
      child: child,
    );
  }
}
