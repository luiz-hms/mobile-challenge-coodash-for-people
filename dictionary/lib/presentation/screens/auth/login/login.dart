import 'package:dictionary/core/dependence_injector/injector.dart';
import 'package:dictionary/core/routes/named_routes.dart';
import 'package:dictionary/domain/repositories/user_repository/user_repository.dart';
import 'package:dictionary/presentation/widgets/custom_fields/fields_decoration.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var repository = locator.get<UserRepository>();
  final ValueNotifier<bool> obscurePassword = ValueNotifier(true);
  final ValueNotifier<bool> isLoading = ValueNotifier(false);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _handleLogin() async {
    if (_formKey.currentState?.validate() ?? false) {
      isLoading.value = true;

      try {
        final user = await repository.loginUser(
          emailController.text.trim(),
          passwordController.text,
        );

        if (user != null) {
          Navigator.of(
            context,
          ).pushNamedAndRemoveUntil(NamedRoute.main, (route) => false);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Email ou senha incorretos')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao fazer login: ${e.toString()}')),
        );
      } finally {
        isLoading.value = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 80),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(50),
              child: Form(
                key: _formKey,
                child: Column(
                  spacing: 80,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Column(
                      children: [
                        Lottie.asset(
                          'assets/translatelottie.json',
                          width: 150,
                          height: 150,
                        ),
                        Text(
                          "dictionary".toUpperCase(),
                          style: const TextStyle(color: Color(0xfff56e0f)),
                        ),
                      ],
                    ),
                    Column(
                      spacing: 30,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextFormField(
                          controller: emailController,
                          decoration: FieldsDecoration(
                            'email',
                            const Icon(Icons.mail),
                          ),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'O campo precisa ser preenchido';
                            }
                            if (!value.contains('@')) {
                              return 'Email inválido';
                            }
                            return null;
                          },
                        ),
                        ValueListenableBuilder<bool>(
                          valueListenable: obscurePassword,
                          builder: (_, value, __) {
                            return TextFormField(
                              controller: passwordController,
                              decoration: FieldsDecoration(
                                'senha',
                                const Icon(Icons.security),
                                IconButton(
                                  onPressed: () {
                                    obscurePassword.value = !value;
                                  },
                                  icon: Icon(
                                    value
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                ),
                              ),
                              textInputAction: TextInputAction.done,
                              obscureText: value,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'O campo precisa ser preenchido';
                                }
                                return null;
                              },
                            );
                          },
                        ),
                        const SizedBox(height: 20),
                        ValueListenableBuilder<bool>(
                          valueListenable: isLoading,
                          builder: (_, loading, __) {
                            return ElevatedButton(
                              style: ButtonStyle(
                                padding: WidgetStateProperty.all<EdgeInsets>(
                                  const EdgeInsets.all(18),
                                ),
                                backgroundColor: WidgetStateProperty.all<Color>(
                                  const Color(0xff262626),
                                ),
                                shape: WidgetStateProperty.all<
                                  RoundedRectangleBorder
                                >(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    side: const BorderSide(
                                      color: Colors.transparent,
                                    ),
                                  ),
                                ),
                              ),
                              onPressed: loading ? null : _handleLogin,
                              child:
                                  loading
                                      ? const CircularProgressIndicator(
                                        color: Color(0xfff56e0f),
                                      )
                                      : Text(
                                        'entrar'.toUpperCase(),
                                        style: const TextStyle(
                                          color: Color(0xfffbfbfb),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                            );
                          },
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            padding: WidgetStateProperty.all<EdgeInsets>(
                              const EdgeInsets.all(18),
                            ),
                            backgroundColor: WidgetStateProperty.all<Color>(
                              const Color(0xff878787),
                            ),
                            shape:
                                WidgetStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    side: const BorderSide(
                                      color: Colors.transparent,
                                    ),
                                  ),
                                ),
                          ),
                          onPressed: () {
                            Navigator.of(
                              context,
                            ).pushNamed(NamedRoute.register);
                          },
                          child: Text(
                            'cadastre-se'.toUpperCase(),
                            style: const TextStyle(
                              color: Color(0xfffbfbfb),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
