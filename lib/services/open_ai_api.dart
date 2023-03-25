import 'package:chat_gpt_api/chat_gpt.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OpenApi extends GetxController {
  late String token;
  late ChatGPT chatGpt;

  OpenApi({required this.token}) {
    chatGpt = ChatGPT.builder(token: token);
  }

  /// Returns urls
  Future<List<String>> generateImage(String prompt) async {
    final response = await chatGpt.generateImage(
        request: ImageRequest(
      prompt: prompt,
      n: 5,
      size: "1024x1024",
    ));
    // convert from ImageList obj to list of urls
    List<String> urls = [];
    if (response != null && response.data != null) {
      for (ImageList img in response.data!) {
        if (img.url != null) {
          urls.add(img.url!);
        }
      }
    }
    return urls;
  }

  void promptComplete(String prompt) async {
    Completion? completion = await chatGpt.textCompletion(
      request: CompletionRequest(
        prompt: prompt,
        maxTokens: 256,
      ),
    );
    debugPrint(completion!.choices!.first.text.toString());
  }
}
