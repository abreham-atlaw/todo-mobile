import 'package:flutter/material.dart';
import 'package:todo/common/widgets/text/body.dart';
import 'package:todo/configs/ui_configs.dart';

class BannerWidget extends StatefulWidget {
  final Color color;
  final Widget child;
  final int? seconds;

  const BannerWidget({super.key, required this.color, required this.child, this.seconds});

  @override
  _BannerWidgetState createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  bool isVisible = true;

  @override
  void initState() {
    super.initState();
    if (widget.seconds != null) {
      Future.delayed(Duration(seconds: widget.seconds!), () {
        if (mounted) {
          setState(() {
            isVisible = false;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isVisible
        ? Container(
        padding: const EdgeInsets.all(SpacingConfigs.spacing3),
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(SpacingConfigs.spacing2),
        ),
        child: widget.child
    )
        : Container();
  }
}
