import 'package:booky_app/models/user_model.dart';
import 'package:booky_app/screens/auth/login_screen.dart';
import 'package:booky_app/screens/auth/widget/input_field.dart';
import 'package:booky_app/screens/auth/widget/social_button.dart';
import 'package:booky_app/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 60),

                Text(
                  "Sign Up 🚀",
                  style: GoogleFonts.inter(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 12),

                // Description
                Text(
                  "Found a flight that matches your destination\nand schedulook it instantly..",
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    color: Colors.black54,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 50),

                // Form Register
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // NAME FIELD
                      InputField(
                        label: "Name",
                        controller: _nameCtrl,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Name is required";
                          }
                          if (value.length < 2) {
                            return "Name too short";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),

                      // EMAIL FIELD
                      InputField(
                        label: "Email",
                        controller: _emailCtrl,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Email is required";
                          }
                          if (!RegExp(
                            r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                          ).hasMatch(value)) {
                            return "Please enter a valid email";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),

                      // PASSWORD FIELD
                      InputField(
                        label: "Password",
                        controller: _passCtrl,
                        obscureText: _obscure,
                        suffixIcon: Icon(
                          _obscure ? Icons.visibility_off : Icons.visibility,
                          color: Colors.black54,
                          size: 22,
                        ),
                        onTapSuffix: () => setState(() => _obscure = !_obscure),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Password is required";
                          }
                          if (value.length < 6) {
                            return "Password must be at least 6 characters";
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // Sign Up Button
                SizedBox(
                  width: double.infinity,
                  height: 64,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // SIMPAN NAMA USER
                        UserModel.setName(_nameCtrl.text);

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Register Success!")),
                        );
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                        );
                      }
                    },
                    child: Text(
                      "Sign Up",
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                // Social Buttons
                SocialButton(
                  icon: Icons.g_mobiledata,
                  label: "Sign up with Google",
                  onPressed: () => print("Google Register"),
                ),
                const SizedBox(height: 16),
                SocialButton(
                  icon: Icons.facebook,
                  label: "Sign up with Facebook",
                  onPressed: () => print("Facebook Register"),
                ),

                const SizedBox(height: 50),

                // Login Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "You have an account? ",
                      style: GoogleFonts.inter(color: Colors.black54),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                      child: Text(
                        "Login",
                        style: GoogleFonts.inter(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                          decorationThickness: 1,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
