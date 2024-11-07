import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:taskapp/app_helpers/asset_helper.dart';
 import 'package:taskapp/app_providers/task_provider.dart';

import '../../app_helpers/constant.dart';
import '../../app_widgets/card_widget.dart';
import '../../app_widgets/custom_textfield.dart';
 import '../../app_widgets/floating_button.dart';
import '../../app_widgets/task_field.dart';
import 'card_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
 final provider=   Provider.of<TaskProvider>(context, listen: false);
 provider.getTask(context);
 provider.checkInternet(context);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TaskProvider>(context, listen: false);
    return Scaffold(
        appBar: buildAppBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 5,
              ),
              CustomTextField(
                controller: searchController,
                onChanged: (value) {
                  provider.searchTask(value); // Call the search function
                },
              ),
              kheightBoxed(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // "My Tasks" Text
                  Text(
                    "My Tasks",
                    style: GoogleFonts.robotoSerif().copyWith(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  /// Toggle buttons for sorting
                  SizedBox(
                    height: 25,
                    child:Row(
                      children: [  Text("Sort by : ",   style: GoogleFonts.roboto().copyWith(
                        fontSize: 17.sp),
                  ),
                        Consumer<TaskProvider>(
                          builder: (context, provider, child) {
                            return ToggleButtons(
                              isSelected: [
                                provider.selectedFilter == 'By Name',
                                provider.selectedFilter == 'By Date',
                              ],
                              onPressed: (index) {
                                if (index == 0) {
                                  provider.filterByName(); // Sort by Name
                                } else if (index == 1) {
                                  provider.filterByDate(); // Sort by Date
                                }
                              },
                              borderRadius: BorderRadius.circular(8),
                              selectedColor: Colors.white,

                              fillColor: const Color(0xffadbce6), // Button color when selected
                              color: Colors.black87,
                              selectedBorderColor: const Color(0xffadbce6),
                              borderColor: Colors.grey.shade300,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 2),
                                  child: Text(
                                    'Name',
                                    style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                                  child: Text(
                                    'Date',
                                    style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),

                      ],
                    )
                  ),
                ],
              ),

              kheightBoxed(),
              CardList(provider: provider),
            ],
          ),
        ),
        floatingActionButton: FloatingButton(
          onTap: () {
            showBottomSheet(context);
          },
        ));
  }

  AppBar buildAppBar() {
    return AppBar(
        elevation: 0,
        backgroundColor: const Color(0xffF2F5FF),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(DateFormat('EEEE').format(DateTime.now()),
                style: GoogleFonts.robotoSerif().copyWith(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                )),
            Text(
              DateFormat('MMM dd, yyyy').format(DateTime.now()),
              style: TextStyle(
                fontSize: 15.sp,
                color: Colors.grey,
              ),
            ),
            const SizedBox(
              height: 5,
            )
          ],
        ),
        actions:const   [
          Padding(
            padding:  EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage:AssetImage(AssetHelper.bg),
child: Icon(Icons.person,color: Colors.white,),
            ),
          )
          // FilterButton()
        ],
      );
  }

  ///this is dialog for uploading task
  ///********************************************* Dialog *******************************************///

  showBottomSheet(context) {
    final provider = Provider.of<TaskProvider>(context, listen: false);

    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            backgroundColor: const Color(0xffF2F5FF),
            content: SingleChildScrollView(
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Upload New Task",
                      style: GoogleFonts.roboto().copyWith(
                          fontSize: 18.sp, fontWeight: FontWeight.bold),
                    ),
                    kheightBoxed(),

                    TaskField(controller: provider.taskName,
                      hintText: "Enter Task Name",
                    ),
                    kheightBoxed(),
                    TaskField(controller: provider.taskDescriptions,
                    hintText: "Enter Description",
                    maxLine: 3,
                    ),
                    kheightBoxed(),
                    Consumer<TaskProvider>(builder: (context, mdl, _) {
                      return InkWell(
                        onTap: () async {
                          provider.file = await provider.pickImage();
                          provider.updateState();
                        },
                        child: Container(
                          width: double.infinity,
                          height: 130,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: Colors.black45,
                              )),
                          child: provider.file != null
                              ? Image.file(
                            provider.file!,
                            fit: BoxFit.cover,
                          )
                              : Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Column(
                              children: [
                                Text(
                                  "Upload Photo",
                                  style: GoogleFonts.roboto().copyWith(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                ),
                                kheightBoxed(),
                                const Icon(
                                  Icons.image_outlined,
                                  size: 50,
                                  color: Colors.grey,
                                ),
                                kheightBoxed(),
                                Text("Upload JPG/PNG",
                                    style: GoogleFonts.roboto().copyWith(
                                        fontSize: 14.sp,
                                        color: Colors.grey)),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                    kheightBoxed(),
                    FittedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          FloatingButton(
                            color: Colors.white12,
                            onTap: () {
                              Navigator.pop(context);
                            },
                            text: "Cancel",
                          ),
                          kwidthBoxed(),
                          FloatingButton(
                            onTap: () {
                              if (provider.taskName.text.isEmpty) {
                                provider.showInfo(
                                    "Task Name is required", Colors.black);
                              } else if (provider
                                  .taskDescriptions.text.isEmpty) {
                                provider.showInfo(
                                    "Task Description is required",
                                    Colors.black);
                              } else if (provider.file == null) {
                                provider.showInfo(
                                    "Image file is required", Colors.black);
                              } else {
                                provider.showLoader(context);
                                provider.uploadTask(context).whenComplete(() {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  provider.file = null;
                                  provider.taskName.clear();
                                  provider.taskDescriptions.clear();
                                });
                              }
                            },
                            text: "Save",
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

}


