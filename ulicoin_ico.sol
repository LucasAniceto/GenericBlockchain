// URL para compilar
//http://remix.ethereum.org/#appVersion=0.7.7&optimize=false&version=soljson-v0.4.11+commit.68ef5810.js

//ico ulicoin

//versão
pragma solidity ^0.4.11;
 
contract ulicoin_ico {
 
    //número máximo de ulicoins disponíveis no ICO		 
    uint public max_ulicoins = 1000000;
    //Taxa cotacao do ulicoin por dolar	
    uint public usd_to_ulicoins = 1000;
    //total de ulicoins compradas por investidores	
    uint public total_ulicoins_bought = 0;
    
    //funcoes de equivalencia
    mapping(address => uint) equity_ulicoins;
    mapping(address => uint) equity_usd;
 
    //verificando se o investidor por comprar ulicoins
    modifier can_buy_ulicoins(uint usd_invested) {
        require (usd_invested * usd_to_ulicoins + total_ulicoins_bought <= max_ulicoins);
        _;
    }
 
    //retorna o valor do investimento em ulicoins 	
    function equity_in_ulicoins(address investor) external constant returns (uint){
        return equity_ulicoins[investor];
    }
 
    //retorna o valor do investimento em dolares
    function equity_in_usd(address investor) external constant returns (uint){
        return equity_usd[investor];
    }
 
    //compra de ulicoins 
    function buy_ulicoins(address investor, uint usd_invested) external 
    can_buy_ulicoins(usd_invested) {
        uint ulicoins_bought = usd_invested * usd_to_ulicoins;
        equity_ulicoins[investor] += ulicoins_bought;
        equity_usd[investor] = equity_ulicoins[investor] / 1000;
        total_ulicoins_bought += ulicoins_bought;
    }
 
    //venda de ulicoins
    function sell_ulicoins(address investor, uint ulicoins_sold) external {
        equity_ulicoins[investor] -= ulicoins_sold;
        equity_usd[investor] = equity_ulicoins[investor] / 1000;
        total_ulicoins_bought -= ulicoins_sold;
    }
    
    
    
    
}
