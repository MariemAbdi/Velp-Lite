import 'package:flutter/material.dart';

class PetImage extends StatelessWidget {
  const PetImage(
      {super.key, required this.petImageUrl, required this.imageHeight});

  final String petImageUrl;
  final double imageHeight;
  @override
  Widget build(BuildContext context) {
    return Image.network(
      petImageUrl,
      height: imageHeight,
      width: double.infinity,
      fit: BoxFit.cover,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return SizedBox(
            height: imageHeight,
            width: double.infinity,
            child: Center(child: CircularProgressIndicator()));
      },
      errorBuilder: (context, error, stackTrace) => Container(
        height: imageHeight,
        width: double.infinity,
        color: Colors.grey[300],
        child: Icon(Icons.error, color: Colors.red),
      ),
    );
  }
}
