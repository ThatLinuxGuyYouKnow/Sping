import 'package:flutter/material.dart';

Future<void> ConfirmDownloadDialog(BuildContext context) async {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return _AnimatedSuccessDialog();
    },
  );
}

class _AnimatedSuccessDialog extends StatefulWidget {
  @override
  _AnimatedSuccessDialogState createState() => _AnimatedSuccessDialogState();
}

class _AnimatedSuccessDialogState extends State<_AnimatedSuccessDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 600),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );

    _controller.forward();

    Future.delayed(Duration(milliseconds: 1500), () {
      if (mounted && Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        height: 80,
        width: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 48,
            ),
          ),
        ),
      ),
    );
  }
}
