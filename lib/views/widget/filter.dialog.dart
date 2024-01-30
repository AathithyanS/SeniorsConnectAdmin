import 'package:flutter/material.dart';
import 'package:seniors_connect/utils/global.color.dart';
import 'package:ionicons/ionicons.dart';
import 'package:seniors_connect/views/home.view.dart';
import 'package:seniors_connect/views/widget/button.form.dart';
import 'package:seniors_connect/views/widget/filter.button.dart';

class FilterDialog extends StatelessWidget {
  FilterDialog(this.filterAllOrganisations, this.filterAdminOrganisations, this.filterPendingOrganisations, this.filterApprovedOrganisations, this.filterRejectedOrganisations);

  final VoidCallback filterAllOrganisations;
  final VoidCallback filterAdminOrganisations;
  final VoidCallback filterPendingOrganisations;
  final VoidCallback filterApprovedOrganisations;
  final VoidCallback filterRejectedOrganisations;


  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Container(
        height: 380,
        width: 280,
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                SizedBox(width: 40,),
                Expanded(
                    child: Text(
                      "Filter Organisation",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: GlobalColors.mainColor,
                          fontSize: 15,
                          fontFamily: "semiBold"
                      ),
                    )
                ),
                IconButton(
                  icon: Icon(
                    Ionicons.close_circle_outline,
                    color: GlobalColors.mainColor,
                  ),
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 20,),
                    TextButton(
                        onPressed:(){
                          filterAllOrganisations();
                          Navigator.of(context).pop();
                        },
                        child: FilterButton(text: "All posts")
                    ),
                    TextButton(
                      onPressed:(){
                        filterAdminOrganisations();
                        Navigator.of(context).pop();
                      },
                      child: FilterButton(text: "Admin posts")
                    ),
                    TextButton(
                      onPressed:(){
                        filterPendingOrganisations();
                        Navigator.of(context).pop();
                      },
                      child: FilterButton(text: "Pending posts")
                    ),
                    TextButton(
                      onPressed:(){
                        filterApprovedOrganisations();
                        Navigator.of(context).pop();
                      },
                      child: FilterButton(text: "Approved posts")
                    ),
                    TextButton(
                      onPressed:() async {
                        filterRejectedOrganisations();
                        Navigator.of(context).pop();
                      },
                      child: FilterButton(text: "Rejected posts")
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}