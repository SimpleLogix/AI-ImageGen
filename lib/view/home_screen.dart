import 'package:ai_image_gen/services/open_ai_api.dart';
import 'package:ai_image_gen/view/image_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final openApi = Get.put(
    OpenApi(token: "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"),
    permanent: true,
  );
  List<String> urls = [""];
  bool isLoading = false;
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          //? Title
          const Flexible(
              child: Center(
                  child: Text(
            "Open AI Image Generation",
            style: TextStyle(
              fontSize: 32,
              color: Colors.black87,
            ),
          ))),
          Flexible(flex: 3, child: Img(urls: urls)),
          SizedBox(
            height: 75,
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : const SizedBox.shrink(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100),
            child: TextField(
                maxLines: 3,
                controller: controller,
                decoration:
                    const InputDecoration(border: OutlineInputBorder())),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 25, 0, 50),
              child: ElevatedButton(
                onPressed: () async {
                  if (controller.text.toString().isNotEmpty) {
                    setState(() {
                      isLoading = true;
                    });
                    urls =
                        await openApi.generateImage(controller.text.toString());
                    setState(() {
                      urls = urls;
                      isLoading = false;
                    });
                  }
                },
                child: const Text("Generate"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
