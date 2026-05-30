import 'package:flutter/material.dart';

class SavedPlacesSkeletonList extends StatefulWidget {
  const SavedPlacesSkeletonList({super.key});

  @override
  State<SavedPlacesSkeletonList> createState() => _SavedPlacesSkeletonListState();
}

class _SavedPlacesSkeletonListState extends State<SavedPlacesSkeletonList>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width  = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    final double hPadding = width * 0.05;
    final double smallGap = height * 0.01;

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, _) {
        return ListView.separated(
          shrinkWrap: true,                           // add this
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: hPadding),
          itemCount: 6,
          separatorBuilder: (_, __) => SizedBox(height: smallGap * 1.2),
          itemBuilder: (_, __) => _SavedCardSkeleton(
            width: width,
            height: height,
            opacity: _animation.value,
          ),
        );
      },
    );
  }
}

class _SavedCardSkeleton extends StatelessWidget {
  final double width;
  final double height;
  final double opacity;

  const _SavedCardSkeleton({
    required this.width,
    required this.height,
    required this.opacity,
  });

  Widget _box({required double w, required double h, double radius = 8}) {
    return Opacity(
      opacity: opacity,
      child: Container(
        width: w,
        height: h,
        decoration: BoxDecoration(
          color: const Color(0xFFD4C5B5),
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double thumbSize = width * 0.18;
    final double smallGap  = height * 0.01;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: thumbSize * 0.15,
        vertical:   thumbSize * 0.15,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          // Thumbnail placeholder
          _box(w: thumbSize, h: thumbSize, radius: thumbSize * 0.18),

          SizedBox(width: thumbSize * 0.18),

          // Text lines
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _box(w: width * 0.38, h: height * 0.018),
                SizedBox(height: smallGap * 0.6),
                _box(w: width * 0.25, h: height * 0.013),
              ],
            ),
          ),

          // Chevron placeholder
          Padding(
            padding: EdgeInsets.symmetric(horizontal: smallGap),
            child: _box(w: width * 0.04, h: height * 0.025, radius: 4),
          ),
        ],
      ),
    );
  }
}