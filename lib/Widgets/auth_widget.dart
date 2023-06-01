import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheetsense/Provider/auth_provider.dart';

class AuthWidget extends StatefulWidget {
  const AuthWidget({
    super.key,
    required this.titletext,
    required this.buttonText,
    required this.onPressed,
  });

  final String titletext;
  final String buttonText;
  //late final String email;
  //final String password;
  final VoidCallback onPressed;

  @override
  State<AuthWidget> createState() => _AuthWidgetState();
}

class _AuthWidgetState extends State<AuthWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(widget.titletext,
            style: const TextStyle(
              fontSize: 20,
            )),
        SizedBox(
            width: 300,
            child: Column(
              children: [
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  textCapitalization: TextCapitalization.none,
                  cursorColor: Colors.transparent,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(),
                      hintText: 'Email'),
                  style: const TextStyle(
                    decoration: TextDecoration.none,
                    decorationColor: Colors.transparent,
                  ),
                  onChanged: (value) async {
                    Provider.of<AuthProvider>(context, listen: false)
                        .updateEmail(value);
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                TextField(
                  cursorColor: Colors.transparent,
                  obscureText: true,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.password),
                      border: OutlineInputBorder(),
                      hintText: 'Password'),
                  style: const TextStyle(decoration: TextDecoration.none),
                  onChanged: (value) {
                    Provider.of<AuthProvider>(context, listen: false)
                        .updatePassword(value);
                  },
                ),
              ],
            )),
        SizedBox(
          width: 150,
          child: FloatingActionButton(
            onPressed: widget.onPressed,
            child: Text(
              widget.buttonText,
              style: const TextStyle(
                fontFamily: 'Inter',
              ),
            ),
          ),
        )
      ],
    );
  }
}
