String maskCardNumber(String cardnumber) {
  return "**** **** **** ${cardnumber.substring(cardnumber.length - 4)}";
}
