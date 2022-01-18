import 'package:flutter/material.dart';

import 'SizeConfig.dart';
import 'package:secqrv3/themes/themes.dart';

class InputContainer extends StatelessWidget {
  const InputContainer({ Key? key, this.hinttext, this.myController, this.maxline=1 }) : super(key: key);

  final String ? hinttext;
  final TextEditingController ? myController;
  final int maxline;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: SizeConfig.defaultSize! / 10,
        horizontal: SizeConfig.defaultSize!
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(SizeConfig.defaultSize! * 1.5),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 4),
            color: kPrimaryColor.withOpacity(.1),
            blurRadius: 20
          )
        ]
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: myController,
              maxLines: maxline,
              decoration: InputDecoration(
                hintText: hinttext,
                hintStyle: TextStyle(
                  fontSize: SizeConfig.defaultSize! * 1.6,
                  color: kPrimaryDark.withOpacity(.5)
                ),
                border: InputBorder.none,
                suffixIcon: GestureDetector(
                  onTap: () => myController!.clear(),
                  child: const Icon(Icons.clear),
                )
              ),
            ), 
          ),
        ],
      ),
    );
  }
}