import 'package:dairy_app/core/widgets/glassmorphism_cover.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NoteTitleInputField extends StatefulWidget {
  // final String? Function() getEmailErrors;
  final void Function(String email) onTitleChanged;
  final String initialValue;
  const NoteTitleInputField({
    Key? key,
    // required this.getEmailErrors,
    required this.initialValue,
    required this.onTitleChanged,
  }) : super(key: key);

  @override
  State<NoteTitleInputField> createState() => _NoteTitleInputFieldState();
}

class _NoteTitleInputFieldState extends State<NoteTitleInputField> {
  bool showTitleInput = true;

  @override
  Widget build(BuildContext context) {
    final textInputBorderRadius = BorderRadius.circular(15.0);
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: showTitleInput
          ? GlassMorphismCover(
              borderRadius: textInputBorderRadius,
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  TextFormField(
                    textCapitalization: TextCapitalization.sentences,
                    style: GoogleFonts.lato(
                        textStyle:
                            const TextStyle(fontWeight: FontWeight.w500)),
                    initialValue: widget.initialValue,
                    decoration: InputDecoration(
                      hintText: "title",
                      hintStyle: const TextStyle(fontWeight: FontWeight.normal),
                      fillColor: Colors.white.withOpacity(0.7),
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: textInputBorderRadius,
                        borderSide: BorderSide(
                          color: Colors.white.withOpacity(1),
                          width: 0.5,
                        ),
                      ),
                      // errorText: getEmailErrors(),
                      errorStyle: TextStyle(
                        color: Colors.pink[200],
                        fontWeight: FontWeight.w500,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: textInputBorderRadius,
                        borderSide: BorderSide(
                          color: Colors.white.withOpacity(1),
                          width: 3,
                        ),
                      ),
                      suffixIcon: IconButton(
                        padding: EdgeInsets.zero,
                        icon: const Icon(
                          Icons.arrow_upward,
                          size: 20,
                        ),
                        onPressed: () {
                          setState(() {
                            showTitleInput = false;
                          });
                        },
                      ),
                    ),
                    onChanged: widget.onTitleChanged,
                  ),
                  const SizedBox(height: 10),
                ],
              ))
          : Column(
              children: [
                const SizedBox(height: 6),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      showTitleInput = true;
                    });
                  },
                  child: Row(
                    children: [
                      const SizedBox(width: 6),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(12.0),
                          ),
                        ),
                        child: Icon(
                          Icons.arrow_downward,
                          size: 15,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        "Tap here to expand title",
                        style: GoogleFonts.lato(
                            textStyle: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                        )),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 6),
              ],
            ),
    );
  }
}
