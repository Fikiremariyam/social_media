import 'package:flutter/material.dart';

class ImagePost extends StatelessWidget {
  final String text ;
  final String url ;

  const ImagePost({super.key,required this.text, required this.url});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom:8.0
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: Colors.indigo.shade100,
      ),
      padding: const EdgeInsets.all(12.0),
    
      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            url,
            fit: BoxFit.cover
            ,),
            const SizedBox(height: 2.0,),
            Text(
              text,
            )
        ],
      ),
    );
  }
}