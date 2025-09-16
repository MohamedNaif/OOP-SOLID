import 'package:flutter/material.dart';

// class ContentItem {
//   String type; // e.g., "text", "image" ,'video', 'audio'
//   String data;
//   ContentItem(this.type, this.data);
//   Widget build(BuildContext context) {
//     if (type == 'text') {
//       return Text(data);
//     } else if (type == 'image') {
//       return Image.network(data);
//     }
    
   
//     return Container();
//   }
// }

// class ContentDisplay extends StatelessWidget {
//   final List<ContentItem> items;
//   const ContentDisplay(this.items, {super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: items.map((item) => item.build(context)).toList(),
//     );
//   }
// }


// // ? solution 

abstract class ContentItem {
  Widget build(BuildContext context);
}

class TextItem extends ContentItem {
  final String text;
  TextItem(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(text);
  }
}

class ImageItem extends ContentItem {
  final String url;
  ImageItem(this.url);

  @override

  Widget build(BuildContext context) {
    return Image.network(url);
  }
}

class VideoItem extends ContentItem {
  final String videoUrl;
  VideoItem(this.videoUrl);

  @override
  Widget build(BuildContext context) {
    // Example placeholder, you could use video_player or chewie
    return Container(
      color: Colors.black,
      height: 200,
      alignment: Alignment.center,
      child: Text(
        "Video: $videoUrl",
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}

class ContentDisplay extends StatelessWidget {
  final List<ContentItem> items;
  const ContentDisplay(this.items, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: items.map((item) => item.build(context)).toList(),
    );
  }
}