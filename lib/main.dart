import 'package:flutter/material.dart';
import 'package:seniors_connect/models/organisation.model.dart';
import 'package:seniors_connect/utils/firebase.services.dart';
import 'package:seniors_connect/views/splash.view.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  MyApp({super.key}){
    // List<Organisation> organisations = [
      // Organisation(
      //   name: "Bernard Betel Centre",
      //   address: "1003 Steeles Ave W Toronto, ON M2R 3T6",
      //   phone: "416-225-2112 ext. 103",
      //   email: "lilyb@betelcentre.org",
      //   website: "http://www.betelcentre.org/",
      //   services:
      //   "They offer multilingual educational, cultural and wellness programs for adults 55 and plus. Such as Arts, Fitness and dance, languages, food services and much more.",
      // ),
      // Organisation(
      //   name: "Better Living and Community Services",
      //   address: "1 Overland Dr Toronto ON, M3C 2C3",
      //   phone: "416-447-7244 ext. 622",
      //   email: "No email available",
      //   website: "http://www.mybetterliving.ca/",
      //   services:
      //   "They offer social, recreational, and educational activities such as fitness classes, recreation, card games, arts, and cultural programs and more for adults 55 years and older.",
      // ),
      // Organisation(
      //   name: "York West Active Living Centre",
      //   address: "1901 Weston Rd Toronto, ON M9N 3P5",
      //   phone: "416-245-4395",
      //   email: "info@ywalc.ca",
      //   website: "http://www.ywalc.ca/",
      //   services:
      //   "They offer Wellness and Health programs for a range of seniors such as card games, craft groups, dance classes, water coloring and more.",
      // ),
      // Organisation(
      //   name: "Latvian Seniors Citizen Association",
      //   address: "4 Credit Union Toronto ON, M4A 2N8",
      //   phone: "416-759-4900",
      //   email: "office@latviancentre.org",
      //   website: "http://www.latviancentre.org/",
      //   services:
      //   "They provide services for adults 60 years or older through activities such as crafts and arts, choral singing, and other activities.",
      // ),
      // Organisation(
      //   name: "First Portuguese Canadian Cultural Centre",
      //   address: "60 Caledonia Rd, Toronto ON, M6E 4S4",
      //   phone: "416-531-9971",
      //   email: "fpccc@firstportuguese.com",
      //   website: "http://www.firstportuguese.com/",
      //   services:
      //   "They offer social activities for adults 55 years and more through Bingo, arts & crafts, music, exercise classes and so much more.",
      // ),
      // Organisation(
      //   name: "Art Start",
      //   address: "3401 Dufferin St, Toronto, ON, M6A 2T9",
      //   phone: "416-656-9994",
      //   email: "info@artstartsto.com",
      //   website: "www.artstartsto.com",
      //   services:
      //   "They help vulnerable people of all ages through arts, sewing, painting, music, storytelling, drumming, and more.",
      // ),
      // Organisation(
      //   name: "Waterfront Neighbourhood Centre",
      //   address: "627 Queens Quay W. Toronto, ON M5V 3G3",
      //   phone: "416-392-1509/416-684-0798",
      //   email: "info@waterfrontnc.ca",
      //   website: "http://www.waterfrontnc.ca",
      //   services:
      //   "They offer a wide range of services especially for seniors 55+ through arts, dance & singing, crafting, education, and social.",
      // ),
      // Organisation(
      //   name: "Will Power",
      //   phone: "416-241-5124",
      //   address: "Not available",
      //   email: "info@urbanartstoronto.org",
      //   website: "http://www.willpower.ca",
      //   services:
      //   "It is a charity organization that reflects the community diversity and vibrancy. They are enriching the lives of children, youth, and seniors through arts.",
      // ),
      // Organisation(
      //   name: "To Live",
      //   address: "1 Front St. E. Toronto, ON, M5E 1B2",
      //   phone: "416-368-6161",
      //   email: "info@tolive.com",
      //   website: "http://www.tolive.com",
      //   services:
      //   "They provide a range of services for all ages such as art & wellness, community/adult programs, workshops, and more.",
      // ),
      // Organisation(
      //   name: "The Disability Collective",
      //   address: "Not available",
      //   email: "ali@thedisabilitiescollective.com",
      //   website: "http://www.thedisabilitycollective.com",
      //   phone: "Not available",
      //   services:
      //   "It is a fully disability-led performing arts organization in Toronto. They empower people with disabilities by giving them opportunities to share their work in a variety of forms to overcome the stigmatize and negative perceptions.",
      // ),
      // Organisation(
      //   name: "Steps Public Art",
      //   address: "39 Queens Quay E, Suite 100 Toronto, ON, M5E 0A4",
      //   phone: "1888-783-7780",
      //   email: "info@stepspublicart.org",
      //   website: "http://www.stepspublicart.org",
      //   services:
      //   "They provide resources for the artists that have project’s concept to reality.",
      // ),
    //   Organisation(
    //     name: "Generator",
    //     address: "Unit, 204, 427 Bloor St W. Toronto, On",
    //     phone: "Not available",
    //     email: "patricia@generatorTO.com",
    //     website: "http://www.generatorto.com",
    //     services: "Generator is mentoring, teaching, and helping artists to expand their skills and provide tools.",
    //   ),
    //   Organisation(
    //     name: "Harbourfront Centre",
    //     address: "235 Queens Quay West Toronto ON, M5J 2G8",
    //     phone: "416-973-4600",
    //     email: "info@harbourfrontcentre.com",
    //     website: "http://www.harbourfrontcentre.com",
    //     services: "They provide help through craft & Design, music, performing arts, and more.",
    //   ),
    //   Organisation(
    //     name: "Neighbourhood Arts Network",
    //     address: "32 Camden St Toronto, ON M5V 1V1",
    //     phone: "Not available",
    //     email: "angie@torontoarts.org",
    //     website: "http://www.neighbourhoodartsnetwork.org",
    //     services: "They offer accessible arts programming, awards for Toronto-based artists, arts educators, and arts organizations.",
    //   ),
    // ];
    // saveData(organisations);
  }

  // saveData(List<Organisation> organisations) async {
  //   for(Organisation org in organisations){
  //     await FirebaseServices.saveOrganisation(org);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashView(),
    );
  }
}