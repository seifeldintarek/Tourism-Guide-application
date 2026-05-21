import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/Place.dart';
import 'package:flutter_application_1/screens/info/info.dart';

// ─────────────────────────────────────────────────────────────────────────────
//  PlaceCard  — card row in the saved places list
// ─────────────────────────────────────────────────────────────────────────────

class PlaceCard extends StatelessWidget {
  final Place  place;
  final double thumbSize;
  final double bodyFontSize;
  final double labelFontSize;
  final double smallGap;

  const PlaceCard({
    super.key,
    required this.place,
    required this.thumbSize,
    required this.bodyFontSize,
    required this.labelFontSize,
    required this.smallGap,
  });

  // "location, city" — matches what Place stores
  String get _subtitle => '${place.location} • ${place.city}';

  @override
  Widget build(BuildContext context) {
    return Material(
      color:        Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius:   BorderRadius.circular(16),
        splashColor:    const Color(0xFFE8E0D8),
        highlightColor: const Color(0xFFF0EBE5),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => Infoscreen(place: place)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: thumbSize * 0.15,
            vertical:   thumbSize * 0.15,
          ),
          child: Row(
            children: [
              // Thumbnail
              PlaceThumbnail(imageUrl: place.mainImage, size: thumbSize),

              SizedBox(width: thumbSize * 0.18),

              // Name + subtitle
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      place.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize:      bodyFontSize * 1.15,
                        fontWeight:    FontWeight.w700,
                        color:         const Color(0xFF1A1A1A),
                        height:        1.25,
                        letterSpacing: -0.1,
                      ),
                    ),
                    SizedBox(height: smallGap * 0.6),
                    Text(
                      _subtitle,
                      style: TextStyle(
                        fontSize:   labelFontSize,
                        fontWeight: FontWeight.w400,
                        color:      const Color(0xFF8A8582),
                        height:     1.3,
                      ),
                    ),
                  ],
                ),
              ),

              // Chevron
              Padding(
                padding: EdgeInsets.only(left: smallGap),
                child: Icon(
                  Icons.chevron_right_rounded,
                  color: const Color(0xFFBBB5AF),
                  size:  bodyFontSize * 1.6,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  PlaceThumbnail
// ─────────────────────────────────────────────────────────────────────────────

class PlaceThumbnail extends StatelessWidget {
  final String imageUrl;
  final double size;

  const PlaceThumbnail({
    super.key,
    required this.imageUrl,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(size * 0.18),
      child: SizedBox(
        width:  size,
        height: size,
        child: imageUrl.isNotEmpty
            ? Image.network(
                imageUrl,
                fit: BoxFit.cover,
                loadingBuilder: (_, child, progress) =>
                    progress == null ? child : _shimmer(),
                errorBuilder: (_, __, ___) => _fallback(),
              )
            : _fallback(),
      ),
    );
  }

  Widget _shimmer() => Container(
        color: const Color(0xFFE8E0D8),
        child: const Center(
          child: SizedBox(
            width:  16,
            height: 16,
            child:  CircularProgressIndicator(
              strokeWidth: 1.5,
              color:       Color(0xFFC4945A),
            ),
          ),
        ),
      );

  Widget _fallback() => Container(
        color: const Color(0xFFD4C5B5),
        child: Icon(
          Icons.place_rounded,
          color: Colors.white70,
          size:  size * 0.45,
        ),
      );
}

// ─────────────────────────────────────────────────────────────────────────────
//  EmptyPlacesView
// ─────────────────────────────────────────────────────────────────────────────

class EmptyPlacesView extends StatelessWidget {
  final double bodyFontSize;
  final double labelFontSize;

  const EmptyPlacesView({
    super.key,
    required this.bodyFontSize,
    required this.labelFontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.bookmark_border_rounded,
            size:  bodyFontSize * 4,
            color: const Color(0xFFCCC5BC),
          ),
          const SizedBox(height: 12),
          Text(
            'No saved places yet',
            style: TextStyle(
              fontSize:   bodyFontSize * 1.15,
              fontWeight: FontWeight.w600,
              color:      const Color(0xFF8A8582),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Places you save will appear here.',
            style: TextStyle(
              fontSize: labelFontSize,
              color:    const Color(0xFFAEA9A4),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  ErrorPlacesView
// ─────────────────────────────────────────────────────────────────────────────

class ErrorPlacesView extends StatelessWidget {
  final double bodyFontSize;
  final VoidCallback? onRetry;

  const ErrorPlacesView({
    super.key,
    required this.bodyFontSize,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.wifi_off_rounded,
            size:  bodyFontSize * 4,
            color: const Color(0xFFCCC5BC),
          ),
          const SizedBox(height: 12),
          Text(
            'Something went wrong',
            style: TextStyle(
              fontSize:   bodyFontSize * 1.15,
              fontWeight: FontWeight.w600,
              color:      const Color(0xFF8A8582),
            ),
          ),
          if (onRetry != null) ...[
            const SizedBox(height: 16),
            TextButton(
              onPressed: onRetry,
              child: Text(
                'Try again',
                style: TextStyle(fontSize: bodyFontSize),
              ),
            ),
          ],
        ],
      ),
    );
  }
}