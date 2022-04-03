// ignore_for_file: prefer_const_constructors

import 'dart:math';
import 'dart:ui';

import 'package:dairy_app/core/animations/flip_card_animation.dart';
import 'package:dairy_app/core/dependency_injection/injection_container.dart';
import 'package:dairy_app/core/widgets/glassmorphism.dart';
import 'package:dairy_app/features/auth/presentation/bloc/auth_form/auth_form_bloc.dart';
import 'package:dairy_app/features/auth/presentation/pages/home_page.dart';
import 'package:dairy_app/features/auth/presentation/widgets/sign_in_form.dart';
import 'package:dairy_app/features/auth/presentation/widgets/sign_up_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);
  static String get route => '/auth';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "assets/digital-art-neon-bubbles.jpg",
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: FlipCardAnimation(
          frontWidget: (void Function() flipCard) {
            return SignUpForm(flipCard: flipCard);
          },
          rearWidget: (void Function() flipCard) {
            return SignInForm(flipCard: flipCard);
          },
        ),
      ),
    );
  }
}

  // @override
  // Widget build(BuildContext context) {
  //   AuthFormBloc bloc = sl<AuthFormBloc>();
  //   return Scaffold(
  //     backgroundColor: Colors.white,
  //     appBar: AppBar(
  //       title: Text("Login Page"),
  //     ),
  //     body: Center(
  //       child: SingleChildScrollView(
  //         child: Container(
  //           // color: Colors.green,
  //           child: BlocBuilder<AuthFormBloc, AuthFormState>(
  //             bloc: bloc,
  //             builder: (context, state) {
  //               return Column(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 mainAxisSize: MainAxisSize.max,
  //                 children: <Widget>[
  //                   Padding(
  //                     //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
  //                     padding: EdgeInsets.symmetric(horizontal: 15),
  //                     child: TextField(
  //                       onChanged: (String email) {
  //                         bloc.add(AuthFormInputsChangedEvent(email: email));
  //                       },
  //                       decoration: InputDecoration(
  //                           border: OutlineInputBorder(),
  //                           labelText: 'Email',
  //                           hintText: 'Enter valid email id as abc@gmail.com'),
  //                     ),
  //                   ),
  //                   Padding(
  //                     padding: const EdgeInsets.only(
  //                         left: 15.0, right: 15.0, top: 15, bottom: 0),
  //                     //padding: EdgeInsets.symmetric(horizontal: 15),
  //                     child: TextField(
  //                       obscureText: true,
  //                       onChanged: (String password) {
  //                         bloc.add(
  //                             AuthFormInputsChangedEvent(password: password));
  //                       },
  //                       decoration: InputDecoration(
  //                           border: OutlineInputBorder(),
  //                           labelText: 'Password',
  //                           hintText: 'Enter secure password'),
  //                     ),
  //                   ),
  //                   FlatButton(
  //                     onPressed: () {},
  //                     child: Text(
  //                       'Forgot Password',
  //                       style: TextStyle(color: Colors.blue, fontSize: 15),
  //                     ),
  //                   ),
  //                   Container(
  //                     height: 50,
  //                     width: 250,
  //                     decoration: BoxDecoration(
  //                         color: Colors.blue,
  //                         borderRadius: BorderRadius.circular(20)),
  //                     child: FlatButton(
  //                       onPressed: () {
  //                         bloc.add(AuthFormSignInSubmitted());
  //                       },
  //                       child: (State is AuthFormSubmissionLoading)
  //                           ? CircularProgressIndicator()
  //                           : Text(
  //                               'Login',
  //                               style: TextStyle(
  //                                   color: Colors.white, fontSize: 25),
  //                             ),
  //                     ),
  //                   ),
  //                   SizedBox(
  //                     height: 130,
  //                   ),
  //                   Text('New User? Create Account')
  //                 ],
  //               );
  //             },
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
// }
// shdjdjeui

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: HomePage(),
//     );
//   }
// }
