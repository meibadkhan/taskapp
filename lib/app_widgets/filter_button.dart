 import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../app_providers/task_provider.dart';
 class FilterButton extends StatelessWidget {
   const FilterButton({
     super.key,
   });

   @override
   Widget build(BuildContext context) {
     return Container(
       margin: const EdgeInsets.symmetric(horizontal: 15),
       width: 50,
       height: 40,
       decoration: BoxDecoration(
         color: Colors.white,
         borderRadius: BorderRadius.circular(5),
         boxShadow:const [
            BoxShadow(
             color: Colors.black12,
             spreadRadius: 0.3,
             blurRadius: 2,
           ),
         ],
       ),
       child: Consumer<TaskProvider>( // Use Consumer to access the provider
         builder: (context, provider, child) {
           return PopupMenuButton<String>(
             padding: EdgeInsets.zero,
             onSelected: (value) {
               if (value == 'By Date') {
                 provider.filterByDate();
               } else if (value == 'By Name') {
                 provider.filterByName();
               }
             },
             icon: const Icon(Icons.tune, size: 26),
             color: Colors.white,
             shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(10),
             ),
             itemBuilder: (BuildContext context) => [

               PopupMenuItem(
                 value: 'By Date',
                 child: Row(
                   children: [

                     const Icon(Icons.calendar_today,size: 18, ),
                     const SizedBox(width: 8),
                     Text(
                       'Date',
                       style: TextStyle(
                         color: Colors.black87,
                         fontSize: 16.sp,
                         fontWeight: FontWeight.w500,
                       ),
                     ),
                     Transform.scale(
                       scale: 0.7,
                       child: Checkbox(

                         value: provider.selectedFilter == 'By Date',
                         onChanged: (_) {
                           provider.filterByDate();
                           Navigator.pop(context); // Close popup after selection
                         },
                       ),
                     ),
                   ],
                 ),
               ),
               PopupMenuItem(
                 value: 'By Name',
                 child: Row(
                   children: [

                     const Icon(Icons.sort_by_alpha,size: 18, ),
                     const SizedBox(width: 8),
                     Text(
                       'Name',
                       style: TextStyle(
                         color: Colors.black87,
                         fontSize: 16.sp,
                         fontWeight: FontWeight.w500,
                       ),
                     ),
                     Transform.scale(
                       scale: 0.7,
                       child:  Checkbox(
                         value: provider.selectedFilter == 'By Name',
                         onChanged: (_) {
                           provider.filterByName();
                           Navigator.pop(context); // Close popup after selection
                         },
                       ),
                     ),
                   ],
                 ),
               ),
             ],
           );
         },
       ),
     );
   }
 }

