import 'package:ai_image_gen/services/open_ai_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transparent_image/transparent_image.dart';

class Img extends StatefulWidget {
  final List<String> urls;
  const Img({super.key, required this.urls});

  @override
  State<Img> createState() => _ImgState();
}

class _ImgState extends State<Img> {
  late List<FadeInImage> images;
  final openApi = Get.find<OpenApi>();
  int currentIdx = 0;
  @override
  Widget build(BuildContext context) {
    debugPrint(currentIdx.toString());
    bool initialized = false;
    if (widget.urls[currentIdx] == "") {
      initialized = false;
    } else {
      initialized = true;
      // set images widgets from urls
      images = List.generate(
          widget.urls.length,
          (index) => FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: widget.urls[index],
              ));
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
            onPressed: () {
              setState(() {
                // if prev index is negative; set to last in list
                if (currentIdx - 1 < 0) {
                  currentIdx = widget.urls.length - 1;
                } else {
                  currentIdx += 1;
                }
              });
            },
            child: Text("<-"),
            style: ElevatedButton.styleFrom(
                backgroundColor: initialized ? Colors.amber : Colors.grey[400],
                enabledMouseCursor: initialized ? null : MouseCursor.defer)),
        AspectRatio(
            aspectRatio: 1,
            // if initialized with data; show images that were generated and preloaded
            child: (initialized) ? images[currentIdx] : const Placeholder()),
        ElevatedButton(
            onPressed: () {
              setState(() {
                // if next index is greater than the last; reset idx
                if (currentIdx + 1 == widget.urls.length) {
                  currentIdx = 0;
                } else {
                  currentIdx += 1;
                }
              });
            },
            child: Text("->"),
            style: ElevatedButton.styleFrom(
                backgroundColor: initialized ? Colors.amber : Colors.grey[400],
                enabledMouseCursor: initialized ? null : MouseCursor.defer)),
      ],
    );
  }
}
