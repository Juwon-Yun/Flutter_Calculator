class NumberFormatter{
  static String format(String text){
    try{
      double parsedNumber = double.parse(text);
      if(parsedNumber != double.infinity && parsedNumber == parsedNumber.floor()){
        // truncate => 소수점 내림
        return parsedNumber.truncate().toString();
      }
      return text;
    } catch(err){
      return text;
    }
  }
}