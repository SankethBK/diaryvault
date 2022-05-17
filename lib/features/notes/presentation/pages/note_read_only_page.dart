import 'package:dairy_app/core/widgets/glassmorphism_cover.dart';
import 'package:flutter/material.dart';

class NotesReadOnlyPage extends StatelessWidget {
  const NotesReadOnlyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Icon(Icons.visibility),
            )
          ],
          flexibleSpace: GlassMorphismCover(
            borderRadius: BorderRadius.circular(0.0),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.3),
                    Colors.white.withOpacity(0.2),
                  ],
                  begin: AlignmentDirectional.topCenter,
                  end: AlignmentDirectional.bottomCenter,
                ),
              ),
            ),
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                "assets/images/digital-art-neon-bubbles.jpg",
              ),
              fit: BoxFit.cover,
            ),
          ),
          padding: const EdgeInsets.only(
            top: 15.0,
            left: 10.0,
            right: 10.0,
            // bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: GlassMorphismCover(
            displayShadow: false,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(16.0),
                  bottomRight: Radius.circular(16.0),
                ),
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.7),
                    Colors.white.withOpacity(0.5),
                  ],
                  begin: AlignmentDirectional.topStart,
                  end: AlignmentDirectional.bottomEnd,
                ),
              ),
              child: Column(
                children: [],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
