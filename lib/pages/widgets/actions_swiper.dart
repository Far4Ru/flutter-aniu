import 'package:aniu/data/sizes.dart';
import 'package:aniu/data/text_styles.dart';
import 'package:aniu/models/display_data/quick_actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


Widget actionsSwiper(BuildContext context, List<QuickActionsDisplayData> items) {
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;

  return Container(
    height: height * 280 / templateHeight,
    width: width,
    child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length ~/ 2,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: index == 0 ? const EdgeInsets.only() : EdgeInsets.only(left: width * 10.0 / templateWidth),
            child: Column(
              children: [
                _quickActionCard(context, items[2 * index]),
                _quickActionCard(context, items[2 * index + 1])
              ]
            ),
          );
        }
    ),
  );
}

Widget _quickActionCard(BuildContext context, QuickActionsDisplayData quickActionsItem) {
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;

  return GestureDetector(
    onTap: (){
      quickActionsItem.type != null
          ? quickActionsItem.toPage(context, quickActionsItem.type)
          : quickActionsItem.toPage(context);
    },
    child: Padding(
      padding: EdgeInsets.only(top: height * 10.0 / templateHeight),
      child: Container(
        height: height * 180 * 0.7 / templateHeight,
        width: width * 180 / templateWidth,
        child: Stack(
          children: [
            Container(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.only(right: width * 5.0 / templateWidth),
                child: Container(
                  width: width * 90 / templateWidth,
                  height: height * 90 / templateHeight,
                  alignment: Alignment.bottomRight,
                  child: quickActionsItem.asset.length == 1
                      ? Text(quickActionsItem.asset, style: backgroundCardStyle,)
                      : SvgPicture.asset(
                          'assets/card_icons/' + quickActionsItem.asset + '.svg' ,
                          color: const Color(0x446c757d),
                        ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: width * 12.0 / templateWidth, top: height * 12.0 / templateHeight),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(quickActionsItem.title, style: titleStyle,),
                  Padding(
                    padding: EdgeInsets.only(top: height * 5.0 / templateHeight),
                    child: Container(
                      width: width * 120 / templateWidth,
                      child: Text(
                        quickActionsItem.description,
                        style: smallStyle,
                        maxLines: 3,
                      )
                    ),
                  ),
                ],
              )
            ),
          ],
        ),
        decoration: BoxDecoration(
          color: const Color(0xff0f1422),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
  );
}