import 'package:flutter/material.dart';

class TelegramMessageBubble extends StatelessWidget {
  final String message;
  final bool isSentByMe;

  TelegramMessageBubble({required this.message, required this.isSentByMe});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: ClipPath(
        clipper: RoundedMessageClipper(isSentByMe: isSentByMe),
        child: Container(
          padding: const EdgeInsets.all(12),
          color: isSentByMe ? Colors.blue : Colors.grey[300],
          child: Text(
            message,
            style: TextStyle(
              color: isSentByMe ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}

class RoundedMessageClipper extends CustomClipper<Path> {
  final bool isSentByMe;

  RoundedMessageClipper({required this.isSentByMe});

  @override
  Path getClip(Size size) {
    double borderRadius = 16.0;
    double tailWidth = 10.0;
    double tailHeight = 12.0;

    Path path = Path();

    if (isSentByMe) {
      path.addRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(0, 0, size.width - tailWidth, size.height),
          topLeft: Radius.circular(borderRadius),
          bottomLeft: Radius.circular(borderRadius),
          topRight: Radius.circular(borderRadius)
        ),
      );

    
    } else {
      path.addRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(tailWidth, 0, size.width - tailWidth, size.height),
          topRight: Radius.circular(borderRadius),
          bottomRight: Radius.circular(borderRadius),
          
          topLeft: Radius.circular(borderRadius),
        ),
      );

      // Add the "tail" shape on the left bottom
      
    }

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
