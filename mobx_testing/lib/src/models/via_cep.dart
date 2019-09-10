import 'package:mobx/mobx.dart';
import 'package:dio/dio.dart';
import 'package:mobx_testing/src/models/address.dart';

part 'via_cep.g.dart';

class ViaCep = ViaCepBase with _$ViaCep;

abstract class ViaCepBase with Store {
  @observable
  String cep = "";
  @observable
  AddressModel address = AddressModel.limpo();

  @action
  getData() async {
    if(cep.length != 8)
      return AddressModel.limpo();
    Response response = await Dio().get(url(this.cep));
    address = AddressModel.fromJson(response.data);
  }

  String url(String cep) => 'https://viacep.com.br/ws/$cep/json/';
}
