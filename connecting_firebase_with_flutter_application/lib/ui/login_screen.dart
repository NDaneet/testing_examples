import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/user_dao.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userDAO = Provider.of<UserDAO>(context, listen: false);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildTextField(),
              ..._buildButtons(userDAO),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField() {
    return Form(
      key: _formkey,
      child: Column(
        children: [
          TextFormField(
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Email Required';
              }
              return null;
            },
            controller: _emailController,
            autofocus: false,
            // TODO: Newly added
            keyboardType: TextInputType.emailAddress,
            textCapitalization: TextCapitalization.none,
            autocorrect: false,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Email",
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          TextFormField(
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Email Required';
              }
              return null;
            },
            obscureText: true,
            obscuringCharacter: "*",
            controller: _passwordController,
            //TODO: Check difference between visible and non-visible
            keyboardType: TextInputType.visiblePassword,
            textCapitalization: TextCapitalization.none,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Password",
            ),
          )
        ],
      ),
    );
  }

  List<Widget> _buildButtons(UserDAO userDAO) {
    return [
      const SizedBox(
        height: 10.0,
      ),
      SizedBox(
        width: 160,
        child: ElevatedButton(
          onPressed: () async {
            final errorMessage = await userDAO.login(
              _emailController.text,
              _passwordController.text,
            );
            if (errorMessage != null) {
              if (!mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(errorMessage),
                duration: const Duration(milliseconds: 600),
              ));
            }
          },
          child: const Text(
            "Login",
          ),
        ),
      ),
      const SizedBox(
        height: 11.0,
      ),
      SizedBox(
        width: 160,
        child: ElevatedButton(
          onPressed: () async {
            final errorMessage = await userDAO.signup(
              _emailController.text,
              _passwordController.text,
            );
            if (errorMessage != null) {
              if (!mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(errorMessage),
                duration: const Duration(milliseconds: 600),
              ));
            }
          },
          child: const Text(
            "Signup",
          ),
        ),
      )
    ];
  }
}
