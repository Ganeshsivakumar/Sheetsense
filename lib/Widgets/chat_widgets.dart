import 'package:flutter/material.dart';
import 'package:sheetsense/Utils/Constants/page_texts.dart';
import 'package:sheetsense/Widgets/common_widgets.dart';

class WebDialogBox extends StatefulWidget {
  const WebDialogBox({super.key, required this.onPressed, required this.link});
  final VoidCallback onPressed;
  final TextEditingController link;

  @override
  State<WebDialogBox> createState() => _WebDialogBoxState();
}

class _WebDialogBoxState extends State<WebDialogBox> {
  @override
  Widget build(BuildContext context) {
    return DialogBoxx(
        boxheight: 150,
        boxwidth: 500,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Closebutton(
              padding: 450,
            ),
            WebChatForm(
                onPressed: widget.onPressed,
                controller: widget.link,
                buttonWidth: 100,
                textFieldWidth: 300,
                hintText: TextFieldHintText.updateLink,
                buttonName: "Update")
          ],
        ));
  }
}

class MobileBottomSheetWidget extends StatefulWidget {
  const MobileBottomSheetWidget(
      {super.key, required this.height, required this.sheetWidget});

  final double height;
  final Widget sheetWidget;

  @override
  State<MobileBottomSheetWidget> createState() =>
      _MobileBottomSheetWidgetState();
}

class _MobileBottomSheetWidgetState extends State<MobileBottomSheetWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Closebutton(
            padding: 160,
          ),
          widget.sheetWidget
        ],
      ),
    );
  }
}

class WebChatForm extends StatefulWidget {
  const WebChatForm(
      {super.key,
      required this.onPressed,
      required this.controller,
      required this.buttonWidth,
      required this.textFieldWidth,
      required this.hintText,
      required this.buttonName});
  final TextEditingController controller;
  final VoidCallback onPressed;
  final double textFieldWidth;
  final double buttonWidth;
  final String hintText;
  final String buttonName;

  @override
  State<WebChatForm> createState() => _WebChatFormState();
}

class _WebChatFormState extends State<WebChatForm> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ChatTextField(
            textFieldWidth: widget.textFieldWidth,
            controller: widget.controller,
            hintText: widget.hintText),
        const SizedBox(
          width: 30,
        ),
        FabButton(
            onPressed: widget.onPressed,
            buttonName: widget.buttonName,
            buttonWidth: widget.buttonWidth)
      ],
    );
  }
}

class MobileChatForm extends StatefulWidget {
  const MobileChatForm(
      {super.key,
      required this.onPressed,
      required this.controller,
      required this.buttonWidth,
      required this.textFieldWidth,
      required this.hintText,
      required this.buttonName});
  final TextEditingController controller;
  final VoidCallback onPressed;
  final double textFieldWidth;
  final double buttonWidth;
  final String hintText;
  final String buttonName;

  @override
  State<MobileChatForm> createState() => _MobileChatFormState();
}

class _MobileChatFormState extends State<MobileChatForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ChatTextField(
            textFieldWidth: widget.textFieldWidth,
            controller: widget.controller,
            hintText: widget.hintText),
        const SizedBox(
          height: 20,
        ),
        FabButton(
            onPressed: widget.onPressed,
            buttonName: widget.buttonName,
            buttonWidth: widget.buttonWidth)
      ],
    );
  }
}

class NavBarActions extends StatefulWidget {
  const NavBarActions(
      {super.key,
      required this.editLinkButtonOnPressed,
      required this.contactUsButtonOnPressed});

  final VoidCallback editLinkButtonOnPressed;
  final VoidCallback contactUsButtonOnPressed;

  @override
  State<NavBarActions> createState() => _NavBarActionsState();
}

class _NavBarActionsState extends State<NavBarActions> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        NavBarButton(
            onPressed: widget.editLinkButtonOnPressed,
            buttonName: "Edit csv link"),
        const SizedBox(
          width: 20,
        ),
        NavBarButton(
            onPressed: widget.contactUsButtonOnPressed,
            buttonName: "Contact Us")
      ],
    );
  }
}
