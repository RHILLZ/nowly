import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nowly/Configs/configs.dart';

void showValidationDialog(List<String> sections) {
  Get.defaultDialog(
      title: '', // 'Oops.! 😥',
      titleStyle: const TextStyle(fontSize: 0),
      content: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        const Text(
          'Ooops...! 😥',
          style: k16BoldTS,
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          'Please complete below sections',
          style: k16BoldTS,
        ),
        const SizedBox(
          height: 8,
        ),
        ...List.generate(
            sections.length,
            (index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.brightness_1,
                        color: kGray.withOpacity(0.2),
                        size: 10,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(sections[index])
                    ],
                  ),
                )),
        const SizedBox(
          height: 10,
        ),
        OutlinedButton(
            onPressed: () {
              Get.back();
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text('Okay.'),
            ))
      ]),
      radius: 10.0);
}
