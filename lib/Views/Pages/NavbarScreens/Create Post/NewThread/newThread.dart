import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:socioverse/Controllers/newThreadPageProvider.dart';
import 'package:socioverse/Helper/FirebaseHelper/firebaseHelperFunctions.dart';
import 'package:socioverse/Helper/ImagePickerHelper/imagePickerHelper.dart';
import 'package:socioverse/Helper/Loading/spinKitLoaders.dart';
import 'package:socioverse/Models/threadModel.dart';
import 'package:socioverse/Models/userModel.dart';
import 'package:socioverse/Models/userSignUpModel.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/Create%20Post/NewThread/newThreadWidgets.dart';
import 'package:socioverse/Views/Pages/SocioVerse/MainPage.dart';
import 'package:socioverse/Views/Widgets/Global/imageLoadingWidgets.dart';
import 'package:socioverse/Services/thread_services.dart';
import 'package:socioverse/Services/user_services.dart';
import 'package:uuid/uuid.dart';

class NewThread extends StatefulWidget {
  const NewThread({super.key});

  @override
  State<NewThread> createState() => _NewThreadState();
}

class _NewThreadState extends State<NewThread> {
  // Start with 1 line
  // bool _showAddThread = false; //
  // List<ThreadData> threads = []; //
  // List<FocusNode> focusNodes = []; //
  // List<UserModel> user = []; //
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Provider.of<NewThreadPageProvider>(context, listen: false).init();
      fetchUserdata();
      Provider.of<NewThreadPageProvider>(context, listen: false)
          .addThread(ThreadData(
        line: 1,
        isSelected: true,
        textEditingController: TextEditingController(),
        verticalDividerLength: 45,
        images: [],
      ));
      for (int i = 0;
          i <
              Provider.of<NewThreadPageProvider>(context, listen: false)
                  .threads
                  .length;
          i++) {
        Provider.of<NewThreadPageProvider>(context, listen: false)
            .addFocusNode(FocusNode());
      }
    });
  }

  void fetchUserdata() async {
    Provider.of<NewThreadPageProvider>(context, listen: false).user =
        await UserServices().getUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NewThreadPageProvider>(builder: (context, prov, child) {
      return prov.user.isEmpty
          ? Scaffold(body: SpinKit.ring)
          : Scaffold(
              appBar: AppBar(
                backgroundColor: const Color(0xFF1a1a22),
                elevation: 0.15,
                automaticallyImplyLeading: false,
                shadowColor: Colors.white,
                title: const Text(
                  'New thread',
                  style: TextStyle(
                    fontSize: 18.5,
                    color: Colors.white,
                  ),
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: ((ctx) {
                            return CreateNewThreadAlertBox(
                                threads: prov.threads);
                          }));
                    },
                    icon: Icon(
                      Icons.post_add,
                      size: 23,
                      color:
                          prov.threads[0].textEditingController.text.isNotEmpty
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
                      children: prov.threads.asMap().entries.map((entry) {
                        final index = entry.key;
                        final thread = entry.value;
                        return Padding(
                          key: ValueKey<int>(index),
                          padding: const EdgeInsets.only(
                              left: 12, right: 12, top: 15),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircularNetworkImageWithSize(
                                imageUrl: prov. user[0].profilePic,
                                height: 35,
                                width: 35,
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 15),
                                width: MediaQuery.of(context).size.width - 74,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          prov.user[0].username,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        thread.textEditingController.text
                                                .isEmpty
                                            ? const SizedBox(width: 1)
                                            : Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 10),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    if (prov.threads.length >
                                                        1) {
                                                      prov.removeThread(index);
                                                    } else if (prov
                                                            .threads.length ==
                                                        1) {
                                                      prov.onRemoval(thread.id);
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
                                      focusNode: prov.focusNodes[index],
                                      autofocus: true,
                                      maxLines: null,
                                      cursorColor: Colors.white,
                                      style: const TextStyle(
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
                                            const EdgeInsets.symmetric(
                                                vertical: 5),
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                      ),
                                      onChanged: (text) {
                                        prov.updateLineCount(index, context);
                                        if (prov
                                            .threads
                                            .last
                                            .textEditingController
                                            .text
                                            .isNotEmpty) {
                                          prov.showAddThread = true;
                                        } else {
                                          prov.showAddThread = false;
                                        }
                                      },
                                      onTap: () {
                                        prov.onWritting(thread.id, index);
                                      },
                                    ),
                                    const SizedBox(height: 0),
                                    thread.isUploading == true
                                        ? LinearProgressIndicator(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            backgroundColor:
                                                Colors.grey.shade700,
                                            minHeight: 2,
                                          )
                                        : GridView.builder(
                                            shrinkWrap: true,
                                            itemCount: thread.images.length,
                                            gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 3,
                                              crossAxisSpacing: 5,
                                              mainAxisSpacing: 5,
                                            ),
                                            itemBuilder: (context, index) {
                                              return Stack(
                                                children: [
                                                  RoundedNetworkImageWithLoading(
                                                    imageUrl:
                                                        thread.images[index],
                                                    borderRadius:
                                                        5, // Set the desired border radius
                                                    fit: BoxFit.cover,
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.topRight,
                                                    child: IconButton(
                                                      onPressed: () {
                                                        FirebaseHelper
                                                            .deleteFileByUrl(
                                                                thread.images[
                                                                    index]);
                                                        prov.removeImageFromList(
                                                            index);
                                                      },
                                                      icon: const Icon(
                                                        Icons.remove_circle,
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          ),
                                    thread.isSelected
                                        ? Padding(
                                            padding:
                                                const EdgeInsets.only(top: 12),
                                            child: GestureDetector(
                                              onTap: () async {
                                                List<File>? images =
                                                    await ImagePickerFunctionsHelper
                                                        .pickMultipleImage(
                                                            context);

                                                prov.removeImage(index, images);
                                              },
                                              child: const Icon(
                                                Icons.photo_library_rounded,
                                                color: Color.fromARGB(
                                                    137, 245, 201, 201),
                                              ),
                                            ),
                                          )
                                        : const SizedBox(height: 0),
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
                        if (prov.showAddThread) {
                          prov.addNewThread(context);
                        }
                      },
                      child: ListTile(
                        contentPadding: const EdgeInsets.only(left: 19),
                        leading: Padding(
                          padding: const EdgeInsets.only(top: 1),
                          child: CircularNetworkImageWithSize(
                            imageUrl: prov.user[0].profilePic,
                            height: 20,
                            width: 20,
                          ),
                        ),
                        title: Text(
                          'Add to thread',
                          style: TextStyle(
                            fontSize: 14,
                            color: prov.showAddThread
                                ? Colors.grey
                                : Colors.grey.shade800,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
    });
  }
}
