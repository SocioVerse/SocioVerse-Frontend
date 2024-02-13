import 'package:flutter/material.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/Feeds/feedWidgets.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/Create%20Post/NewThread/newThread.dart';
import 'package:socioverse/Views/Pages/SocioThread/widgets.dart';

class ThreadReply extends StatefulWidget {
  const ThreadReply({required this.text, required this.imageUrl});
  final String text;
  final String imageUrl;
  @override
  State<ThreadReply> createState() => _ThreadReplyState();
}

class _ThreadReplyState extends State<ThreadReply> {
  double verticalDividerLength1 = 38;
  double verticalDividerLength2 = 38;
  bool _isExtended = false;
  bool _haveReplies = true;
  final List<String> extendedReplies = [
    'Extended Reply 1',
    'Extended Reply 2',
    'Extended Reply 3',
    'Extended Reply 4',
  ];

  Widget buildExtendedReplies() {
    return ListView.builder(
      itemCount: _isExtended ? extendedReplies.length : 0,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Stack(
                    children: [
                      ClipOval(
                        child: Image.asset(
                          'assets/Country_flag/ad.png',
                          height: 35,
                          width: 35,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          height: 16,
                          width: 16,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.black,
                            ),
                          ),
                          child: Icon(
                            Icons.add,
                            size: 15,
                            color: Colors.black,
                          ),
                        ),
                      )
                    ],
                  ),
                  index == extendedReplies.length - 1
                      ? SizedBox()
                      : Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          height: verticalDividerLength2 + 45,
                          width: 2,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade700,
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 81,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'lepan1m',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Container(
                            child: Row(
                              children: [
                                Text('41 m'),
                                SizedBox(width: 10),
                                Icon(Icons.more_horiz),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 3),
                    Text('Nice Flag'),
                    SizedBox(height: 13),
                    Container(
                      width: 135,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.favorite_border_rounded,
                            size: 23,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => NewThread()));
                            },
                            child: Icon(
                              Icons.mode_comment_outlined,
                              size: 23,
                            ),
                          ),
                          Icon(
                            Icons.reply_all_sharp,
                            size: 23,
                          ),
                          Icon(
                            Icons.share,
                            size: 23,
                          ),
                        ],
                      ),
                    ),
                    index == extendedReplies.length - 1
                        ? SizedBox(height: 10)
                        : SizedBox(height: 15),
                    index == extendedReplies.length - 1
                        ? SizedBox()
                        : Row(
                            children: [
                              UserProfileImageStackOf2(
                                isShowIcon: false,
                              ),
                              Text(
                                '2 replies ',
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                ),
                              ),
                              Text(
                                '• 78 likes',
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                ),
                              )
                            ],
                          ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF1a1a22),
        elevation: 0.15,
        shadowColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              setState(() {
                _isExtended = !_isExtended;
              });
            },
            icon: Icon(Icons.arrow_back)),
        title: Text(
          'Thread',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Icon(
              Icons.notifications_none,
              size: 24,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 15, right: 15, top: 15, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Stack(
                              children: [
                                ClipOval(
                                  child: Image.asset(
                                    'assets/Country_flag/ad.png',
                                    height: 35,
                                    width: 35,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                _haveReplies
                                    ? Positioned(
                                        right: 0,
                                        bottom: 0,
                                        child: Container(
                                          height: 16,
                                          width: 16,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Icon(
                                            Icons.add,
                                            size: 15,
                                            color: Colors.black,
                                          ),
                                        ),
                                      )
                                    : SizedBox()
                              ],
                            ),
                            SizedBox(width: 10),
                            Text(
                              'lepan1m',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('41 m'),
                            SizedBox(width: 10),
                            Icon(Icons.more_horiz),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Text(
                      widget.text,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 10),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        widget.imageUrl,
                        height: 300,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: 135,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.favorite_border_rounded,
                            size: 23,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => NewThread()));
                            },
                            child: Icon(
                              Icons.mode_comment_outlined,
                              size: 23,
                            ),
                          ),
                          Icon(
                            Icons.reply_all_sharp,
                            size: 23,
                          ),
                          Icon(
                            Icons.share,
                            size: 23,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          '2 replies ',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                          ),
                        ),
                        Text(
                          '• 78 likes',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              ListView.builder(
                itemCount: 4,
                shrinkWrap: true,
                physics:
                    NeverScrollableScrollPhysics(), // Disable inner ListView scrolling
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Column(
                        children: [
                          Divider(thickness: 0.5),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    Stack(
                                      children: [
                                        ClipOval(
                                          child: Image.asset(
                                            'assets/Country_flag/ad.png',
                                            height: 35,
                                            width: 35,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Positioned(
                                          right: 0,
                                          bottom: 0,
                                          child: Container(
                                            height: 16,
                                            width: 16,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                color: Colors.black,
                                              ),
                                            ),
                                            child: Icon(
                                              Icons.add,
                                              size: 15,
                                              color: Colors.black,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    Container(
                                      margin: _isExtended
                                          ? EdgeInsets.only(top: 10, bottom: 5)
                                          : EdgeInsets.symmetric(vertical: 10),
                                      height: verticalDividerLength1,
                                      width: 2,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade700,
                                        borderRadius: BorderRadius.circular(3),
                                      ),
                                    ),
                                    _haveReplies
                                        ? GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                _isExtended = !_isExtended;
                                                _isExtended
                                                    ? verticalDividerLength1 +=
                                                        40
                                                    : null;
                                              });
                                            },
                                            child: !_isExtended
                                                ? UserProfileImageStackOf2(
                                                    isShowIcon: true,
                                                  )
                                                : SizedBox(),
                                          )
                                        : SizedBox(),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                81,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'lepan1m',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            Container(
                                              child: Row(
                                                children: [
                                                  Text('41 m'),
                                                  SizedBox(width: 10),
                                                  Icon(Icons.more_horiz),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 3),
                                      Text('Nice Flag'),
                                      SizedBox(height: 13),
                                      Container(
                                        width: 135,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Icon(
                                              Icons.favorite_border_rounded,
                                              size: 23,
                                            ),
                                            Icon(
                                              Icons.mode_comment_outlined,
                                              size: 23,
                                            ),
                                            Icon(
                                              Icons.reply_all_sharp,
                                              size: 23,
                                            ),
                                            Icon(
                                              Icons.share,
                                              size: 23,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 15),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) => ThreadReply(
                                                  text: 'none', imageUrl: 'no'),
                                            ),
                                          );
                                        },
                                        child: Row(
                                          children: [
                                            _isExtended
                                                ? UserProfileImageStackOf2(
                                                    isShowIcon: false,
                                                  )
                                                : SizedBox(),
                                            Text(
                                              '2 replies ',
                                              style: TextStyle(
                                                color: Colors.grey.shade600,
                                              ),
                                            ),
                                            Text(
                                              '• 78 likes',
                                              style: TextStyle(
                                                color: Colors.grey.shade600,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (_isExtended)
                            Container(
                                width: MediaQuery.of(context).size.width,
                                child: buildExtendedReplies()),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
