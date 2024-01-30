import 'package:flutter/material.dart';
import 'package:seniors_connect/models/organisation.model.dart';
import 'package:seniors_connect/utils/firebase.services.dart';
import 'package:seniors_connect/utils/global.color.dart';
import 'package:seniors_connect/views/widget/filter.dialog.dart';
import 'package:seniors_connect/views/widget/organisation.item.dart';
import 'package:ionicons/ionicons.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  bool isLoaded = false;
  final TextEditingController controller = TextEditingController();
  final FocusNode focusNode = FocusNode();


  var _loading = false;

  List<Organisation> organisations = [];
  List<Organisation> backupOrganisations = [];
  @override
  void initState() {
    super.initState();
    getAllTheOrganisationData();
    controller.addListener(onSearchChanged);
  }

  onSearchChanged(){
    if(controller.text != "") {
      List<Organisation> showResult = [];
      organisations = backupOrganisations;

      for (var orgSnapShot in organisations) {
        var name = orgSnapShot.name.toLowerCase();
        if (name.startsWith(controller.text.toLowerCase())) {
          showResult.add(orgSnapShot);
        }
      }
      for (var orgSnapShot in organisations) {
        var name = orgSnapShot.name.toLowerCase();
        if (!showResult.contains(orgSnapShot) && name.contains(controller.text.toLowerCase())) {
          showResult.add(orgSnapShot);
        }
      }
      setState(() {
        organisations = showResult;
      });
    }else{
      setState(() {
        organisations = backupOrganisations;
      });

    }
  }


  @override
  void dispose() {
    controller.removeListener(onSearchChanged);
    controller.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    getAllTheOrganisationData();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: InkWell(
          onTap: (){
            focusNode.unfocus();
          },
          child: Container(
            padding: EdgeInsets.only(left: 12, right: 12),
            width: MediaQuery.of(context).size.width,
            color: GlobalColors.backgroundColor,
            child: Column(
              children: [
                SizedBox(height: 20,),
            Container(
              height: 50,
              padding: EdgeInsets.only(top: 0, left: 25, right: 25),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(35),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 7
                  )
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width-150,
                    child: TextFormField(
                      controller: controller,
                      obscureText: false,
                      focusNode: focusNode,
                      keyboardType: TextInputType.name,
                      style: TextStyle(
                          color: GlobalColors.textColor,
                          fontFamily: 'Medium',
                          fontSize: 14
                      ),
                      decoration: InputDecoration(
                          hintText: "Search",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(0),
                          hintStyle: TextStyle(
                              color: GlobalColors.hintColor,
                              height: 1
                          )
                      ),
                        onEditingComplete: () {
                          // searchByKey();
                          focusNode.unfocus();
                        }
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      // searchByKey();
                      focusNode.unfocus();
                    },
                    child: Icon(
                      Ionicons.search_sharp,
                      color: GlobalColors.mainColor,
                    ),
                  )
                ],
              ),
            ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap:(){
                        _showService(context);
                      },
                      child: Row(
                        children: [
                          Icon(Ionicons.filter),
                          SizedBox(width: 5,),
                          Text(
                            "All",
                            style: TextStyle(
                              color: GlobalColors.textColor,
                              fontSize: 15,
                              fontFamily: "bold"
                            ),
                          )
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        getAllTheOrganisationData();
                      },
                      child: Text(
                        "Refresh",
                        style: TextStyle(
                          fontFamily: "Bold",
                          color: GlobalColors.mainColor,
                          fontSize: 15
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 15,),
                Expanded(
                  child:
                  _loading? SpinKitCircle(
                    color: GlobalColors.mainColor,
                    size: 50.0,
                  ):ListView.builder(
                    itemCount: organisations.length,
                      itemBuilder: (context, index){
                        var data = organisations[index];
                        return OrganisationItem(organisation: data, onItemTap: getAllTheOrganisationData);
                      }
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showService(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return FilterDialog(getAllTheOrganisationData, filterAdminOrganisations, filterPendingOrganisations, filterApprovedOrganisations, filterRejectedOrganisations);// Use your custom dialog widget here
      },
    );
  }

  void filterAdminOrganisations(){
    _startLoading();
    FirebaseServices.getAdminOrganisations().then((fetchedOrganisations) {
      setState(() {
        organisations = fetchedOrganisations;
        backupOrganisations = fetchedOrganisations;
        _stopLoading();
      });
    });
  }

  void filterApprovedOrganisations(){
    _startLoading();
    FirebaseServices.getFilterOrganisations("Approved").then((fetchedOrganisations) {
      setState(() {
        organisations = fetchedOrganisations;
        backupOrganisations = fetchedOrganisations;
        _stopLoading();
      });
    });
  }

  void filterPendingOrganisations(){
    _startLoading();
    FirebaseServices.getFilterOrganisations("Pending").then((fetchedOrganisations) {
      setState(() {
        organisations = fetchedOrganisations;
        backupOrganisations = fetchedOrganisations;
        _stopLoading();
      });
    });
  }

  void filterRejectedOrganisations(){
    _startLoading();
    FirebaseServices.getFilterOrganisations("Rejected").then((fetchedOrganisations) {
      setState(() {
        organisations = fetchedOrganisations;
        backupOrganisations = fetchedOrganisations;
        _stopLoading();
      });
    });
  }

  void getAllTheOrganisationData() async {
    _startLoading();
    FirebaseServices.getFirestoreOrganisations().then((fetchedOrganisations) {
      setState(() {
        organisations = fetchedOrganisations;
        backupOrganisations = fetchedOrganisations;
        _stopLoading();
      });
    });
  }

  void _startLoading() {
    setState(() {
      _loading = true;
    });
  }

  void _stopLoading() {
    setState(() {
      _loading = false;
    });
  }

  void searchByKey() async {
    String key = controller.text;
    if(key.isNotEmpty){
      _startLoading();
      FirebaseServices.searchOrganisationsByName(key).then((fetchedOrganisations) {
        setState(() {
          organisations = fetchedOrganisations;
          backupOrganisations = fetchedOrganisations;
          _stopLoading();
        });
      });
    }else{
      getAllTheOrganisationData();
    }
  }

}
