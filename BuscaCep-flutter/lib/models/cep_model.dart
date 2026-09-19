import 'dart:convert';

class CepModel {
	final String cep;
	final String logradouro;
	final String complemento;
	final String unidade;
	final String bairro;
	final String localidade;
	final String uf;
	final String estado;
	final String regiao;
	final String ibge;
	final String gia;
	final String ddd;
	final String siafi;

	CepModel({
		required this.cep,
		required this.logradouro,
		required this.complemento,
		required this.unidade,
		required this.bairro,
		required this.localidade,
		required this.uf,
		required this.estado,
		required this.regiao,
		required this.ibge,
		required this.gia,
		required this.ddd,
		required this.siafi,
	});

	factory CepModel.fromJson(Map<String, dynamic> json) {
		return CepModel(
			cep: json['cep'] as String? ?? '',
			logradouro: json['logradouro'] as String? ?? '',
			complemento: json['complemento'] as String? ?? '',
			unidade: json['unidade'] as String? ?? '',
			bairro: json['bairro'] as String? ?? '',
			localidade: json['localidade'] as String? ?? '',
			uf: json['uf'] as String? ?? '',
			estado: json['estado'] as String? ?? '',
			regiao: json['regiao'] as String? ?? '',
			ibge: json['ibge'] as String? ?? '',
			gia: json['gia'] as String? ?? '',
			ddd: json['ddd'] as String? ?? '',
			siafi: json['siafi'] as String? ?? '',
		);
	}

	Map<String, dynamic> toJson() {
		return {
			'cep': cep,
			'logradouro': logradouro,
			'complemento': complemento,
			'unidade': unidade,
			'bairro': bairro,
			'localidade': localidade,
			'uf': uf,
			'estado': estado,
			'regiao': regiao,
			'ibge': ibge,
			'gia': gia,
			'ddd': ddd,
			'siafi': siafi,
		};
	}

  @override
  String toString() {
    return jsonEncode(toJson());
  }

}