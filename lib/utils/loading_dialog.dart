import 'package:flutter/material.dart';

class LoadingDialog {
  static void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) {
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        );
      },
    );
  }
}
