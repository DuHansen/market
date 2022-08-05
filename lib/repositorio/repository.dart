import '../models/moeda.dart';

class MoedaRepository {
  static List<Moeda> tabela = [
    Moeda(
        icone: 'images/1inch.png', nome: '1inch', sigla: '1in', preco: 455545),
    Moeda(
        icone: 'images/bitcoin.png',
        nome: 'BitCoin',
        sigla: 'BTC',
        preco: 22000),
    Moeda(icone: 'images/eth.png', nome: 'Ethereum', sigla: 'ETH', preco: 3754),
  ];
}
