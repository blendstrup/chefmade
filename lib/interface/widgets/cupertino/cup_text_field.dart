import 'package:flutter/cupertino.dart';

import '../../colors.dart';

class CupTextField extends StatefulWidget {
  const CupTextField({
    Key? key,
    this.maintainState,
    this.initial,
    this.padding,
    this.placeholder,
    this.onSave,
    this.onDiscard,
    this.scrollPadding,
  }) : super(key: key);

  final bool? maintainState;
  final String? initial;
  final EdgeInsets? padding;
  final String? placeholder;
  final Function(String)? onSave;
  final Function(String)? onDiscard;
  final EdgeInsets? scrollPadding;

  @override
  State<CupTextField> createState() => _CupTextFieldState();
}

class _CupTextFieldState extends State<CupTextField>
    with AutomaticKeepAliveClientMixin {
  late TextEditingController _controller;
  late String _lastSaved;
  bool _showButtons = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initial);
    _lastSaved = widget.initial ?? '';
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => widget.maintainState ?? false;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Column(
      children: [
        CupertinoTextField(
          controller: _controller,
          placeholder: widget.placeholder ?? 'Write here...',
          maxLines: null,
          padding: widget.padding ?? const EdgeInsets.all(10),
          scrollPadding: widget.scrollPadding ?? const EdgeInsets.all(20),
          //textCapitalization: TextCapitalization.sentences,
          keyboardType: TextInputType.multiline,
          textInputAction: TextInputAction.newline,
          decoration: BoxDecoration(
            color: const CupertinoDynamicColor.withBrightness(
              color: AppColors.white,
              darkColor: AppColors.darkGrey2,
            ).resolveFrom(context),
            borderRadius: BorderRadius.circular(10),
          ),
          onChanged: (str) {
            if (str != _lastSaved) {
              setState(() => _showButtons = true);
            } else {
              if (_showButtons) setState(() => _showButtons = false);
            }
          },
        ),
        if (_showButtons) ...[
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CupertinoButton(
                onPressed: () => onDiscarded(),
                child: Text(
                  'Cancel',
                  style: CupertinoTheme.of(context)
                      .textTheme
                      .actionTextStyle
                      .copyWith(
                        color: AppColors.red,
                      ),
                ),
              ),
              const SizedBox(width: 20),
              CupertinoButton(
                onPressed: () => onSubmitted(),
                child: Text(
                  'Save changes',
                  style: CupertinoTheme.of(context).textTheme.actionTextStyle,
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  void onSubmitted() {
    if (widget.onSave != null) widget.onSave!(_controller.text);

    setState(() {
      _lastSaved = _controller.text;
      _showButtons = false;
    });

    FocusManager.instance.primaryFocus?.unfocus();
  }

  void onDiscarded() {
    if (widget.onDiscard != null) widget.onDiscard!(_controller.text);

    setState(() {
      _controller.text = _lastSaved;
      _showButtons = false;
    });

    FocusManager.instance.primaryFocus?.unfocus();
  }
}
