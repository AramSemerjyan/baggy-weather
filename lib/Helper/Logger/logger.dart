/// This is totally unnecessary and I know that there could (or should) be
/// a specific package for this kind of fancy logging mechanism, but in cases
/// when the task doesn't required serious working logic, I prefer to write it
/// by myself (for learning purposes and cause I'm afraid of other developers lib :D )
void printLog({String title = "Weather App", dynamic content}) {
  print("=========== $title ===========");
  print(content);
  print("==============================");
}
