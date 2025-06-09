// import 'package:flutter/material.dart';

// class CustomTextField extends StatelessWidget {
//   final TextEditingController controller;
//   final FocusNode? focusNode;
//   final String label;
//   final Widget prefixIcon; // Changed from IconData to Widget
//   final bool isPassword;
//   final TextInputType keyboardType;

//   const CustomTextField({
//     super.key,
//     required this.controller,
//     required this.focusNode,
//     required this.label,
//     required this.prefixIcon, // Required change
//     this.isPassword = false,
//     this.keyboardType = TextInputType.text,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       controller: controller,
//       focusNode: focusNode,
//       obscureText: isPassword,
//       keyboardType: keyboardType,
//       decoration: InputDecoration(
//         labelText: label,
//         labelStyle: const TextStyle(fontWeight: FontWeight.w500),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//         ),
//         prefixIcon: prefixIcon, // Now accepts any Widget
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final String label;
  final Widget prefixIcon;
  final Widget? suffixiconvisble;    
  final Widget? suffixiconNotvisble;  
  final bool isPassword;
  final TextInputType keyboardType;

  const CustomTextField({
    super.key,
    required this.controller,
    this.suffixiconvisble,
    this.suffixiconNotvisble,
    required this.focusNode,
    required this.label,
    required this.prefixIcon,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      obscureText: _obscureText,
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: const TextStyle(fontWeight: FontWeight.w500),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.isPassword
            ? Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius:
                      BorderRadius.circular(30), // Circular ripple effect
                  onTap: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: _obscureText
                        ? widget.suffixiconNotvisble
                        : widget.suffixiconvisble,
                  ),
                ),
              )
            : null,
      ),
    );
  }
}
