import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nowly/Configs/configs.dart';

class Message extends StatelessWidget {
  const Message({
    Key? key,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: Ink(
            decoration: BoxDecoration(
                color: geMessageColor(context),
                borderRadius: BorderRadius.circular(10),
                boxShadow: UIParameters.getShadow(
                    blurRadius: 8,
                    spreadRadius: 2,
                    shadowColor:
                        Theme.of(context).shadowColor.withOpacity(0.2))),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  label,
                  textAlign: TextAlign.center,
                  style:
                      k16BoldTS, //const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            )),
      ),
    );
  }
}
