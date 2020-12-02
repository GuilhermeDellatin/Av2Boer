bool emailValid(String email){

  final RegExp regex = RegExp(

      r"^(([^<>()[\]\\.,;:\s@\']+(\.[^<>()[\]\\.,;:\s@\']+)*)|(\'.+\'))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$");

  return regex.hasMatch(email);

}

bool cpfValid(String cpf){
  final RegExp regexCpf = RegExp(
  r"/^\d{3}\.\d{3}\.\d{3}\-\d{2}$/"
  );
}

 