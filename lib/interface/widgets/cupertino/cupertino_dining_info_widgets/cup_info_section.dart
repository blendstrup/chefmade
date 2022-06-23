import 'package:flutter/cupertino.dart';

class CupInfoSection extends StatelessWidget {
  const CupInfoSection({
    Key? key,
    required this.title,
    required this.icon,
    this.textGroups,
    this.children,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final List<TextGrouping>? textGroups;
  final List<Widget>? children;

  @override
  Widget build(BuildContext context) {
    CupertinoThemeData _theme = CupertinoTheme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(icon), //CupertinoIcons.person_crop_circle
              const SizedBox(width: 5),
              Text(
                title,
                style: _theme.textTheme.navTitleTextStyle,
              ),
            ],
          ),
          if (textGroups != null)
            for (final text in textGroups!) ...[
              if (text != textGroups!.first)
                const SizedBox(height: 20)
              else
                const SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text.title,
                    style: _theme.textTheme.textStyle.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  if (text.subtitle != null) ...[
                    const SizedBox(height: 3),
                    Text(
                      text.subtitle!,
                      softWrap: true,
                      style: _theme.textTheme.textStyle.copyWith(
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                  const SizedBox(height: 3),
                  if (text.description != null)
                    Text(
                      text.description!,
                      softWrap: true,
                      style: _theme.textTheme.textStyle,
                    )
                  else if (text.descriptionList != null)
                    for (final text in text.descriptionList!)
                      Text(
                        text,
                        softWrap: true,
                        style: _theme.textTheme.textStyle,
                      )
                ],
              ),
            ],
          if (children != null) ...children!,
        ],
      ),
    );
  }
}

class TextGrouping {
  const TextGrouping({
    required this.title,
    required this.description,
    this.subtitle,
    this.descriptionList,
  });

  const TextGrouping.list({
    required this.title,
    required this.descriptionList,
    this.description,
    this.subtitle,
  });

  final String title;
  final String? subtitle;
  final String? description;
  final List<String>? descriptionList;
}
