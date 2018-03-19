pragma solidity ^0.4.17;

import "../installed_contracts/tokens/contracts/eip20/EIP20.sol";

contract HashMoney is EIP20 {
  string public name = "HashMoney";
  uint8 public decimals = 18;
  string public symbol = "HMX";

  function HashMoney() EIP20(0,name,decimals,symbol) public {

  }

  mapping(address => uint) public pastClaims;

  function claim(uint nonce) public {
    require(nonce > pastClaims[msg.sender]);
    bytes32 h = keccak256(msg.sender, nonce);
    balances[msg.sender] += (uint(1) << countLeadingZeroes(h));
    pastClaims[msg.sender] = nonce;
  }

  function countLeadingZeroes(bytes32 x) public returns (uint) {
    for (uint i = 0; i < 256; i++) {
      if (uint(x[i/8])&(uint(1)<<(7-(i%8))) != 0) {
        return i;
      }
    }
  }
}
