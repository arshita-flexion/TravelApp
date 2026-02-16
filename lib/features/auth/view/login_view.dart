import 'package:codefest_travel_app/core/utils/app_exports.dart';
import 'package:codefest_travel_app/features/auth/bloc/auth_bloc.dart';
import 'package:codefest_travel_app/generated/assets.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.otpSent) {
          NavigatorService.pushNamed(AppRoutes.otpVerificationRoute, arguments: state.email);
        } else if (state.status == AuthStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.errorMessage ?? 'Error')));
        }
      },
      builder: (context, state) {
        return AnnotatedRegion(
          value: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
            systemNavigationBarColor: Colors.white,
            systemNavigationBarIconBrightness: Brightness.dark,
          ),
          child: Scaffold(
            backgroundColor: theme.scaffoldBackgroundColor,
            appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
            body: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'WELCOME',
                      style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900, letterSpacing: 2),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Enter your email to continue',
                      style: TextStyle(color: Color(0xFF999999), fontSize: 16, fontFamily: 'Satoshi'),
                    ),
                    const SizedBox(height: 48),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                        labelText: 'EMAIL ADDRESS',
                        labelStyle: TextStyle(letterSpacing: 1, fontSize: 12),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Image.asset(Assets.images.pngEmail, color: Colors.black, width: 20, height: 20),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Please enter your email';
                        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 32),
                    ElevatedButton(
                      onPressed: state.status == AuthStatus.loading
                          ? null
                          : () {
                              if (_formKey.currentState!.validate()) {
                                context.read<AuthBloc>().add(LoginWithEmailRequested(_emailController.text));
                              }
                            },
                      child: state.status == AuthStatus.loading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                            )
                          : const Text('CONTINUE', style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.w900)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
