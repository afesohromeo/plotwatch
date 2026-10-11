import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// Takes the receipt photo with the phone's camera, no gallery (doc/04f
/// M6-5 a): not a site capture, so no location checks. Closes with the
/// JPEG bytes, or nothing when left.
class ReceiptCameraPage extends StatefulWidget {
  const ReceiptCameraPage({super.key, required this.cameraProvider});

  final CameraProvider cameraProvider;

  static const shutterKey = Key('receipt.shutter');

  /// Opens the camera over the current page.
  static Future<Uint8List?> open(
    BuildContext context, {
    CameraProvider? cameraProvider,
  }) => Navigator.of(context).push<Uint8List>(
    MaterialPageRoute(
      fullscreenDialog: true,
      builder: (_) =>
          ReceiptCameraPage(cameraProvider: cameraProvider ?? CameraProvider()),
    ),
  );

  @override
  State<ReceiptCameraPage> createState() => _ReceiptCameraPageState();
}

class _ReceiptCameraPageState extends State<ReceiptCameraPage> {
  CameraAccess? _access;
  bool _taking = false;

  @override
  void initState() {
    super.initState();
    widget.cameraProvider.open().then((access) {
      if (mounted) setState(() => _access = access);
    });
  }

  @override
  void dispose() {
    widget.cameraProvider.close();
    super.dispose();
  }

  Future<void> _take() async {
    setState(() => _taking = true);
    try {
      final bytes = await widget.cameraProvider.takePicture();
      if (mounted) Navigator.of(context).pop(bytes);
    } catch (_) {
      if (mounted) setState(() => _taking = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: customColors.ink,
      appBar: AppBar(
        backgroundColor: customColors.ink,
        foregroundColor: customColors.onPrimary,
        title: Text(l10n.receiptCameraTitle),
      ),
      body: switch (_access) {
        null => const Center(child: CircularProgressIndicator()),
        CameraAccess.ready => Column(
          children: [
            Expanded(child: Center(child: widget.cameraProvider.preview())),
            SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: FilledButton.icon(
                  key: ReceiptCameraPage.shutterKey,
                  style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(56),
                    backgroundColor: customColors.surfaceWhite,
                    foregroundColor: customColors.ink,
                  ),
                  onPressed: _taking ? null : _take,
                  icon: const Icon(Icons.photo_camera_rounded),
                  label: Text(l10n.receiptShutter),
                ),
              ),
            ),
          ],
        ),
        CameraAccess.denied => _Message(
          text: l10n.cameraDenied,
          action: l10n.openSettings,
          onPressed: widget.cameraProvider.openSettings,
        ),
        CameraAccess.unavailable => _Message(text: l10n.cameraUnavailable),
      },
    );
  }
}

class _Message extends StatelessWidget {
  const _Message({required this.text, this.action, this.onPressed});

  final String text;
  final String? action;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              textAlign: TextAlign.center,
              style: context.textTheme.bodyLarge?.copyWith(
                color: customColors.onPrimary,
              ),
            ),
            if (action != null) ...[
              const Gap.vertical(height: AppSpacing.md),
              OutlinedButton(onPressed: onPressed, child: Text(action!)),
            ],
          ],
        ),
      ),
    );
  }
}
