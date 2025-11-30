import 'package:final_project/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:final_project/auth/auth_service.dart';
import 'package:final_project/auth/sign_up_page.dart';
class SignInScreens extends StatefulWidget {
  const SignInScreens({super.key});

  @override
  State<SignInScreens> createState() => _SignInScreensState();
}

class _SignInScreensState extends State<SignInScreens> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;
  bool _isEmailValid = true;
  bool _isPasswordValid = true;
  bool _loading = false;

  bool _validateEmail(String email) {
    return RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$").hasMatch(email);
  }

  Future<void> _doLogin() async {
    setState(() => _loading = true);

    try {
      await AuthService().signIn(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );

      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Login failed: $e")),
      );
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

             SizedBox(height: 20),

            Text(
              'Sign In to Freud.ai',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppColors.textColor,
              ),
            ),

             SizedBox(height: 30),

            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text('Email Address'),
                   SizedBox(height: 6),
                  TextField(
                    controller: _emailController,
                    onChanged: (_) {
                      setState(() {
                        _isEmailValid = true;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter your email...',
                      prefixIcon: Padding(
                        padding:  EdgeInsets.all(12),
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
                      margin:  EdgeInsets.only(top: 10),
                      padding:  EdgeInsets.symmetric(
                          vertical: 10, horizontal: 12),
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
                           SizedBox(width: 8),
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

                   SizedBox(height: 20),

                   Text('Password'),
                   SizedBox(height: 6),
                  TextField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    onChanged: (_) {
                      setState(() {
                        _isPasswordValid = true;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter your password...',
                      prefixIcon: Padding(
                        padding:  EdgeInsets.all(10),
                        child: Image.asset('assets/lock.png', width: 20),
                      ),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                        child: Padding(
                          padding:  EdgeInsets.all(12),
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
                      padding:  EdgeInsets.only(top: 10),
                      child: Text(
                        'Password must be at least 6 characters',
                        style: TextStyle(
                          color: AppColors.errorInputButtonColor2,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),

                   SizedBox(height: 40),

                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: _loading
                          ? null
                          : () {
                              setState(() {
                                _isEmailValid =
                                    _validateEmail(_emailController.text);
                                _isPasswordValid =
                                    _passwordController.text.length >= 6;
                              });

                              if (_isEmailValid && _isPasswordValid) {
                                _doLogin();
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: _loading
                          ?  CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                 Text(
                                  "Sign In",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                                 SizedBox(width: 8),
                                Image.asset('assets/arrow-right.png',
                                    width: 20, height: 20),
                              ],
                            ),
                    ),
                  ),

                   SizedBox(height: 25),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _socialIcon("assets/facebook-logo.png"),
                       SizedBox(width: 16),
                      _socialIcon("assets/google-logo.png"),
                       SizedBox(width: 16),
                      _socialIcon("assets/instagram-logo.png"),
                    ],
                  ),

                   SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                       Text('Don’t have an account? '),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>  SignUpScreen()),
                          );
                        },
                        child: Text(
                          'Sign Up.',
                          style: TextStyle(
                            color: AppColors.errorInputButtonColor2,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),

                   SizedBox(height: 20),

                  Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () {},
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: AppColors.errorInputButtonColor2,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _socialIcon(String path) {
    return Container(
      padding:  EdgeInsets.all(12),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: Image.asset(path, width: 20),
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
  bool shouldReclip(oldClipper) => false;
}
