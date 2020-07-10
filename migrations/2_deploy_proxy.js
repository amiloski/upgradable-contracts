const Functional = artifacts.require('Functional');
const FunctionalUpdated = artifacts.require('FunctionalUpdated');
const Proxy = artifacts.require('Proxy');

module.exports = async function(deployer, network, accounts){
  // Deploy contracts
  const functional = await Functional.new();
  const proxy = await Proxy.new(functional.address);

  // creates an instance of the Functional contract but from an already existing
  // deployed contract. This only works because our proxy can handle function
  // requests to the Functional contract
  var proxyFunc = await Functional.at(proxy.address)

  // This is the contract we are always going to interact switch
  // Set variable through the proxy contract
  // Truffle believes proxyFunc is a Functional Contract
  await proxyFunc.setNumberOfDogs(10);

  var numDogs = await proxyFunc.getNumberOfDogs();
  console.log("Before Update: " + numDogs.toNumber());

  //Obs: if we were to check this variable directly from the functional contract, it would be 0
  numDogs = await functional.getNumberOfDogs();
  console.log("This won't work: " + numDogs.toNumber());

  // run the upgrade function on the proxy contract -- deploy new version of functionalContract
  const FunctionalUpdated = await FunctionalUpdated.new();
  proxy.upgrade(FunctionalUpdated.address);

  // need to reasign if functionality was implemented
  proxyFunc = await FunctionalUpdated.at(proxy.address);
  // initialize the proxy state
  proxyFunc.initialize(accounts[0]) // truffle buit-in accounts array. 0 is our own address

  //Now that we have upgrade, the value should be the same
  numDogs = await proxyFunc.getNumberOfDogs();
  console.log("After update: " + numDogs.toNumber());

  // This won't work since the state that is being used is the proxy own state, not the functional contract
  await proxyFunc.setNumberOfDogs(30);
}
