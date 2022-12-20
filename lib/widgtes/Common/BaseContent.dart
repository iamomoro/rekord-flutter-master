import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

class BaseContent extends StatefulWidget {
  final String text;

  BaseContent({@required this.text});

  @override
  _BaseContentState createState() => new _BaseContentState();
}

class _BaseContentState extends State<BaseContent> {
  String firstHalf;
  String secondHalf;

  bool flag = true;

  @override
  void initState() {
    super.initState();

    if (widget.text.length > 100) {
      firstHalf = widget.text.substring(0, 100);
      secondHalf = widget.text.substring(100, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: double.infinity,
      padding: new EdgeInsets.symmetric(horizontal: 0.0, vertical: 10.0),
      child: secondHalf.isEmpty
          ? new HtmlWidget(
              firstHalf,
              //  textStyle: Get.theme.textTheme.subtitle1,
            )
          : new InkWell(
              onTap: () {
                setState(() {
                  flag = !flag;
                });
              },
              child: Column(
                children: <Widget>[
                  new HtmlWidget(
                    flag ? (firstHalf + "...") : (firstHalf + secondHalf),
                    // textStyle: Get.theme.textTheme.subtitle1,
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 40,
                      ),
                      Text(
                        flag ? "show more" : "show less",
                        style: new TextStyle(
                            color: Theme.of(context).primaryColorLight),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
