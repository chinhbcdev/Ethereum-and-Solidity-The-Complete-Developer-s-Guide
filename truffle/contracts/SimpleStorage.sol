// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;
contract Lottery {
  address public manager;
  address [] public  players;

  constructor() {
    manager=msg.sender;
  }

  function join() public payable{
    require (msg.value == 1 ether);
    players.push(msg.sender);
    //payable (msg.sender).transfer(msg.value);
  }
  function getRand() private view returns (uint){
    return uint(keccak256(abi.encodePacked(block.timestamp, block.number , block.number)));
  }
  function pickWinner() public {
    require (msg.sender==manager);
    address winner = players[getRand() % players.length];
    payable(winner).transfer(address(this).balance);
  }
}
