import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ghost/constants/app_colors.dart';
import 'package:ghost/core/models/auth/password.dart';
import 'package:ghost/core/models/auth/auth_model.dart';
import 'package:ghost/core/models/auth/username.dart';
import 'package:ghost/core/services/auth_services.dart';
import 'package:ghost/ui/components/event_button.dart';
import 'package:ghost/ui/components/input_text.dart';
import 'package:ghost/utils/utils.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatelessWidget {
  AuthPage({super.key});

  final Utils _utils = Utils();

  void _onSubmit(BuildContext context, AuthModel authModel) async {
    try {
      authModel.setLoading = true;
      final Username username = Username(username: authModel.username);
      final Password password = Password(password: authModel.password);

      username.validate();
      password.validate();

      final AuthServices services = AuthServices(
        username: username.getValue,
        password: password.getValue,
      );
      authModel.isLogin ? await services.signIn() : await services.signUp();

      if (!context.mounted) return;
      _utils.pushAndRemoveUntil(context);
    } on FirebaseException catch (messageError) {
      _utils.showMessageError(context, message: messageError.toString());
    } catch (messageError) {
      _utils.showMessageError(context, message: messageError.toString());
    } finally {
      authModel.setLoading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final AuthModel provider = Provider.of<AuthModel>(context);
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SizedBox.expand(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: .center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF232323),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Image.asset(
                    'assets/images/icon-removebg.png',
                    width: 180,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  provider.isLogin ? 'LogIn App' : 'Signup',
                  style: TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 30),
                InputText(
                  onChanged: (name) => provider.username = name,
                  label: 'Username',
                ),
                SizedBox(height: 10),
                InputText(
                  onChanged: (passwd) => provider.password = passwd,
                  label: 'Password',
                ),

                SizedBox(height: 15),
                EventButton(
                  onTap: !provider.isLoading
                      ? () => _onSubmit(context, provider)
                      : null,
                  title: provider.isLogin ? 'LogIn' : 'Signup',
                  color: AppColors.pupleLowColor,
                ),
                SizedBox(height: 12),
                InkWell(
                  onTap: provider.isLoading
                      ? null
                      : () => provider.changeMode(),
                  child: Text(
                    provider.isLogin
                        ? "Don't have an account? Create an account"
                        : "Do you already have an account? Log in",
                    style: TextStyle(
                      color: AppColors.whiteColor.withAlpha(180),
                    ),
                  ),
                ),
              ],
            ),
            provider.isLoading
                ? Center(
                    child: Container(
                      padding: EdgeInsets.all(23),
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        color: const Color(0xFF232323).withAlpha(160),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: CircularProgressIndicator(
                        color: Colors.cyanAccent,
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
