import 'package:dictionary/core/routes/named_routes.dart';
import 'package:dictionary/presentation/widgets/custom_fields/fields_decoration.dart';
import 'package:dictionary/services/user_session.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final passwordController = TextEditingController();

  final _userSession = GetIt.I<UserSession>();
  final ValueNotifier<bool> loading = ValueNotifier(false);
  final ValueNotifier<bool> obscurePassword = ValueNotifier(true);
  final ValueNotifier<bool> obscureConfirmPassword = ValueNotifier(true);

  @override
  void initState() {
    super.initState();
    final user = _userSession.value;
    _nameController.text = user?.name ?? '';
    _emailController.text = user?.email ?? '';
    passwordController.text = user?.password ?? '';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _updateUser() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      await _userSession.updateUserSession(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Dados atualizados com sucesso')),
      );
      _userSession.clear();
      Navigator.of(context).pushNamed(NamedRoute.main);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Erro ao atualizar: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = _userSession.value;
    if (user == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Atualizar Dados'),
        actions: [
          IconButton(
            onPressed: () async {
              await _userSession.clear();
              Navigator.of(
                context,
              ).pushNamedAndRemoveUntil(NamedRoute.login, (route) => false);
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(50),
              child: Form(
                key: _formKey,
                child: Column(
                  spacing: 30,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      "alterar dados".toUpperCase(),
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 25,
                      ),
                    ),
                    Column(
                      spacing: 3,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextFormField(
                          controller: _nameController,
                          decoration: FieldsDecoration('Nome'),
                          validator:
                              (value) =>
                                  value == null || value.isEmpty
                                      ? 'Informe seu nome'
                                      : null,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _emailController,
                          decoration: FieldsDecoration('E-mail'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Informe seu e-mail';
                            }
                            if (!value.contains('@')) {
                              return 'E-mail inválido';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        ValueListenableBuilder<bool>(
                          valueListenable: obscurePassword,
                          builder: (_, value, __) {
                            return TextFormField(
                              controller: passwordController,
                              obscureText: value,
                              decoration: FieldsDecoration(
                                'senha',
                                __,
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
                            );
                          },
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          style: ButtonStyle(
                            padding: WidgetStateProperty.all<EdgeInsets>(
                              const EdgeInsets.all(18),
                            ),
                            backgroundColor: WidgetStateProperty.all<Color>(
                              const Color(0xff262626),
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
                          onPressed: _updateUser,
                          child: const Text(
                            'ALTERAR DADOS',
                            style: TextStyle(
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
