import 'package:cleanarchitecture/core/constants/constants.dart';
import 'package:cleanarchitecture/features/presentation/pages/user_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/auth_bloc.dart'; // Ganti path sesuai project

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _rememberMe = false;

  // Tambahkan controller untuk email & password
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Gunakan BlocConsumer atau BlocListener untuk tangani success/error
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLoading) {
            // Bisa tampilkan overlay loading atau snackBar loading
          } else if (state is AuthSuccess) {
            // Contoh: Tampilkan pesan sukses
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Login Berhasil!')),
            );
            // Navigasi ke halaman lain (misalnya HomePage)
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => UserPage()));
          } else if (state is AuthFailure) {
            // Munculkan pesan error
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Login Gagal: ${state.message}')),
            );
          }
        },
        builder: (context, state) {
          // Jika diinginkan, saat AuthLoading kita bisa tampilkan spinner
          if (state is AuthLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // Kalau tidak loading, tampilkan UI seperti MarcusNg
          return AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Stack(
                children: <Widget>[
                  // Background gradient
                  Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFF73AEF5),
                          Color(0xFF61A4F1),
                          Color(0xFF478DE0),
                          Color(0xFF398AE5),
                        ],
                        stops: [0.1, 0.4, 0.7, 0.9],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: double.infinity,
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40.0,
                        vertical: 120.0,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text(
                            'Sign In',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'OpenSans',
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 30.0),

                          // WIDGET: Email
                          _buildEmailTF(),

                          const SizedBox(height: 30.0),

                          // WIDGET: Password
                          _buildPasswordTF(),

                          // Lupa Password
                          _buildForgotPasswordBtn(),

                          // Remember me
                          _buildRememberMeCheckbox(),

                          // Tombol Login (panggil BLoC event)
                          _buildLoginBtn(),

                          // OR - Sign in with
                          _buildSignInWithText(),

                          // Icon FB & Google
                          _buildSocialBtnRow(),

                          // Sign Up
                          _buildSignupBtn(),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // ===================== WIDGET PEMBENTUK LAYOUT =====================

  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Email', style: kLabelStyle),
        const SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: _emailCtrl, // <-- Pakai controller
            keyboardType: TextInputType.emailAddress,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.only(top: 14.0),
              prefixIcon: const Icon(Icons.email, color: Colors.white),
              hintText: 'Enter your Email',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Password', style: kLabelStyle),
        const SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: _passCtrl, // <-- Pakai controller
            obscureText: true,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.only(top: 14.0),
              prefixIcon: const Icon(Icons.lock, color: Colors.white),
              hintText: 'Enter your Password',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildForgotPasswordBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () => debugPrint('Forgot Password Pressed'),
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        child: Text('Forgot Password?', style: kLabelStyle),
      ),
    );
  }

  Widget _buildRememberMeCheckbox() {
    return SizedBox(
      height: 20.0,
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.white),
            child: Checkbox(
              value: _rememberMe,
              checkColor: Colors.green,
              activeColor: Colors.white,
              onChanged: (value) {
                setState(() {
                  _rememberMe = value ?? false;
                });
              },
            ),
          ),
          Text('Remember me', style: kLabelStyle),
        ],
      ),
    );
  }

  Widget _buildLoginBtn() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: ElevatedButton(
        // style
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(15.0),
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          backgroundColor: Colors.white,
        ),
        onPressed: () {
          final email = _emailCtrl.text.trim();
          final pass = _passCtrl.text.trim();

          // Kirim event ke BLoC
          context.read<AuthBloc>().add(DoLogin(email, pass));
        },
        child: const Text(
          'LOGIN',
          style: TextStyle(
            color: Color(0xFF527DAA),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  Widget _buildSignInWithText() {
    return Column(
      children: <Widget>[
        const Text(
          '- OR -',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
        ),
        const SizedBox(height: 20.0),
        Text('Sign in with', style: kLabelStyle),
      ],
    );
  }

  Widget _buildSocialBtnRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _SocialBtn(
            onTap: () => debugPrint('Login with Facebook'),
            logo: const AssetImage('assets/logos/facebook.jpg'),
          ),
          _SocialBtn(
            onTap: () => debugPrint('Login with Google'),
            logo: const AssetImage('assets/logos/google.jpg'),
          ),
        ],
      ),
    );
  }

  Widget _buildSignupBtn() {
    return GestureDetector(
      onTap: () => debugPrint('Sign Up Pressed'),
      child: RichText(
        text: const TextSpan(
          children: [
            TextSpan(
              text: 'Don\'t have an Account? ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'Sign Up',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget kecil untuk Social Button
class _SocialBtn extends StatelessWidget {
  final VoidCallback onTap;
  final AssetImage logo;

  const _SocialBtn({required this.onTap, required this.logo});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60.0,
        width: 60.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 2),
              blurRadius: 6.0,
            ),
          ],
          image: DecorationImage(image: logo),
        ),
      ),
    );
  }
}