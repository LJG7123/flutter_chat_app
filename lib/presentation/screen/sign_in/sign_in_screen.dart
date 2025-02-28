import 'package:flutter/material.dart';
import 'package:flutter_chat_app/presentation/widget/expanded_button.dart';
import 'package:flutter_chat_app/presentation/widget/expanded_progress_button.dart';
import 'package:flutter_chat_app/presentation/widget/general_text_field.dart';
import 'package:flutter_chat_app/presentation/widget/obscure_text_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          spacing: 8,
          children: [
            Spacer(),
            GeneralTextField(controller: _emailController, hintText: '아이디',),
            ObscureTextField(controller: _passwordController, hintText: '패스워드',),
            ExpandedProgressButton(onPressed: () async {}, text: '로그인'),
            Spacer(),
            ExpandedButton(onPressed: () {}, text: '회원가입'),
          ],
        ),
      ),
    );
  }
}
