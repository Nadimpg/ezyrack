import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CustomQrWidget extends StatelessWidget {

  final GlobalKey? globalKey;
  final String data;
  final String qrSerialNo;

  const CustomQrWidget({
    this.globalKey,
    this.data = "",
    required this.qrSerialNo,
    super.key
  });

  @override
  Widget build(BuildContext context) {

    return RepaintBoundary(
      key: globalKey,
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsetsDirectional.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(12)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: QrImageView(
                backgroundColor: Colors.white,
                data: data,
                version: QrVersions.auto,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              qrSerialNo,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Color(0xffE9E9E9),
                  fontSize: 18,
                  fontWeight: FontWeight.w700
              ),
            )
          ],
        ),
      ),
    );
  }
}
