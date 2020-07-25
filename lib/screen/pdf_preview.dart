import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mailer/flutter_mailer.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';
import 'package:foglio_ore/model/stato.dart';
import 'package:foglio_ore/utils/constants.dart';
import 'package:foglio_ore/widget/circle_icon_button.dart';
import 'package:foglio_ore/widget/custom_pdf_viewer.dart';
import 'package:provider/provider.dart';

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
          CircleIconButton(
            icon: Icons.send,
            onPressed: () async {
              DateTime data =
                  Provider.of<DateTimeAppState>(context, listen: false)
                      .dataCorrente;

              final MailOptions mailOptions = MailOptions(
                subject:
                    'Invio foglio ore mese ${MESI[data.month - 1]} ${data.year}',
                body: '''
Come da oggetto invio foglio ore relativo al mese di ${MESI[data.month - 1]} ${data.year}.

Cordiali Saluti,
Antonella Rossi''',
                recipients: ['gsasrl2@gmail.com'],
                isHTML: false,
                attachments: [
                  widget.pdfFile.path,
                ],
              );

              try {
                await FlutterMailer.send(mailOptions);
                Navigator.of(context).pop(true);
              } on PlatformException catch (_) {
                Navigator.of(context).pop(false);
              }
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
