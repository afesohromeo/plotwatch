// The demo project's receipt images (doc/04g step 7), drawn by us rather
// than taken from the web: made-up shops, no real tax or company numbers.
// Run with
//   flutter test --update-goldens tool/screenshots/receipts_test.dart
// and they are written to plotwatch_server/seed/receipts/.
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'harness.dart';

typedef _Line = (String item, String quantity, String amount);

class _Receipt {
  const _Receipt({
    required this.file,
    required this.shop,
    required this.address,
    required this.number,
    required this.date,
    required this.lines,
    required this.total,
    required this.paidBy,
  });

  final String file;
  final String shop;
  final String address;
  final String number;
  final String date;
  final List<_Line> lines;
  final String total;
  final String paidBy;
}

const _receipts = [
  _Receipt(
    file: 'receipt_excavator.png',
    shop: 'LOCATION ENGINS MVAN',
    address: 'Carrefour Mvan, Yaoundé · Tél. 6 99 00 00 00',
    number: 'Reçu N° 0412',
    date: '08/09/2026',
    lines: [
      ('Mini-pelle avec chauffeur', '3 j × 520 000', '1 560 000'),
      ('Transport aller-retour engin', '1', '90 000'),
    ],
    total: '1 650 000',
    paidBy: 'Payé en espèces',
  ),
  _Receipt(
    file: 'receipt_cement.png',
    shop: 'QUINCAILLERIE DU CENTRE',
    address: 'Mvog-Mbi, Yaoundé · Tél. 6 77 00 00 00',
    number: 'Facture N° 2026-1187',
    date: '17/09/2026',
    lines: [
      ('Ciment 42,5 sac 50 kg', '700 × 6 500', '4 550 000'),
    ],
    total: '4 550 000',
    paidBy: 'Payé par Mobile Money',
  ),
  _Receipt(
    file: 'receipt_rebar.png',
    shop: 'FERS ET ACIERS ETOUDI',
    address: 'Etoudi, Yaoundé · Tél. 6 55 00 00 00',
    number: 'Facture N° FA-3306',
    date: '20/09/2026',
    lines: [
      ('Fer HA10 barre 12 m', '200 × 9 500', '1 900 000'),
      ('Fer HA12 barre 12 m', '250 × 13 600', '3 400 000'),
      ('Fer HA14 barre 12 m', '130 × 20 000', '2 600 000'),
    ],
    total: '7 900 000',
    paidBy: 'Payé par virement',
  ),
];

void main() {
  setUpAll(loadFonts);

  for (final receipt in _receipts) {
    testWidgets('receipt ${receipt.file}', (tester) async {
      tester.view.physicalSize = const Size(640, 900);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      final root = GlobalKey();
      await tester.pumpWidget(
        MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(fontFamily: 'Manrope'),
          home: RepaintBoundary(
            key: root,
            child: Material(child: _ReceiptPaper(receipt)),
          ),
        ),
      );
      await tester.pump();
      await expectLater(
        find.byKey(root),
        matchesGoldenFile(
          '../../../plotwatch_server/seed/receipts/${receipt.file}',
        ),
      );
    });
  }
}

class _ReceiptPaper extends StatelessWidget {
  const _ReceiptPaper(this.receipt);

  final _Receipt receipt;

  @override
  Widget build(BuildContext context) {
    const ink = Color(0xFF2A2A2A);
    const muted = Color(0xFF6B6B6B);
    TextStyle style(double size, {FontWeight weight = FontWeight.w500}) =>
        TextStyle(
          fontFamily: 'Manrope',
          fontSize: size,
          color: ink,
          fontWeight: weight,
          height: 1.4,
        );
    Widget dashes() => Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        '- ' * 40,
        maxLines: 1,
        overflow: TextOverflow.clip,
        style: style(12).copyWith(color: muted),
      ),
    );

    return ColoredBox(
      // A wooden table under the paper, as when a receipt is photographed.
      color: const Color(0xFF8B6A4E),
      child: Center(
        child: Transform.rotate(
          angle: -0.015,
          child: Container(
            width: 470,
            padding: const EdgeInsets.fromLTRB(28, 30, 28, 34),
            decoration: const BoxDecoration(
              color: Color(0xFFFBFAF6),
              boxShadow: [
                BoxShadow(
                  color: Color(0x55000000),
                  blurRadius: 18,
                  offset: Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  receipt.shop,
                  textAlign: TextAlign.center,
                  style: style(22, weight: FontWeight.w800),
                ),
                Text(
                  receipt.address,
                  textAlign: TextAlign.center,
                  style: style(12).copyWith(color: muted),
                ),
                dashes(),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        receipt.number,
                        style: style(14, weight: FontWeight.w700),
                      ),
                    ),
                    Text(receipt.date, style: style(14)),
                  ],
                ),
                Text(
                  'Client : Chantier Afesoh Residence, Odza',
                  style: style(13),
                ),
                dashes(),
                for (final (item, quantity, amount) in receipt.lines)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item, style: style(14)),
                              Text(
                                quantity,
                                style: style(12).copyWith(color: muted),
                              ),
                            ],
                          ),
                        ),
                        Text(amount, style: style(14)),
                      ],
                    ),
                  ),
                dashes(),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'TOTAL FCFA',
                        style: style(18, weight: FontWeight.w800),
                      ),
                    ),
                    Text(
                      receipt.total,
                      style: style(18, weight: FontWeight.w800),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(receipt.paidBy, style: style(13)),
                const SizedBox(height: 18),
                Text(
                  'Merci pour votre confiance',
                  textAlign: TextAlign.center,
                  style: style(13, weight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
