pragma solidity 0.5.0;
import "./Storage.sol";


// Obs: another way to update this contract is to inherit from the old Functional contract
// contract FunctionalUpdated is Functional
// this way we limit update risks, only adding new functionality.
// We need to rebuild it entirely if it is the case that we want to redefine functions however

contract FunctionalUpdated is Storage{

  // DON'T ADD ANY STATE VARIABLES IN THIS CONTRACT
  // ONLY USE VARIABLES FROM STORAGE

  constructor() public{
    initialize(msg.sender);
  }

  modifier onlyOwner(){
    require(msg.sender == owner);
    _;
  }

  function initialize(address _owner) public{
    //this function should only be able to run once
    require(!_initialized);
    owner = _owner;
    _initialized = true;
  }

  function getNumberOfDogs() public view returns(uint256){
    return _uintStorage["Dogs"];
  }

  function setNumberOfDogs(uint256 toSet) public onlyOwner{
    _uintStorage["Dogs"] = toSet;
  }

}
