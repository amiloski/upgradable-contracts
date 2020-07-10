pragma solidity 0.5.0;
import "./Storage.sol";

contract Functional is Storage{

  constructor() public{
    owner = msg.sender;
  }

  modifier onlyOwner(){
    require(msg.sender == owner);
    _;
  }

  function getNumberOfDogs() public view returns(uint256){
    return _uintStorage["Dogs"];
  }

  function setNumberOfDogs(uint256 toSet) public{
    _uintStorage["Dogs"] = toSet;
  }

}
