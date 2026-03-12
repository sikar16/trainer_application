import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:gheero/feature/auth/presentation/bloc/login_bloc.dart';
import 'package:gheero/feature/auth/presentation/bloc/login_event.dart';
import 'package:gheero/feature/auth/presentation/bloc/login_state.dart';
import '../../../../core/snack_bar/snack_bar_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _obscurePassword = true;
  String? _passwordError;

  void _login() {
    if (_formKey.currentState!.validate()) {
      context.read<LoginBloc>().add(
        LoginSubmitted(
          _emailController.text.trim(),
          _passwordController.text.trim(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          CustomSnackBar.success(context, 'Login successful!');
          context.push('/training');
        } else if (state is LoginFailure) {
          setState(() {
            _passwordError = state.message;
          });
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 80),

                  Image.asset(
                    'assets/images/gheero.png',
                    width: 80,
                    height: 80,
                  ),

                  const SizedBox(height: 24),

                  Text(
                    "Welcome Back ",
                    style: textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 30),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Email ", style: TextStyle(fontSize: 14)),
                  ),

                  const SizedBox(height: 8),

                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Email is required";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Enter your email",
                      filled: true,
                      fillColor: const Color(0xFFF6F6F6),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: _passwordError != null
                            ? const BorderSide(color: Colors.red, width: 1)
                            : BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: _passwordError != null
                            ? const BorderSide(color: Colors.red, width: 1)
                            : BorderSide(color: colorScheme.primary, width: 1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: _passwordError != null
                            ? const BorderSide(color: Colors.red, width: 1)
                            : BorderSide.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  /// Password
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Password", style: TextStyle(fontSize: 14)),
                  ),

                  const SizedBox(height: 8),

                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Password is required";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Enter your password",
                      filled: true,
                      fillColor: const Color(0xFFF6F6F6),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: _passwordError != null
                            ? const BorderSide(color: Colors.red, width: 1)
                            : BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: _passwordError != null
                            ? const BorderSide(color: Colors.red, width: 1)
                            : BorderSide(color: colorScheme.primary, width: 1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: _passwordError != null
                            ? const BorderSide(color: Colors.red, width: 1)
                            : BorderSide.none,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                  ),

                  if (_passwordError != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          _passwordError!,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),

                  const SizedBox(height: 8),

                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        context.push('/forgot-password');
                      },
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(
                          color: colorScheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      return SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          // onPressed: state is LoginLoading ? null : _login,
                          onPressed: () {
                            if (state is! LoginLoading) {
                              _login();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colorScheme.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),
                          child: state is LoginLoading
                              ? const SizedBox(
                                  height: 22,
                                  width: 22,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : const Text(
                                  "Login",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
