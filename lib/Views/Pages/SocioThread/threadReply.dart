import 'package:flutter/material.dart';
import 'package:socioverse/main.dart';

class ThreadReply extends StatefulWidget {
  const ThreadReply({super.key});

  @override
  State<ThreadReply> createState() => _ThreadReplyState();
}

class _ThreadReplyState extends State<ThreadReply> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF1a1a22),
        elevation: 0.15,
        shadowColor: Colors.white,
        leading: Icon(Icons.arrow_back),
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
        child: ListView(
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
                              Positioned(
                                right: 0,
                                bottom: 0,
                                child: Container(
                                  height: 16,
                                  width: 16,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
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
                    'Ad Flag image',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      'assets/Country_flag/aq.png',
                      height: 300,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 30),
                  Container(
                    width: 135,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              scrollDirection: Axis.vertical,
              physics:
                  NeverScrollableScrollPhysics(), // Disable inner ListView scrolling
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Divider(thickness: 0.5),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width - 75,
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
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
