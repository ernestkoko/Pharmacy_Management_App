import 'package:flutter/material.dart';

///custom dialog
class CustomAlertDialog extends StatelessWidget {
  final String? title;
  final String? content;
  final String? cancelActionText;
  final String? defaultActionText;
  final Color? color;
  final VoidCallback? defaultActionPressed;
  final Widget? contentWidget;

  CustomAlertDialog(
      {@required this.title,
      @required this.content,
      this.cancelActionText,
      this.defaultActionText,
      this.color,
      this.defaultActionPressed,
      this.contentWidget})
      : assert(title != null),
        assert(content != null || contentWidget != null),
        assert(cancelActionText != null);

  ///[show]
  Future<bool?> show(BuildContext context) async {
    return await showDialog<bool>(
      barrierDismissible: false,
      context: context,
      builder: (ctx) => this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title!,
        style: TextStyle(color: color),
      ),
      content: contentWidget != null ? contentWidget : Text(content!),
      actions: _buildActions(context),
    );
  }

  List<Widget> _buildActions(BuildContext context) {
    List<Widget> actions = [];
    if (defaultActionText != null) {
      actions.add(
        TextButton(
          onPressed: defaultActionPressed,
          child: Text(defaultActionText!),
        ),
      );
    }

    actions.add(
      TextButton(
        child: Text(cancelActionText!),
        onPressed: () {
          Navigator.of(context).pop(true);
        },
      ),
    );
    return actions;
  }
}
