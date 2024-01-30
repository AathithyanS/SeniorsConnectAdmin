import 'package:url_launcher/url_launcher.dart';

void openGoogleMaps(String address) async {
  // Encode the address to make it suitable for a URL
  String encodedAddress = Uri.encodeComponent(address);

  // Construct the Google Maps URL
  String googleMapsUrl = "https://www.google.com/maps/search/?api=1&query=$encodedAddress";

  // Launch the URL
  if (await canLaunch(googleMapsUrl)) {
    await launch(googleMapsUrl, forceWebView: false);
  } else {
    // Handle error, e.g., display an error message
    print("Could not launch Google Maps");
  }
}
