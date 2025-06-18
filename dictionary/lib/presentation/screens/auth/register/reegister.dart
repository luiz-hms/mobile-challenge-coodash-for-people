import 'package:dictionary/core/dependence_injector/injector.dart';
import 'package:dictionary/core/routes/named_routes.dart';
import 'package:dictionary/domain/repositories/user_repository/user_repository.dart';
import 'package:dictionary/presentation/widgets/custom_fields/fields_decoration.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var repository = locator.get<UserRepository>();
  final TextEditingController nameTextController = TextEditingController();
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  final TextEditingController passwordConfirmTextController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ValueNotifier<bool> isLoading = ValueNotifier(false);

  Future<void> _handleRegister() async {
    if (_formKey.currentState?.validate() ?? false) {
      if (passwordTextController.text != passwordConfirmTextController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('As senhas não coincidem')),
        );
        return;
      }

      isLoading.value = true;
      try {
        final result = await repository.insertUser(
          nameTextController.text.trim(),
          emailTextController.text.trim(),
          passwordTextController.text,
        );

        Navigator.of(
          context,
        ).pushNamedAndRemoveUntil(NamedRoute.main, (route) => false);
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(e.toString())));
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
                    Text(
                      "cadastre-se".toUpperCase(),
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 30,
                      ),
                    ),
                    Column(
                      spacing: 30,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextFormField(
                          controller: nameTextController,
                          decoration: FieldsDecoration('nome'),
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Informe o nome';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: emailTextController,
                          decoration: FieldsDecoration('email'),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Informe o email';
                            }
                            if (!value.contains('@')) {
                              return 'Email inválido';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: passwordTextController,
                          decoration: FieldsDecoration('senha'),
                          obscureText: false,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Informe a senha';
                            }
                            if (value.length < 6) {
                              return 'A senha deve ter no mínimo 6 caracteres';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: passwordConfirmTextController,
                          decoration: FieldsDecoration('confirmar senha'),
                          obscureText: false,
                          textInputAction: TextInputAction.done,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Confirme a senha';
                            }
                            return null;
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
                              onPressed: loading ? null : _handleRegister,
                              child:
                                  loading
                                      ? const CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                      : const Text(
                                        'CADASTRAR',
                                        style: TextStyle(
                                          color: Color(0xfffbfbfb),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                            );
                          },
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
