import 'package:flutter/material.dart';

class MatSliverAppBar extends StatelessWidget {
  const MatSliverAppBar({
    Key? key,
    this.actions,
    this.automaticallyImplyLeading = true,
    this.centerTitle = false,
    this.leading,
    required this.text,
  }) : super(key: key);

  final List<Widget>? actions;
  final bool automaticallyImplyLeading;
  final bool centerTitle;
  final Widget? leading;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      forceElevated: true,
      expandedHeight: 120,
      pinned: true,
      automaticallyImplyLeading: automaticallyImplyLeading,
      leading: leading,
      actions: actions,
      flexibleSpace: FlexibleSpaceBar(
        //titlePadding: const EdgeInsets.only(bottom: 10),
        //centerTitle: true,
        title: Text(
          text,
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
    );
  }
}
