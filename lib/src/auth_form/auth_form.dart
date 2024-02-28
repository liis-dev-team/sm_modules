import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sm_modules/sm_ui_kit.dart';

class AuthForm extends StatelessWidget {
  final Stream<String>? emailStream;
  final Stream<String?>? emailErrorStream;
  final Stream<String>? passwordStream;
  final Stream<String?>? passwordErrorStream;
  final Stream<String?>? errorStream;
  final Stream<bool>? loadingStream;
  final Stream<bool>? confirmStream;
  final void Function(String email)? onEmailChanged;
  final void Function(String password)? onPasswordChanged;
  final VoidCallback? onConfirm;
  final VoidCallback? onForgotPassword;

  const AuthForm({
    super.key,
    this.emailStream,
    this.emailErrorStream,
    this.passwordStream,
    this.passwordErrorStream,
    this.errorStream,
    this.loadingStream,
    this.confirmStream,
    this.onEmailChanged,
    this.onPasswordChanged,
    this.onConfirm,
    this.onForgotPassword,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFDBDEF9),
                  Color(0xFFA3A2E0),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          AnimatedSwitcher(
            duration: kThemeAnimationDuration,
            child: FutureBuilder<Uint8List>(
              future: Future(
                () async {
                  return rootBundle
                      .load('packages/sm_modules/assets/images/auth_back_cubes.png')
                      .then((value) => value.buffer.asUint8List());
                },
              ),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Image.memory(
                    snapshot.data!,
                    key: const ValueKey('image'),
                    fit: BoxFit.cover,
                  );
                }
                return const SizedBox(
                  key: ValueKey('box'),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 100),
            child: Center(
              child: SizedBox(
                width: 334,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'packages/sm_modules/assets/images/logo.svg',
                      width: 133,
                      // height: 22,
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Text(
                      'Simple Model',
                      style: AT.t.h2.copyWith(color: Color(0xFF3C4044)),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Container(
                      decoration: const BoxDecoration(
                          color: AppColorsLight.white,
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                          boxShadow: [
                            BoxShadow(
                              offset: const Offset(0, 4),
                              color: Colors.black12,
                              blurRadius: 14,
                            )
                          ]),
                      padding: EdgeInsets.all(32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          StreamBuilder<String>(
                            stream: emailStream,
                            initialData: null,
                            builder: (context, data) {
                              return StreamBuilder<String?>(
                                stream: emailErrorStream,
                                builder: (context, error) {
                                  return AppTextField(
                                    labelText: 'Логин',
                                    initialValue: data.data,
                                    errorText: error.data,
                                    onChanged: onEmailChanged,
                                  );
                                },
                              );
                            },
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          StreamBuilder<String>(
                            stream: passwordStream,
                            initialData: null,
                            builder: (context, data) {
                              return StreamBuilder<String?>(
                                stream: passwordErrorStream,
                                builder: (context, error) {
                                  return AppTextField(
                                    labelText: 'Пароль',
                                    password: true,
                                    initialValue: data.data,
                                    errorText: error.data,
                                    onChanged: onPasswordChanged,
                                  );
                                },
                              );
                            },
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          StreamBuilder<bool>(
                              stream: confirmStream,
                              initialData: true,
                              builder: (context, confirmation) {
                              return StreamBuilder<bool>(
                                stream: loadingStream,
                                initialData: false,
                                builder: (context, loading) {
                                  return AppElevatedButton(
                                    text: 'Войти',
                                    loading: loading.data ?? false,
                                    enabled: confirmation.data ?? true,
                                    onTap: onConfirm,
                                  );
                                }
                              );
                            }
                          ),
                          // SizedBox(
                          //   height: 16,
                          // ),
                          // AppTextButton(
                          //   text: 'Забыли пароль?',
                          //   onTap: onForgotPassword,
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
