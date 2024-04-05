import 'dart:io';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'global.dart';

Future<void> pdfMaking() async {
  final image = pw.MemoryImage(
    File("${g1.image}").readAsBytesSync(),
  );
  final pdf = pw.Document();
  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context)
        {
          return pw.Padding(
            padding: const pw.EdgeInsets.all(8.0),
            child: pw.Column(
              children: [
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                  children: [
                    pw.Column(
                      children: [
                        pw.Text(
                          "Name : ${g1.name}",
                          style:  pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        pw.Text(
                          "Name : ${g1.image}",
                          style:pw. TextStyle(
                            fontWeight:pw. FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        pw.Text(
                          "Name : ${g1.phone}",
                          style:  pw.TextStyle(
                            fontWeight:pw. FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    pw.ClipOval(
                      child: pw.Image(image,fit: pw.BoxFit.fill),

                    ),
                  ],
                ),
                 pw.Divider(color: PdfColors.grey, thickness: 2),
                 pw.Divider(color: PdfColors.grey, thickness: 2),
                pw. Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                  children: [
                    pw.Text(
                      "Product",
                      style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    pw.Text(
                      "Qty",
                      style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    pw.Text(
                      "Price",
                      style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                pw. Divider(color: PdfColors.grey, thickness: 2),
                pw.Divider(color: PdfColors.grey, thickness: 2),
                pw.Column(
                  children: [
                    pw.ListView.builder(
                      itemCount: g1.product.length,
                      itemBuilder: (context, index) {
                        return pw.Text("${g1.product[index].pName}");
                      },
                    ),
                  ],
                )
              ],
            ),
          );
        }
    ),

  );
  final file =File("Bill.pdf");
  await file.writeAsBytes(await pdf.save());
}
