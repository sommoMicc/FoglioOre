import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mailer/flutter_mailer.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';
import 'package:foglio_ore/widget/custom_pdf_viewer.dart';

class PDFPreview extends StatefulWidget {
  final File pdfFile;

  PDFPreview(this.pdfFile);

  @override
  _PDFPreviewState createState() => _PDFPreviewState();
}

class _PDFPreviewState extends State<PDFPreview> {
  bool _isLoading;
  PDFDocument document;

  @override
  void initState() {
    super.initState();
    _isLoading = true;

    loadFile();
  }

  void loadFile() async {
    document = await PDFDocument.fromFile(widget.pdfFile);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Anteprima"),
        actions: <Widget>[
          // action button
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () async {
              final MailOptions mailOptions = MailOptions(
                body: 'Foglio ore',
                subject: 'Oggetto foglio ore',
                recipients: ['gsasrl2@gmail.com'],
                isHTML: false,
                attachments: [
                  widget.pdfFile.path,
                ],
              );

              await FlutterMailer.send(mailOptions);
            },
          )
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : CustomPDFViewer(
              document: document,
              showPicker: false,
              showIndicator: false,
              showNavigation: false,
            ),
    );
  }
}
