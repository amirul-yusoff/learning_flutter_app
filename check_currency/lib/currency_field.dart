class CurrencyField {
  var base = "", date = "", exchangeRates = "";
  CurrencyField(this.base, this.date, this.exchangeRates);
}

class NewCurrency {
  //modal class for Person object
  String key, rate;
  NewCurrency({required this.key, required this.rate});
}
