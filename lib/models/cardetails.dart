class CardDetails {
  String accno = '';
  String date = '';
  String cvv = '';

  CardDetails({required this.accno, required this.date, required this.cvv});
}

class CardType {
  int cardIN = 0;
  var logo = 'none';
  void logoIN(var value) {
    if (value.toString().startsWith('4')) {
      logo = 'visa';
    } else if (value.toString().startsWith('5')) {
      logo = 'mastercard';
    } else if (value.toString().startsWith('6')) {
      logo = 'rupay';
    } else {
      logo = 'none';
    }
  }

  var logomap = {
    'visa': 'Visa-Logo.jpg',
    'mastercard': 'ma-bc_mastercard-logo_eq.png',
    'rupay': 'Rupay-Logo.png',
    'none': 'none'
  };
}
