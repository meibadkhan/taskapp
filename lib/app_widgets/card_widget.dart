import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:taskapp/app_models/task_model.dart';

import '../app_helpers/asset_helper.dart';
import '../app_helpers/constant.dart';
import '../app_screens/home_screens/home_screen.dart';

class TaskCard extends StatelessWidget {
  final TaskListData task;

  const TaskCard({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: const DecorationImage(
          image: AssetImage(AssetHelper.bg),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 12,right: 12,left: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 80,
                  height: 50,

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border:Border.all(color: Colors.white),

                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Padding(
                        padding: const EdgeInsets.all(2.0),
                    
                        child:CachedNetworkImage(
                          
                          imageUrl: task.media[0].originalUrl,
                          placeholder: (context, url) =>const Center(child:  CircularProgressIndicator()),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                          fit: BoxFit.cover,
                          
                        ),

                    ),
                  ),
                ),
                kwidthBoxed(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      task.taskName,
                      style: GoogleFonts.roboto().copyWith(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),

                    Row(

                      children: [
                      const Icon(Icons.date_range_outlined,size: 15,),
                      Text(" ${DateFormat('MMM dd, yyyy').format(task.date)}",
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: Colors.black54,
                        ),
                      ),
                    ],)

                  ],
                ),

              ],
            ),
            kheightBoxed(),
            Text("Description:",style:GoogleFonts.roboto().copyWith(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16.sp),),
            Text(task.description,style:GoogleFonts.roboto().copyWith(
              fontSize: 15.sp,
            ),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),


            kheightBoxed(),
            task.isComplete=="1" ?Center(
              child: Container(
                width: 150,

                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(6),topRight: Radius.circular(6))
                ),
                child: const Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Completed ",style: TextStyle(color: Colors.green),),
                        Icon(Icons.check_box_outlined,size: 16,color: Colors.green,)
                      ],
                    ),
                  ),
                ),
              ),
            ):const SizedBox()
          ],
        ),
      ),
    );
  }
}
