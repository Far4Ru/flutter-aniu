import 'package:aniu/data/text_styles.dart';
import 'package:aniu/models/display_data/quick_actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


Widget actionsSwiper(BuildContext context, List<QuickActionsDisplayData> items) {
  return Container(
    height: 280,
    width: MediaQuery.of(context).size.width,
    child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length ~/ 2,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: index == 0 ? const EdgeInsets.only() : const EdgeInsets.only(left: 10.0),
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
  return GestureDetector(
    onTap: (){
      quickActionsItem.type != null
          ? quickActionsItem.toPage(context, quickActionsItem.type)
          : quickActionsItem.toPage(context);
    },
    child: Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Container(
        height: 180 * 0.7,
        width: 180,
        child: Stack(
          children: [
            Container(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 5.0),
                child: Container(
                  width: 90,
                  height: 90,
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
              padding: const EdgeInsets.only(left: 12.0, top: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(quickActionsItem.title, style: titleStyle,),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Container(
                      width: 120,
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