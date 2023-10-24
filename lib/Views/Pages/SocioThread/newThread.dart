import 'package:flutter/material.dart';

class ThreadData {
  int line;
  late bool isSelected;
  late TextEditingController textEditingController;
  double verticalDividerLength;

  ThreadData(
      {required this.line,
      required this.isSelected,
      required this.textEditingController,
      required this.verticalDividerLength});
}

class NewThread extends StatefulWidget {
  const NewThread({super.key});

  @override
  State<NewThread> createState() => _NewThreadState();
}

class _NewThreadState extends State<NewThread> {
  // Start with 1 line
  bool _showAddThread = false;
  List<ThreadData> threads = [];
  List<FocusNode> focusNodes = [];

  @override
  void initState() {
    super.initState();
    threads.add(ThreadData(
      line: 1,
      isSelected: true,
      textEditingController: TextEditingController(),
      verticalDividerLength: 45,
    ));
    for (int i = 0; i < threads.length; i++) {
      focusNodes.add(FocusNode());
    }
  }

  void updateLineCount(int index) {
    if (index < threads.length) {
      final thread = threads[index];
      final textPainter = TextPainter(
        text: TextSpan(
          text: thread.textEditingController.text,
          style: TextStyle(fontSize: 15),
        ),
        textDirection: TextDirection.ltr,
        maxLines: 100,
      );
      textPainter.layout(maxWidth: MediaQuery.of(context).size.width - 76);
      final newLineCount = textPainter.computeLineMetrics().length;
      if (newLineCount - thread.line == 1) {
        setState(() {
          thread.line++;
          thread.verticalDividerLength += 20;
        });
      } else if (thread.line - newLineCount == 1) {
        setState(() {
          thread.line--;
          thread.verticalDividerLength -= 20;
        });
      }
    }
  }

  void addNewThread() {
    final TextEditingController newController = TextEditingController();
    newController.addListener(() {
      updateLineCount(threads.length);
    });
    setState(() {
      for (final thread in threads) {
        thread.isSelected = false;
      }
      threads.add(ThreadData(
        line: 1,
        isSelected: true,
        textEditingController: newController,
        verticalDividerLength: 45,
      ));
      focusNodes.add(FocusNode());
      FocusScope.of(context).requestFocus(focusNodes[threads.length - 1]);
      _showAddThread = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF1a1a22),
        elevation: 0.15,
        shadowColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.close,
            size: 23,
          ),
          onPressed: () {
            Navigator.pop(context); // Handle close button action
          },
        ),
        title: Text(
          'New thread',
          style: TextStyle(
            fontSize: 18.5,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.post_add,
              size: 23,
              color: threads[0].textEditingController.text.isNotEmpty
                  ? Colors.white
                  : Colors.grey.shade700,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: threads.asMap().entries.map((entry) {
                final index = entry.key;
                final thread = entry.value;
                return Padding(
                  key: ValueKey<int>(index),
                  padding: const EdgeInsets.only(left: 12, right: 12, top: 15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          ClipOval(
                            child: Image.asset(
                              'assets/Country_flag/ad.png',
                              height: 35,
                              width: 35,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            height: thread.isSelected
                                ? thread.verticalDividerLength
                                : thread.verticalDividerLength - 38,
                            width: 2,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade700,
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 15),
                        width: MediaQuery.of(context).size.width - 74,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'kushalgupta2510',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                thread.textEditingController.text.isEmpty
                                    ? SizedBox(width: 1)
                                    : Padding(
                                        padding: EdgeInsets.only(right: 10),
                                        child: GestureDetector(
                                          onTap: () {
                                            if (thread.textEditingController
                                                    .text.isNotEmpty &&
                                                threads.length > 1) {
                                              setState(() {
                                                thread.textEditingController
                                                    .clear();
                                                threads.removeAt(index);
                                                focusNodes.removeAt(index);
                                              });
                                            } else if (threads.length == 1) {
                                              setState(() {
                                                thread.textEditingController
                                                    .clear();
                                                thread.isSelected = true;
                                                _showAddThread = false;
                                              });
                                            }
                                          },
                                          child: Icon(
                                            Icons.close,
                                            size: 18,
                                            color: Colors.grey.shade700,
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                            TextFormField(
                              controller: thread.textEditingController,
                              showCursor: thread.isSelected,
                              focusNode: focusNodes[index],
                              autofocus: true,
                              maxLines: null,
                              cursorColor: Colors.white,
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                              decoration: InputDecoration(
                                isDense: true,
                                hintText: 'Start a thread...',
                                hintStyle: TextStyle(
                                  color: Colors.grey.shade600,
                                ),
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 5),
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                              ),
                              onChanged: (text) {
                                updateLineCount(index);
                                if (threads.last.textEditingController.text
                                    .isNotEmpty) {
                                  setState(() {
                                    _showAddThread = true;
                                  });
                                } else {
                                  setState(() {
                                    _showAddThread = false;
                                  });
                                }
                              },
                              onTap: () {
                                for (final thread in threads) {
                                  thread.isSelected = false;
                                }
                                setState(() {
                                  thread.isSelected = true;
                                  focusNodes[index].requestFocus();
                                });
                              },
                            ),
                            thread.isSelected
                                ? Padding(
                                    padding: const EdgeInsets.only(top: 12),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.photo_library_rounded,
                                          color: Colors.white54,
                                        ),
                                        SizedBox(width: 17),
                                        Icon(
                                          Icons.mic,
                                          color: Colors.white54,
                                        ),
                                      ],
                                    ),
                                  )
                                : SizedBox(height: 1),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }).toList(),
            ),
            GestureDetector(
              onTap: () {
                if (_showAddThread) {
                  addNewThread();
                }
              },
              child: ListTile(
                contentPadding: const EdgeInsets.only(left: 19),
                minLeadingWidth: 25,
                leading: Padding(
                  padding: const EdgeInsets.only(top: 1),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/Country_flag/ad.png',
                      height: 20,
                      width: 20,
                      fit: BoxFit.cover,
                      color: _showAddThread ? null : Colors.grey.shade800,
                      colorBlendMode: _showAddThread ? null : BlendMode.darken,
                    ),
                  ),
                ),
                title: Text(
                  'Add to thread',
                  style: TextStyle(
                    fontSize: 14,
                    color: _showAddThread ? Colors.grey : Colors.grey.shade800,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
