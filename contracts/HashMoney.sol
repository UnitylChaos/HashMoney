pragma solidity ^0.4.17;

import "../installed_contracts/tokens/contracts/eip20/EIP20.sol";

contract HashMoney is EIP20 {
  string public name = "HashMoney";
  uint8 public decimals = 18;
  string public symbol = "HMX";

  uint public MIN_BLOCK_DELAY = 1000;

  function HashMoney() EIP20(0,name,decimals,symbol) public {

  }

  struct Claim {
    uint blocknum;
    uint numZeroes;
    bytes32 blockhash;
  }


  mapping(address => Claim) public pastClaims;

  function claim(uint nonce) public {
    Claim memory cur = pastClaims[msg.sender];
    uint LZ;
    if (cur.blocknum == 0) {
      LZ = countLeadingZeroes(keccak256(msg.sender, nonce));
    } else {
      require(block.number > cur.blocknum + MIN_BLOCK_DELAY);
      LZ = countLeadingZeroes(keccak256(msg.sender, cur.blockhash, nonce));
      balances[msg.sender] += (uint(1)) << ((LZ + cur.numZeroes)/2);
    }
    pastClaims[msg.sender] = Claim(block.number, LZ, block.blockhash(block.number));
  }

  function countLeadingZeroes(bytes32 x) public pure returns (uint) {
    for (uint i = 0; i < 256; i++) {
      if (uint(x[i/8])&(uint(1)<<(7-(i%8))) != 0) {
        return i;
      }
    }
  }
}
