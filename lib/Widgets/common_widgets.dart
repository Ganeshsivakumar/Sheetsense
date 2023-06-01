import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sheetsense/Authentication/signup_page.dart';
import 'package:sheetsense/Utils/Constants/page_texts.dart';
import 'package:url_launcher/url_launcher.dart';

class NavBarButton extends StatefulWidget {
  const NavBarButton(
      {super.key, required this.onPressed, required this.buttonName});

  final VoidCallback onPressed;
  final String buttonName;

  @override
  State<NavBarButton> createState() => _NavBarButtonState();
}

class _NavBarButtonState extends State<NavBarButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(elevation: 5),
        onPressed: widget.onPressed,
        child: Text(widget.buttonName));
  }
}

class EditCsvLinkSnackbar extends StatefulWidget {
  const EditCsvLinkSnackbar({super.key});

  @override
  State<EditCsvLinkSnackbar> createState() => _EditCsvLinkSnackbarState();
}

class _EditCsvLinkSnackbarState extends State<EditCsvLinkSnackbar> {
  @override
  Widget build(BuildContext context) {
    return const SnackBar(
        content: SizedBox(
      height: 300,
      child: Center(
        child: Text("Edit your sv link"),
      ),
    ));
  }
}

class DialogBoxx extends StatefulWidget {
  const DialogBoxx(
      {super.key,
      required this.child,
      required this.boxheight,
      required this.boxwidth});
  final Widget child;
  final double boxheight;
  final double boxwidth;
  @override
  State<DialogBoxx> createState() => _DialogBoxxState();
}

class _DialogBoxxState extends State<DialogBoxx> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
          height: widget.boxheight,
          width: widget.boxwidth,
          child: Center(
            child: widget.child,
          )),
    );
  }
}

class Closebutton extends StatefulWidget {
  const Closebutton({super.key, required this.padding});
  final double padding;

  @override
  State<Closebutton> createState() => _CloseButtonState();
}

class _CloseButtonState extends State<Closebutton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: widget.padding,
      ),
      child: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.close,
          size: 33,
        ),
      ),
    );
  }
}
//450

class FabButton extends StatefulWidget {
  const FabButton(
      {super.key,
      required this.onPressed,
      required this.buttonName,
      required this.buttonWidth});
  final VoidCallback onPressed;
  final String buttonName;
  final double buttonWidth;

  @override
  State<FabButton> createState() => _FabButtonState();
}

class _FabButtonState extends State<FabButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.buttonWidth,
      child: FloatingActionButton(
        onPressed: widget.onPressed,
        child: Text(
          widget.buttonName,
          style: const TextStyle(
            fontFamily: 'Inter',
          ),
        ),
      ),
    );
  }
}

class ChatTextField extends StatefulWidget {
  const ChatTextField(
      {super.key,
      required this.textFieldWidth,
      required this.controller,
      required this.hintText});
  final double textFieldWidth;
  final TextEditingController controller;
  final String hintText;

  @override
  State<ChatTextField> createState() => _ChatTextFieldState();
}

class _ChatTextFieldState extends State<ChatTextField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.textFieldWidth,
      child: TextField(
        controller: widget.controller,
        cursorColor: Colors.transparent,
        style: const TextStyle(
          decoration: TextDecoration.none,
          decorationColor: Colors.transparent,
        ),
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          hintText: widget.hintText,
        ),
      ),
    );
  }
}

class PremiumButton extends StatefulWidget {
  const PremiumButton({super.key});

  @override
  State<PremiumButton> createState() => _PremiumButtonState();
}

class _PremiumButtonState extends State<PremiumButton> {
  String uid = auth.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    return NavBarButton(
        onPressed: () async {
          //mixpanel.track("onTapPremiumPlan");
          String link = Links.stripePaymentLink;
          try {
            String url = "$link$uid";
            final Uri urii = Uri.parse(url);
            if (await canLaunchUrl(urii)) {
              await launchUrl(urii);
            } else {
              print('Could not launch $url');
            }
          } catch (e) {
            print(e);
          }
        },
        buttonName: "Upgrade To Premium Plan ⭐");
  }
}

class UpgradeToPremiumWidget extends StatefulWidget {
  const UpgradeToPremiumWidget({super.key, required this.snapshot});

  final String snapshot;

  @override
  State<UpgradeToPremiumWidget> createState() => _UpgradeToPremiumWidgetState();
}

class _UpgradeToPremiumWidgetState extends State<UpgradeToPremiumWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          widget.snapshot,
          style: const TextStyle(fontSize: 17),
        ),
        const SizedBox(
          height: 20,
        ),
        const PremiumButton()
      ],
    );
  }
}

class LoginButton extends StatefulWidget {
  const LoginButton({super.key, required this.padding});
  final double padding;

  @override
  State<LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(right: widget.padding),
        child: NavBarButton(
          buttonName: "log in",
          onPressed: () async {
            await Get.toNamed('/login');
          },
        ));
  }
}

class SheetsImage extends StatefulWidget {
  const SheetsImage({super.key, required this.height, required this.width});
  final double height;
  final double width;

  @override
  State<SheetsImage> createState() => _SheetsImageState();
}

class _SheetsImageState extends State<SheetsImage> {
  @override
  Widget build(BuildContext context) {
    return Image.asset('assets/images/sheets_logo.png',
        height: widget.height, width: widget.width);
  }
}

class PageTitlee extends StatefulWidget {
  const PageTitlee({super.key, required this.fontsize, required this.title});
  final double fontsize;
  final String title;
  @override
  State<PageTitlee> createState() => _PageTitleeState();
}

class _PageTitleeState extends State<PageTitlee> {
  @override
  Widget build(BuildContext context) {
    return Text(widget.title,
        style: GoogleFonts.inter(
            textStyle: TextStyle(
                fontSize: widget.fontsize, fontWeight: FontWeight.w700)));
  }
}
