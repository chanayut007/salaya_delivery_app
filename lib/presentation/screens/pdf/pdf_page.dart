import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:salaya_delivery_app/data/models/response/order.dart';
import 'package:salaya_delivery_app/presentation/screens/pdf/pdf_api.dart';
import 'package:salaya_delivery_app/presentation/utils/date_format_extension.dart';
import 'package:salaya_delivery_app/presentation/utils/number_format_extension.dart';

class PdfOrderApi {

  static Future<String> generate(Order order) async {
    final pdf = Document();

    final imageLogo =
    (await rootBundle.load("assets/images/logo.png")).buffer.asUint8List();

    final regularFont = await rootBundle.load('assets/fonts/Prompt-Regular.ttf');
    final regular = Font.ttf(regularFont);
    final boldFont = await rootBundle.load('assets/fonts/Prompt-SemiBold.ttf');
    final bold = Font.ttf(boldFont);

    pdf.addPage(MultiPage(
      build: (context) => [
        buildLogo(imageLogo),
        SizedBox(height: 1 * PdfPageFormat.cm),
        buildInformation(order),
        SizedBox(height: 1 * PdfPageFormat.cm),
        buildOrder(order),
        Divider(),
        buildTotal(order)
      ],
      theme: ThemeData(
        defaultTextStyle: TextStyle(font: regular),
        paragraphStyle: TextStyle(font: bold),
        header1: TextStyle(font: bold),
        tableHeader: TextStyle(font: bold),
        tableCell: TextStyle(font: regular)
      )
    ));

    String fileName = order.orderNo + ".pdf";
    return await PdfApi.saveDocument(name: fileName, pdf: pdf);
  }

  static Widget buildLogo(Uint8List image) {
    return Center(
        child: Image(
            MemoryImage(image),
            width: 250
        )
    );
  }

  static Widget buildInformation(Order order) => Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: buildCustomerName(order),
                    ),
                    SizedBox(height: 1 * PdfPageFormat.mm),
                    Align(
                      alignment: Alignment.topLeft,
                      child: buildCustomerPhone(order),
                    ),
                  ],
                )
              ),
              SizedBox(width: 1 * PdfPageFormat.cm),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Align(
                      child: buildOrderNo(order),
                      alignment: Alignment.topRight
                    ),
                    SizedBox(height: 1 * PdfPageFormat.mm),
                    Align(
                      alignment: Alignment.topRight,
                      child: buildCheckoutDate(order)
                    )
                  ]
                )
              )
            ]
        ),
        SizedBox(height: 2 * PdfPageFormat.cm),
        buildAddress(order),
        SizedBox(height: 1 * PdfPageFormat.mm),
        buildShippingType(order),
        SizedBox(height: 1 * PdfPageFormat.mm),
        buildBranchShipping(order),
        SizedBox(height: 1 * PdfPageFormat.mm),
        (order.comment != null) ? buildComment(order) : SizedBox(height: 1 * PdfPageFormat.mm),
      ]
  );

  static Widget buildCustomerName(Order order) => buildText(
    title: 'ชื่อ-สกุล',
    value: order.customerName,
  );

  static Widget buildCustomerPhone(Order order) => buildText(
    title: 'เบอร์โทรศัพท์',
    value: order.customerPhone,
  );

  static Widget buildAddress(Order order) => buildText(
    title: 'ที่อยู่',
    value: order.address,
    fontSize: 10
  );

  static Widget buildShippingType(Order order) => buildText(
    title: 'รูปแบบจัดส่ง',
    value: order.shipTo,
  );

  static Widget buildBranchShipping(Order order) => buildText(
    title: 'สาขา',
    value: order.branchShipping,
  );

  static Widget buildOrderNo(Order order) => buildText(
    title: 'หมายเลขคำสั่งซื้อ',
    value: order.orderNo,
    fontSize: 10
  );

  static Widget buildCheckoutDate(Order order) => buildText(
    title: 'วันที่ซื้อ',
    value: generateDateFormat(order.date),
  );

  static Widget buildComment(Order order) => buildText(
    title: 'หมายเหตุ',
    value: order.comment!,
    fontSize: 12
  );

  static buildText({
    required String title,
    required String value,
    double fontSize = 12
  }) {

    return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$title:', style: const TextStyle(fontSize: 14)),
          SizedBox(width: 0.5 * PdfPageFormat.cm),
          Expanded(child: Text(value, style: TextStyle(fontSize: fontSize), maxLines: 3))
        ]
    );
  }

  static buildTextTotal({
    required String title,
    required String value,
    double width = double.infinity,
    TextStyle? titleStyle,
    bool unite = false
  }) {
    final style = titleStyle ?? const TextStyle(fontSize: 14);

    return Container(
        width: width,
        child: Row(
            children: [
              Expanded(child: Text(title)),
              Text(value, style: unite ? style : null)
            ]
        )
    );

  }

  static Widget buildOrder(Order order) {

    final headers = [
      'รายละเอียด',
      'จำนวน',
      'ราคาต่อชิ้น',
      'ทั้งหมด'
    ];

    List<List<String>> data = order.items.map((item) {
      final total = item.pricePerUnit * item.qty;

      return [
        item.itemName,
        '${item.qty}',
        '${item.pricePerUnit}',
        generateCurrencyFormat(total)
      ];
    }).toList();

    return Table.fromTextArray(
        headers: headers,
        data: data,
        border: null,
        // headerStyle: TextStyle(fontWeight: FontWeight.bold),
        headerDecoration: const BoxDecoration(color: PdfColors.grey300),
        cellHeight: 30,
        cellAlignments: {
          0: Alignment.centerLeft,
          1: Alignment.centerRight,
          2: Alignment.centerRight,
          3: Alignment.centerRight,
          4: Alignment.centerRight,
          5: Alignment.centerRight
        }
    );
  }

  static Widget buildTotal(Order order) {
    final netTotal = order.items
        .map((item) => item.pricePerUnit * item.qty)
        .reduce((item1, item2) => item1 + item2);

    double deliveryPrice = 10.00;
    double total = netTotal + deliveryPrice;

    return Container(
        alignment: Alignment.centerRight,
        child: Row(
            children: [
              Spacer(flex: 6),
              Expanded(
                  flex: 4,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildTextTotal(
                            title: 'ยอดรวมสินค้า',
                            value: generateCurrencyFormat(netTotal),
                            unite: true
                        ),
                        buildTextTotal(
                            title: 'ค่าจัดส่ง',
                            value: generateCurrencyFormat(deliveryPrice),
                            unite: true
                        ),
                        Divider(),
                        buildTextTotal(
                            title: 'ยอดรวมทั้งหมด',
                            titleStyle: TextStyle(
                                fontSize: 14,
                            ),
                            value: generateCurrencyFormat(total),
                            unite: true
                        ),
                        SizedBox(height: 2 * PdfPageFormat.mm),
                        Container(height: 1, color: PdfColors.grey400),
                        SizedBox(height: 0.5 * PdfPageFormat.mm),
                        Container(height: 1, color: PdfColors.grey400),

                      ]
                  )
              )
            ]
        )
    );
  }

}