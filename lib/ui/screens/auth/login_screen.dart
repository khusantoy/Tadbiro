import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tadbiro/logic/blocs/auth/auth_bloc.dart';
import 'package:tadbiro/ui/screens/widgets/textformfield_item.dart';
import 'package:tadbiro/utils/loading_dialog.dart';
import 'package:tadbiro/utils/routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _validateAndSubmit() async {
    if (_formKey.currentState!.validate()) {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(content: Text('Processing Data')),
      // );
      LoadingDialog.showLoadingDialog(context);
      

      context.read<AuthBloc>().add(LoginAuthEvent(emailController.text, passwordController.text));
        
      //     .then((user) {
      //   if (!mounted) return;
      //   Navigator.pop(context);
      // }).catchError((error) {
      //   if (mounted) {
      //     Navigator.pop(context);
      //     ScaffoldMessenger.of(context).showSnackBar(
      //       SnackBar(content: Text('Login failed: $error')),
      //     );
      //   }
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextformfieldItem(
                labelText: "Email",
                textEditingController: emailController,
                textInputType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Enter your email";
                  } else {
                    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                    if (!emailRegex.hasMatch(value)) {
                      return "Email is wrong";
                    }
                  }

                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextformfieldItem(
                labelText: "Password",
                textEditingController: passwordController,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Enter your password";
                  }
                  return null;
                },
                textInputType: TextInputType.name,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.resetPassword);
                    },
                    child: const Text(
                      "Reset password?",
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: _validateAndSubmit,
                  child: const Text("Login"),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text("Don't have an account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.register,
                      );
                    },
                    child: const Text(
                      "Register",
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
