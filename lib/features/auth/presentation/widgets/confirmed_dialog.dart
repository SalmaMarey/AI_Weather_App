import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennis_app/features/auth/presentation/controllers/auth_bloc/auth_bloc.dart';
import 'package:tennis_app/features/auth/presentation/controllers/auth_bloc/auth_event.dart';

void showConfirmationDialog({
  required BuildContext context,
  required TextEditingController fullNameController,
  required TextEditingController emailController,
  required TextEditingController passwordController,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Stack(
        children: [
          Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Container(
              height: 150,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 210, 210, 220),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 40.0),
                  const Text(
                    'Are You Sure?',
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 8, 36, 59),
                    ),
                  ),
                  const SizedBox(height: 29),
                  ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<AuthBloc>(context).add(
                        SignUpButtonPressed(
                          fullName: fullNameController.text,
                          email: emailController.text,
                          password: passwordController.text,
                        ),
                      );
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20)),
                      ),
                      minimumSize: const Size(400, 50),
                    ),
                    child: const Text(
                      'Ok',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: Color.fromARGB(255, 8, 36, 59),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 160,
            top: 250,
            child: Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color.fromARGB(255, 8, 36, 59),
                  border: Border.all(color: Colors.white, width: 7)),
              child: const Icon(
                Icons.check_box,
                size: 40.0,
                color: Colors.white,
              ),
            ),
          ),
        ],
      );
    },
  );
}
