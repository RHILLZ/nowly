import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:nowly/Configs/configs.dart';
import 'package:path/path.dart';

class LegalView extends StatelessWidget {
  const LegalView({Key? key, required File file})
      : _file = file,
        super(key: key);

  final File _file;
  @override
  Widget build(BuildContext context) {
    final filename = basename(_file.path);
    return Scaffold(
      appBar: AppBar(
        title: Text(filename, style: k16BoldTS),
        centerTitle: true,
      ),
      body: PDFView(
        filePath: _file.path,
      ),
    );
  }
}
