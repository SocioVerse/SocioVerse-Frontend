// ListView.builder(
//                             itemCount: 4,
//                             shrinkWrap: true,
//                             physics:
//                                 NeverScrollableScrollPhysics(), // Disable inner ListView scrolling
//                             itemBuilder: (context, index) {
//                               return Column(
//                                 children: [
//                                   Column(
//                                     children: [
//                                       Divider(thickness: 0.5),
//                                       Padding(
//                                         padding: EdgeInsets.symmetric(
//                                             horizontal: 0, vertical: 5),
//                                         child: Row(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             Column(
//                                               children: [
//                                                 Stack(
//                                                   children: [
//                                                     ClipOval(
//                                                       child: Image.asset(
//                                                         'assets/Country_flag/ad.png',
//                                                         height: 35,
//                                                         width: 35,
//                                                         fit: BoxFit.cover,
//                                                       ),
//                                                     ),
//                                                     Positioned(
//                                                       right: 0,
//                                                       bottom: 0,
//                                                       child: Container(
//                                                         height: 16,
//                                                         width: 16,
//                                                         decoration:
//                                                             BoxDecoration(
//                                                           color: Colors.white,
//                                                           borderRadius:
//                                                               BorderRadius
//                                                                   .circular(10),
//                                                           border: Border.all(
//                                                             color: Colors.black,
//                                                           ),
//                                                         ),
//                                                         child: Icon(
//                                                           Icons.add,
//                                                           size: 15,
//                                                           color: Colors.black,
//                                                         ),
//                                                       ),
//                                                     )
//                                                   ],
//                                                 ),
//                                                 Container(
//                                                   margin: EdgeInsets.symmetric(
//                                                       vertical: 10),
//                                                   height: 38,
//                                                   width: 2,
//                                                   decoration: BoxDecoration(
//                                                     color: Colors.grey.shade700,
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             3),
//                                                   ),
//                                                 ),
//                                                 _haveReplies
//                                                     ? GestureDetector(
//                                                         onTap: () {
//                                                           setState(() {
//                                                             _isExtended =
//                                                                 !_isExtended;
//                                                           });
//                                                         },
//                                                         child: Container(
//                                                           height: 20,
//                                                           width: 41,
//                                                           child: Stack(
//                                                             children: [
//                                                               Positioned(
//                                                                 right: 20.5,
//                                                                 child:
//                                                                     Container(
//                                                                   height: 20,
//                                                                   width: 20,
//                                                                   decoration:
//                                                                       BoxDecoration(
//                                                                     borderRadius:
//                                                                         BorderRadius.circular(
//                                                                             10),
//                                                                     border:
//                                                                         Border
//                                                                             .all(
//                                                                       color: Colors
//                                                                           .black87,
//                                                                       width: 2,
//                                                                     ),
//                                                                   ),
//                                                                   child:
//                                                                       ClipOval(
//                                                                     child: Image
//                                                                         .asset(
//                                                                       'assets/Country_flag/ad.png',
//                                                                       fit: BoxFit
//                                                                           .fill,
//                                                                     ),
//                                                                   ),
//                                                                 ),
//                                                               ),
//                                                               Positioned(
//                                                                 right: 10.5,
//                                                                 child:
//                                                                     Container(
//                                                                   height: 20,
//                                                                   width: 20,
//                                                                   decoration:
//                                                                       BoxDecoration(
//                                                                     borderRadius:
//                                                                         BorderRadius.circular(
//                                                                             10),
//                                                                     border:
//                                                                         Border
//                                                                             .all(
//                                                                       width: 2,
//                                                                       color: Colors
//                                                                           .black87,
//                                                                     ),
//                                                                   ),
//                                                                   child:
//                                                                       ClipOval(
//                                                                     child: Image
//                                                                         .asset(
//                                                                       'assets/Country_flag/ad.png',
//                                                                       fit: BoxFit
//                                                                           .fill,
//                                                                     ),
//                                                                   ),
//                                                                 ),
//                                                               ),
//                                                               Positioned(
//                                                                 right: 0,
//                                                                 child:
//                                                                     Container(
//                                                                   height: 20,
//                                                                   width: 20,
//                                                                   decoration:
//                                                                       BoxDecoration(
//                                                                     color: Colors
//                                                                         .white,
//                                                                     borderRadius:
//                                                                         BorderRadius.circular(
//                                                                             10),
//                                                                     border:
//                                                                         Border
//                                                                             .all(
//                                                                       width: 2,
//                                                                       color: Colors
//                                                                           .black87,
//                                                                     ),
//                                                                   ),
//                                                                   child: Icon(
//                                                                     Icons
//                                                                         .arrow_drop_down,
//                                                                     color: Colors
//                                                                         .black,
//                                                                     size: 18.5,
//                                                                   ),
//                                                                 ),
//                                                               ),
//                                                             ],
//                                                           ),
//                                                         ),
//                                                       )
//                                                     : SizedBox(height: 0),
//                                               ],
//                                             ),
//                                             Padding(
//                                               padding:
//                                                   EdgeInsets.only(left: 10),
//                                               child: Column(
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.start,
//                                                 children: [
//                                                   SizedBox(
//                                                     width:
//                                                         MediaQuery.of(context)
//                                                                 .size
//                                                                 .width -
//                                                             81,
//                                                     child: Row(
//                                                       mainAxisAlignment:
//                                                           MainAxisAlignment
//                                                               .spaceBetween,
//                                                       children: [
//                                                         Text(
//                                                           'lepan1m',
//                                                           style: TextStyle(
//                                                             color: Colors.white,
//                                                             fontWeight:
//                                                                 FontWeight.w700,
//                                                           ),
//                                                         ),
//                                                         Container(
//                                                           child: Row(
//                                                             children: [
//                                                               Text('41 m'),
//                                                               SizedBox(
//                                                                   width: 10),
//                                                               Icon(Icons
//                                                                   .more_horiz),
//                                                             ],
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                   SizedBox(height: 3),
//                                                   Text('Nice Flag'),
//                                                   SizedBox(height: 13),
//                                                   Container(
//                                                     width: 135,
//                                                     child: Row(
//                                                       mainAxisAlignment:
//                                                           MainAxisAlignment
//                                                               .spaceBetween,
//                                                       children: [
//                                                         Icon(
//                                                           Icons
//                                                               .favorite_border_rounded,
//                                                           size: 23,
//                                                         ),
//                                                         Icon(
//                                                           Icons
//                                                               .mode_comment_outlined,
//                                                           size: 23,
//                                                         ),
//                                                         Icon(
//                                                           Icons.reply_all_sharp,
//                                                           size: 23,
//                                                         ),
//                                                         Icon(
//                                                           Icons.share,
//                                                           size: 23,
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                   SizedBox(height: 15),
//                                                   Row(
//                                                     children: [
//                                                       Text(
//                                                         '2 replies ',
//                                                         style: TextStyle(
//                                                           color: Colors
//                                                               .grey.shade600,
//                                                         ),
//                                                       ),
//                                                       Text(
//                                                         '• 78 likes',
//                                                         style: TextStyle(
//                                                           color: Colors
//                                                               .grey.shade600,
//                                                         ),
//                                                       )
//                                                     ],
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                       if (_isExtended)
//                                         Container(
//                                             width: MediaQuery.of(context)
//                                                 .size
//                                                 .width,
//                                             child: buildExtendedReplies()),
//                                     ],
//                                   ),
//                                 ],
//                               );
//                             },
//                           )