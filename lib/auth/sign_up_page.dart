import 'package:final_project/assessment/question1_goal.dart';
import 'package:final_project/themes/app_colors.dart';
import 'package:final_project/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:final_project/auth/auth_service.dart';
import 'package:final_project/assesment/assesment_step1.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreensState();
}

class _SignUpScreensState extends State<SignUpScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _isEmailValid = true;
  bool _isPasswordValid = true;
  bool _isConfirmPasswordValid = true;
  bool _loading = false;

  bool _validateEmail(String email) {
    return RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$").hasMatch(email);
  }

  Future<void> _doSignUp() async {
    setState(() => _loading = true);

    try {
      await AuthService().signUp(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => Question1Goal()),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Sign up failed: $e")));
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                ClipPath(
                  clipper: HeaderClipper(),
                  child: Container(
                    height: 140,
                    width: double.infinity,
                    color: AppColors.circleColor,
                  ),
                ),
                Positioned(
                  top: 40,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Image.asset('assets/logo.png', width: 60),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              'Sign Up For Free',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: AppColors.textColor,
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Email Address'),
                  const SizedBox(height: 6),
                  TextField(
                    controller: _emailController,
                    onChanged: (_) {
                      setState(() => _isEmailValid = true);
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter your email...',
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Image.asset('assets/email-logo.png', width: 24),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                        borderSide: BorderSide(
                          color: AppColors.errorInputButtonColor2,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                  if (!_isEmailValid)
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 12,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.errorInputButtonColor,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.errorInputButtonColor2,
                        ),
                      ),
                      child: Row(
                        children: [
                          Image.asset('assets/warning.png', width: 20),
                          const SizedBox(width: 8),
                          Text(
                            'Invalid Email Address!',
                            style: TextStyle(
                              color: AppColors.errorInputButtonColor2,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(height: 20),
                  // ---------------- PASSWORD ----------------
                  const Text('Password'),
                  const SizedBox(height: 6),
                  TextField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    onChanged: (value) {
                      setState(() {
                        _isPasswordValid = value.length >= 6;
                        _isConfirmPasswordValid =
                            _confirmPasswordController.text == value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter your password...',
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Image.asset('assets/lock.png', width: 20),
                      ),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Image.asset('assets/eye.png', width: 22),
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                  ),
                  if (!_isPasswordValid)
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        'Password must be at least 6 characters',
                        style: TextStyle(
                          color: AppColors.errorInputButtonColor2,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  const SizedBox(height: 20),
                  // ---------------- CONFIRM PASSWORD ----------------
                  const Text('Password Confirmation'),
                  const SizedBox(height: 6),
                  TextField(
                    controller: _confirmPasswordController,
                    obscureText: _obscurePassword,
                    onChanged: (value) {
                      setState(() {
                        _isConfirmPasswordValid =
                            value == _passwordController.text;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Confirm your password...',
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Image.asset('assets/lock.png', width: 20),
                      ),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Image.asset('assets/eye.png', width: 22),
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                  ),
                  if (!_isConfirmPasswordValid)
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        'Passwords do not match',
                        style: TextStyle(
                          color: AppColors.errorInputButtonColor2,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  const SizedBox(height: 30),
                  // ---------------- SIGN UP BUTTON ----------------
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: _loading
                          ? null
                          : () {
                              setState(() {
                                _isEmailValid = _validateEmail(
                                  _emailController.text,
                                );
                                _isPasswordValid =
                                    _passwordController.text.length >= 6;
                                _isConfirmPasswordValid =
                                    _confirmPasswordController.text ==
                                    _passwordController.text;
                              });

                              if (_isEmailValid &&
                                  _isPasswordValid &&
                                  _isConfirmPasswordValid) {
                                _doSignUp();
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: _loading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Sign Up",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Image.asset(
                                  'assets/arrow-right.png',
                                  width: 20,
                                  height: 20,
                                ),
                              ],
                            ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // ---------------- SIGN IN LINK ----------------
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have an account? '),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context); 
                        },
                        child: Text(
                          'Sign in.',
                          style: TextStyle(
                            color: AppColors.errorInputButtonColor2,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * 0.70);
    path.quadraticBezierTo(
      size.width / 2,
      size.height * 1.20,
      size.width,
      size.height * 0.70,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
