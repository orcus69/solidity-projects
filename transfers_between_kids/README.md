# First SmartContract in Ethereum network
Remix example project is present when Remix loads very first time or there are no files existing in the File Explorer. 
It contains 3 directories:

1. 'contracts': Holds three contracts with different complexity level, denoted with number prefix in file name.
2. 'scripts': Holds two scripts to deploy a contract. It is explained below.
3. 'tests': Contains one test file for 'Ballot' contract with unit tests in Solidity.



## SCRIPTS

The 'scripts' folder contains example async/await scripts for deploying the 'Storage' contract.
For the deployment of any other contract, 'contractName' and 'constructorArgs' should be updated (along with other code if required). 
Scripts have full access to the web3.js and ethers.js libraries.

To run a script, right click on file name in the file explorer and click 'Run'. Remember, Solidity file must already be compiled.

Output from script will appear in remix terminal.

## How this smartcontract works

**Trust.sol** is the contract written, on it you can transfer funds from your address to another address passinig a timestamp as condition to another contract can widthdraw the staked funds.
so you choose the address to send some ether and put some condition of time like (0x5B38Da6a701c568545dCfcB03FcB875f56beddC4, 30).
the first parameter is the destiny address and the secund is a timestamp in secunds. 
the destiny address only be able to withdraw the staked ether if the condition of time be came true, in this exemple was 30 secunds. 
If another diferent address try to intercept(withdraw) the staked ether the smartcontract will see thats not the right address and send a message 'only kid can withdraw'.

