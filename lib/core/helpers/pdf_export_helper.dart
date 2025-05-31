import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:path_provider/path_provider.dart';
import 'package:masareefi/features/add_expense/data/models/expense_model.dart';

class PdfExportHelper {
  static Future<File> generateExpenseReport(List<ExpenseModel> expenses) async {
    final pdf = pw.Document();

    // Load the Cairo Arabic font from assets
    final fontData = await rootBundle.load('assets/fonts/cairo.ttf');
    final ttf = pw.Font.ttf(fontData);

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return pw.Directionality(
            textDirection: pw.TextDirection.rtl,
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  'تقرير المصروفات',
                  style: pw.TextStyle(
                    font: ttf,
                    fontSize: 24,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 16),
                pw.Table.fromTextArray(
                  headers: [
                    'التاريخ',
                    'المبلغ',
                    'العملة',
                    'بالدولار',
                    'التصنيف'
                  ],
                  data: expenses.map((e) {
                    return [
                      e.date.split('T').first,
                      e.amount.toStringAsFixed(2),
                      e.currency,
                      e.convertedAmount.toStringAsFixed(2),
                      e.categoryId.toString(),
                    ];
                  }).toList(),
                  headerStyle: pw.TextStyle(
                    font: ttf,
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 12,
                  ),
                  cellStyle: pw.TextStyle(
                    font: ttf,
                    fontSize: 11,
                  ),
                  cellAlignment: pw.Alignment.centerRight,
                  border: pw.TableBorder.all(width: 0.5),
                ),
              ],
            ),
          );
        },
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File("${output.path}/expense_report.pdf");
    await file.writeAsBytes(await pdf.save());
    return file;
  }
}
