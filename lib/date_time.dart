String parseDate(String dateToParse){
  var year = DateTime.parse(dateToParse).year;
  var month = DateTime.parse(dateToParse).month;
  var day = DateTime.parse(dateToParse).day;

  return "$year/$month/$day";
}