import 'package:flutter/material.dart';

class NoConnectionWidget extends StatelessWidget {
  final VoidCallback onPressed;
  const NoConnectionWidget({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
           'No internet connection!',
            style: TextStyle(
                fontSize: 24, color: Colors.black, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 8,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Please, check your internet connection and try again later',
              style: TextStyle(fontSize: 16, color: Colors.black87),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          OutlinedButton(
            onPressed: onPressed,
            child: const Text(
              'Try again',
            ),
          )
        ],
      ),
    );
  }
}
