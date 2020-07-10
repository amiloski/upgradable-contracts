pragma solidity 0.5.0;

contract Storage{

  // 1 mapping for each datatype
  mapping (string => uint256) _uintStorage;
  mapping (string => address) _addressStorage;
  mapping (string => bool) _boolStorage;
  mapping (string => string) _stringStorage;
  mapping (string => bytes4) _bytesStorage;

  // this way we can always add another variable by doing:
  // _uintStorage["Number"] = 10; //Number is the name of the variable

  address public owner;
  bool public _initialized;

}
