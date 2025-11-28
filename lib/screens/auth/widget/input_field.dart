import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InputField extends FormField<String> {
  InputField({
    super.key,
    required String label,
    required TextEditingController controller,
    bool obscureText = false,
    TextInputType? keyboardType,
    FormFieldValidator<String>? validator,
    Widget? suffixIcon,
    VoidCallback? onTapSuffix,
  }) : super(
          validator: validator,
          builder: (FormFieldState<String> state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // === CONTAINER INPUT ===
                Container(
                  height: 70,
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF9F9F9),
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(
                      color: state.hasError
                          ? Colors.red
                          : (state.isValid || state.value?.isNotEmpty == true)
                              ? Colors.black87
                              : Colors.transparent,
                      width: state.hasError ? 2 : 1.5,
                    ),
                  ),
                  child: Row(
                    children: [
                      // Label
                      Text(
                        label,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.black54,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Garis |
                      Container(width: 1, height: 28, color: Colors.black26),
                      const SizedBox(width: 16),

                      // TextField
                      Expanded(
                        child: TextFormField(
                          controller: controller,
                          obscureText: obscureText,
                          keyboardType: keyboardType,
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                          ),
                          cursorColor: Colors.black54,
                          decoration: InputDecoration(
                            isDense: true,
                            border: InputBorder.none,
                            hintText: "",
                            contentPadding: const EdgeInsets.symmetric(vertical: 22),
                            suffixIcon: suffixIcon != null
                                ? GestureDetector(
                                    onTap: onTapSuffix,
                                    child: suffixIcon,
                                  )
                                : null,
                          ),
                          onChanged: (value) {
                            state.didChange(value);
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                // === ERROR TEXT DI BAWAH ===
                if (state.hasError)
                  Padding(
                    padding: const EdgeInsets.only(top: 8, left: 12),
                    child: Text(
                      state.errorText ?? '',
                      style: GoogleFonts.poppins(
                        color: Colors.red,
                        fontSize: 13,
                      ),
                    ),
                  ),
              ],
            );
          },
        );
}