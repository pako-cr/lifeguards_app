import 'package:flutter/material.dart';
import 'package:lifeguards_app/global/environment.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final Function onPressed;
  final bool enabled;

  const CustomButton({
    Key? key,
    required this.title,
    required this.onPressed,
    required this.enabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => {onPressed()},
      child: Container(
        width: double.infinity,
        height: 50,
        child: Center(
          child: Text(
            this.title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
