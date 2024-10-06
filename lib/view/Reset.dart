import 'package:flutter/material.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous screen
          },
        ),
        title: const Text(
          'Reset Password',
          style: TextStyle(color: Colors.white),
        ),
      ),
      
      body: Column(
        children: [
          const Spacer(), // Pushes the input fields to the center
          // Center the input fields
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min, // Use minimum size for the column
              crossAxisAlignment: CrossAxisAlignment.start, // Align children to the start (left)
              children: <Widget>[
                const SizedBox(height: 30.0),

                // New Password Label
                const Text(
                  'New Password',
                  style: TextStyle(
                    color: Color.fromARGB(255, 127, 126, 126),
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 5.0),

                // New Password TextField
                TextField(
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[800],
                    contentPadding: const EdgeInsets.symmetric(vertical: 10.0), // Adjust height
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  obscureText: true, // Hide password
                  textAlignVertical: TextAlignVertical.center,
                ),
                const SizedBox(height: 20.0),

                // Confirm New Password Label
                const Text(
                  'Confirm New Password',
                  style: TextStyle(
                    color: Color.fromARGB(255, 127, 126, 126),
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 5.0),

                // Confirm New Password TextField
                TextField(
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[800],
                    contentPadding: const EdgeInsets.symmetric(vertical: 10.0), // Adjust height
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  obscureText: true, // Hide password
                  textAlignVertical: TextAlignVertical.center,
                ),
                const SizedBox(height: 30.0),
              ],
            ),
          ),
          const Spacer(), // Pushes the button to the bottom
          // Confirm Button at the bottom
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0), // Padding above and below the button
            child: ElevatedButton(
              onPressed: () {
                // Add your reset password logic here
                print("Password reset confirmed");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD6B560), // Background color of the button
                padding: const EdgeInsets.symmetric(
                  horizontal: 120.0,
                  vertical: 12.0,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: const Text(
                'Confirm',
                style: TextStyle(color: Colors.black, fontSize: 18.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
