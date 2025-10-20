class Dataprocessing {
 static double MyWeight = 0;
 static double Duration = 0;
  int maintainence = 2200;
  int Energy = 7700;
  late double TotalDeficit;
  late double days;
  late double dailydeficit;
  late double DailyCalorie;
  late double carbs;
  late double protein;
  late double fats;
  late List<double> Macro=[];
  void dataPrint(String text) {
    // print('$text');
  }

 static void UpdateWeight(double weight) {
    MyWeight = weight;
    print(MyWeight);
  }

 static void UpdateDuration(double duration) {
    Duration = duration;
    print(Duration);
  }

 

  void  MacroSplit() {
   
    TotalDeficit = MyWeight * Energy;

    days = Duration * 30.4;
    dailydeficit = TotalDeficit / days;
    dailydeficit = dailydeficit > 1200 ? 1200 : dailydeficit;
    DailyCalorie = maintainence - dailydeficit;
    

    carbs = ((DailyCalorie * .45) / 4);
    protein = ((DailyCalorie * .30) / 4);
    fats = ((DailyCalorie * .25) / 9);

    // print(carbs);

    carbs = carbs % 10 > 5 ? (10 - carbs % 10) + carbs : carbs - carbs % 10;
    protein =
        protein % 10 > 5
            ? (10 - protein % 10) + protein
            : protein - protein % 10;
    fats = fats % 10 > 5 ? (10 - fats % 10) + fats : fats - fats % 10;


    if (Macro.isEmpty){
      Macro.addAll([carbs,protein,fats]);
    }else if (Macro[0]!=carbs){
      Macro.addAll([carbs,protein,fats]);
    }else{
      Macro = Macro;
    }    


    print(Macro);
    
  }
}
