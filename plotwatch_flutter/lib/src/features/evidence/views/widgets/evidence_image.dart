import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// A capture's photo or thumbnail, loaded through the page's
/// [EvidenceMediaBloc] (doc/04d M4-4).
class EvidenceImage extends StatefulWidget {
  const EvidenceImage({
    super.key,
    required this.projectId,
    required this.evidenceId,
    required this.variant,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
  });

  final int projectId;
  final int evidenceId;
  final MediaVariant variant;
  final double? width;
  final double? height;
  final BoxFit fit;

  @override
  State<EvidenceImage> createState() => _EvidenceImageState();
}

class _EvidenceImageState extends State<EvidenceImage> {
  late final _key = EvidenceMediaState.keyFor(
    widget.evidenceId,
    widget.variant,
  );

  @override
  void initState() {
    super.initState();
    context.read<EvidenceMediaBloc>().add(
      EvidenceMediaEvent.requested(
        projectId: widget.projectId,
        evidenceId: widget.evidenceId,
        variant: widget.variant,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocBuilder<EvidenceMediaBloc, EvidenceMediaState>(
      buildWhen: (previous, current) =>
          previous.images[_key] != current.images[_key] ||
          previous.failed.contains(_key) != current.failed.contains(_key),
      builder: (context, state) {
        final bytes = state.images[_key];
        if (bytes != null) {
          return Image.memory(
            bytes,
            width: widget.width,
            height: widget.height,
            fit: widget.fit,
            gaplessPlayback: true,
            semanticLabel: l10n.capturePhotoLabel,
          );
        }
        return Container(
          width: widget.width,
          height: widget.height,
          color: customColors.muted.withValues(alpha: .15),
          alignment: Alignment.center,
          child: state.failed.contains(_key)
              ? Icon(
                  Icons.broken_image_outlined,
                  color: customColors.muted,
                  semanticLabel: l10n.capturePhotoUnavailable,
                )
              : null,
        );
      },
    );
  }
}
