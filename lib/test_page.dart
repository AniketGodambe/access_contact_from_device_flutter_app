import 'package:flutter/material.dart';

class TestWidget extends StatefulWidget {
  const TestWidget({super.key});

  @override
  State<TestWidget> createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> {
  final List<String> items = [
    "CTR",
    "Spends",
    "CPM",
    "Link Clicks",
    "Add to Cart",
    "AOV",
    "ROAS"
  ];
  List defaultview = [
    {
      'platform': "facebook",
      'spends': "237",
      'ctr': "464",
      'cpm': "682",
      'link clicks': "6562",
      'add to cart': "5467",
      'aov': "5454",
      'roas': "8754",
      'comparsionspends': "13,567",
      'previous': "11,445"
    },
    {
      'platform': "Twitter",
      'spends': "4388",
      'ctr': "6565",
      'cpm': "545",
      'link clicks': "9598",
      'add to cart': "4567",
      'aov': "6587",
      'roas': "23123",
      'comparsionspends': "13,567",
      'previous': "11,445"
    },
    {
      'platform': "Google",
      'spends': "3283",
      'ctr': "464",
      'cpm': "682",
      'link clicks': "5588",
      'add to cart': "4658",
      'aov': "5454",
      'roas': "8754",
      'comparsionspends': "13,567",
      'previous': "11,445"
    },
    {
      'platform': "Linkedin",
      'spends': "1289",
      'ctr': "3578",
      'cpm': "6822",
      'link clicks': "4372",
      'add to cart': "4547",
      'aov': "67843",
      'roas': "5872",
      'comparsionspends': "46,567",
      'previous': "11,445"
    },
    {
      'platform': "Instagram",
      'spends': "6465",
      'ctr': "654",
      'cpm': "321",
      'link clicks': "6482",
      'add to cart': "3245",
      'aov': "4578",
      'roas': "546",
      'comparsionspends': "75,567",
      'previous': "11,445"
    },
    {
      'platform': "Youtube",
      'spends': "3787",
      'ctr': "4567",
      'cpm': "2478",
      'link clicks': "7866",
      'add to cart': "2576",
      'aov': "4677",
      'roas': "5547",
      'comparsionspends': "13,567",
      'previous': "11,445"
    },
    {
      'platform': "Snapchat",
      'spends': "3283",
      'ctr': "457",
      'cpm': "3465",
      'link clicks': "4578",
      'add to cart': "7524",
      'aov': "3254",
      'roas': "6578",
      'comparsionspends': "13,567",
      'previous': "11,445"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: const EdgeInsets.only(right: 5),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.center,
                    child: Text(items[index]),
                  );
                },
              ),
            ),
            Table(
              border: const TableBorder(
                verticalInside: BorderSide(
                  color: Color(0xffE5E5E5),
                ),
                bottom: BorderSide(
                  color: Color(0xffE5E5E5),
                ),
              ),
              children: [],
            ),
            Table(
                border: const TableBorder(
                  verticalInside:
                      BorderSide(width: 1, color: Color(0xffE5E5E5)),
                ),
                children: []),
          ],
        ),
      ),
    );
  }
}
