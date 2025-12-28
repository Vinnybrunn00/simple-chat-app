
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

  final AuthServices _services = AuthServices();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthModel>(context);
    final Username username = provider.username;
    final Password password = provider.password;
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
                  onChanged: (name) => username.setValue = name,
                  label: 'Username',
                ),
                SizedBox(height: 10),
                InputText(
                  onChanged: (passwd) => password.setValue = passwd,
                  label: 'Password',
                ),

                SizedBox(height: 15),
                EventButton(
                  onTap: !provider.isLoading
                      ? () async {
                          provider.setLoading = true;
                          try {
                            username.validate();
                            password.validate();

                            await _services.signInAndSignup(
                              username: username.getValue,
                              password: password.getValue,
                              isLogin: provider.isLogin,
                            );
                            if (!context.mounted) return;
                            _utils.pushAndRemoveUntil(context);
                          } catch (messageError) {
                            if (!context.mounted) return;
                            _utils.showMessageError(
                              context,
                              message: messageError.toString(),
                            );
                            provider.setLoading = false;
                          } finally {
                            provider.setLoading = false;
                          }
                        }
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
