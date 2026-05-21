import 'package:flutter/material.dart';

class PlaceCardSkeletonList extends StatefulWidget {
  const PlaceCardSkeletonList({super.key});

  @override
  State<PlaceCardSkeletonList> createState() => _PlaceCardSkeletonListState();
}

class _PlaceCardSkeletonListState extends State<PlaceCardSkeletonList>
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
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: 4,
          separatorBuilder: (_, __) => SizedBox(width: width * .03),
          itemBuilder: (_, __) => _PlaceCardSkeleton(
            width: width,
            height: height,
            opacity: _animation.value,
          ),
        );
      },
    );
  }
}

class _PlaceCardSkeleton extends StatelessWidget {
  final double width;
  final double height;
  final double opacity;

  const _PlaceCardSkeleton({
    required this.width,
    required this.height,
    required this.opacity,
  });

  Widget _box({
    required double w,
    required double h,
    double radius = 8,
  }) {
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
    return Container(
      width: width * .6,
      decoration: BoxDecoration(
        color: const Color(0xFFEDE8E2),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image placeholder
          _box(w: width * .6, h: height * .28, radius: 14),

          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width * .03,
              vertical: height * .012,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title line
                _box(w: width * .35, h: height * .018),
                SizedBox(height: height * .008),
                // Subtitle line
                _box(w: width * .22, h: height * .013),
              ],
            ),
          ),
        ],
      ),
    );
  }
}