import 'package:flutter/material.dart';

//BASE URL
//TODO change to https after certificates have been configured
const kInUrl = "http://176.58.97.72:3000/api";
const kLocUrl = "http://192.168.100.3:3000/api";
const kSourceIp = "http://192.168.100.3";
const kPort = 3000;

//TODO Change as needed these and add them to the image url data
const uploadedImageUrlBase = "$kSourceIp:$kPort";

const kBaseUrl = kLocUrl;

//STATIC USER ID
const kUserId = 72;
const kNetworkImage =
    "https://cdn.pixabay.com/photo/2020/08/01/10/04/alpine-5455013_640.jpg";
const kStatusId = 1;

//COLORS
//primary color
//secondary color
//accent color

//TODO remove all unnecessary colors and remain with only these three colors
const kPrimaryColor = Color(0xFF3d2352);
const kAccentColor = Colors.lightBlueAccent;
const kScaffoldBackgroundColor = Colors.white;
const kColorButtons = Colors.blue;
const kRedAlert = Color(0xFFE46C6D);
const kMyBidsColor = Color(0xFF175A9E);
const kMyJobsColor = Color(0xFF02BBCA);
const kMySettingsColor = Color(0xFFF39402);

//TEXT
const kStatusExplanation =
    "This is the current status of the service. It may change without notice";
const kTravelPromptExplanation =
    "This is important in case the service would require you to travel";
const kReviewOnSuccessfulCompletion =
    "Congratulations. The job has been successfully completed. Status changes can be viewed as soon as the page is refreshed. Please take some time to review the ";

const kExampleCurrency = 'KES';
const kJobs = "Jobs";
const kBids = "Bids";
const kInformation = "Info";
const kLoremIpsum =
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.';
const kLoremIpsumShort =
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit';
const kExampleRatingText = 4.5;
const kExampleBidPrice = 999.0;
const kPercentage = 99;
const kExampleNameMale = 'John Doe';
const kExampleNameFemale = 'Jane Doe';
const kExampleCompanyName = 'Example Company';
const kExampleEmail = 'user@example.com';
const kExamplePhone = '+254 777000777';
const kNumberTotal = '1/4';
const kClient = 'Client';
const kAgent = 'Agent';
const kBidNotice =
    'The client will receive your profile information when you bid for their work';

//SIZES
const kMainHorizontalPadding = 12.0;
const kElevationValue = 10.0;
const kBorderRadius = 10.0;

//TODO Have few text styles
//primary text style
//secondary text style
//accent text style
//TEXT STYLES
const kHeadingTextStyle = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold,
);

const kHeadingSubTextStyle = TextStyle(
  fontSize: 18,
  color: Colors.black54,
);

const kMainBlackTextStyle = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 15.0,
    height: 1.3);

const kBottomNavText = TextStyle(
  fontSize: 15,
  fontWeight: FontWeight.bold,
  color: Colors.black54,
);

const kAppBarTitle = TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.w700,
  fontSize: 30.0,
  letterSpacing: 1,
);

const kTestTextStyleWhite = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontSize: 20.0,
  letterSpacing: 1.2,
);

const kTestTextStyleBlack = TextStyle(
  color: Colors.black54,
  fontWeight: FontWeight.bold,
  fontSize: 20.0,
  letterSpacing: 1.2,
);

String budget(budgetMin, budgetMax) {
  if (budgetMin > budgetMax) {
    return "$budgetMax - $budgetMin";
  } else {
    return "$budgetMin - $budgetMax";
  }
}

int hexColConvert(String color) {
  String text = color; //get the color
  String repWith =
      '0xFF'; //initialize the first chars to use for full opacity ie 0x 'FF'
  List<String> textArray = new List(); //declare an empty list

  textArray = text.split(
      ''); //split the color data referenced by the text variable into an array of characters
  textArray.remove('#'); //from the array, remove this specific item
  textArray.insert(
      0, repWith); //replace the 0th index item with the 0xFF value we created
  var concat =
      StringBuffer(); //create a string buffer to use to cast the array into a string

  textArray.forEach((element) {
    concat.write(element);
  }); //cast the array into a string buffer

  String col =
      concat.toString(); //convert the string buffer into a usable string

  return int.parse(col);
  //parse the string into an integer and return that value
}
