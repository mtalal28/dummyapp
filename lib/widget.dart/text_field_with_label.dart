import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class TextFieldWithLabel extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final bool isMandatory;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String)? onChanged;

  const TextFieldWithLabel({
    Key? key,
    required this.controller,
    required this.label,
    required this.hint,
    this.isMandatory = false,
    this.keyboardType = TextInputType.text,  // Change this to TextInputType.text
    this.textInputAction = TextInputAction.done,
    this.inputFormatters,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(color: Colors.white),
            ),
            if (isMandatory)
              const Text(
                '*',
                style: TextStyle(color: Colors.red),
              ),
          ],
        ),
        const SizedBox(height: 5),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          inputFormatters: inputFormatters ??
              [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9+()]')),  
              ],
          onChanged: onChanged,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.grey),
            filled: true,
            fillColor: const Color(0xFF282828),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}




// // Place the reusable widget class here or in another file and import it

// class TextFieldWithLabel extends StatelessWidget {
//   final TextEditingController controller;
//   final String label;
//   final String hint;
//   final bool isMandatory;
//  final TextInputType keyboardType;
//   final TextInputAction textInputAction;
//   final List<TextInputFormatter>? inputFormatters;
//   final TextStyle? style; 
//   final void Function(String)? onChanged;
  

//   const TextFieldWithLabel({
//     Key? key,
//     required this.controller,
//     required this.label,
//     required this.hint,
//     this.isMandatory = false,
//     // this.keyboardType,
//     this.style, this.onChanged, 
//     required TextEditingController,
//     this.keyboardType = TextInputType.text,
//     this.textInputAction = TextInputAction.done,
//     this.inputFormatters, 
    
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Text(
//               label,
//               style: const TextStyle(color: Colors.white),
//             ),
//             if (isMandatory)
//               const Text(
//                 '*',
//                 style: TextStyle(color: Colors.red),
//               ),
//           ],
//         ),
//         const SizedBox(height: 5),
//         TextField(
//           decoration: InputDecoration(
//              controller: controller,
//           keyboardType: keyboardType,
//           textInputAction: textInputAction,
//           inputFormatters: inputFormatters,
//           onChanged: onChanged,
//             hintText: hint,
//             hintStyle: const TextStyle(color: Colors.grey),
//             filled: true,
//             fillColor: const Color(0xFF282828),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10),
//               borderSide: BorderSide.none,
//             ),
//           ),
//           onChanged: onChanged,
//           style: style ?? const TextStyle(height: 1, color: Colors.white), 
//         ),
//         const SizedBox(height: 20),
//       ],
//     );
//   }
// }
