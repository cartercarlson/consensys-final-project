## Guidelines

### Specifications
You will submit a final project containing the following items:
1. A project README.md that explains your project
	* What does your project do?
	* How to set it up
		* Run a local development server
2. Your project should be a truffle project
	* All contracts should be in a contracts directory
		* `truffle compile` should successfully compile contracts
	* Migration contract and scripts should work
		* `truffle migrate` should successfully migrate contracts to a locally
			running ganache-cli test blockchain on port 8545
	* All tests should be in a tests directory
		* `truffle test` should migrate contracts and run tests
3. Smart contract code should be commented according to the [documentation specs](https://solidity.readthedocs.io/en/v0.4.21/layout-of-source-files.html#comments)
4. Create at least 5 tests for each smart contract
	* Write a sentence or two explaining what the tests are covering, and explain
		why you wrote those tests
5. A development server to serve the front end interface of the application
6. A document called __design_pattern_decisions.md__ that explains why you chose to
	use the design patterns that you did
7. A document called __avoiding_common_attacks.md__ that explains what measures you
	took to ensure that your contracts are not susceptible to common attacks
8. A document called __deployed_addresses.txt__ that describes where your contracts live
	(which testnet and address)
9. Implement/use a library or EthPM package in your project

### Requirements
1. User interface requirements
	* Run the app on a dev server locally for testing/grading
	* You should be able to visit a URL and interact with the application
		* App recognizes account
		* Sign transactions with MetaMask or uPort
		* Contract state is updated
		* Update reflected in UI
2. Test requirements
	* Write 5 tests for each contract (Solidity or JavaScript)
	* explain why you wrote those tests
	* tests run with `truffle test`
3. Design pattern requirements
	* Implement an emergency stop plan
	* What other design patterns have you used/not used?
4. Security Tools/Common attacks
	* Explain what measures you've taken to ensure that your contracts are
		not susceptible to common attacks
5. Use a library or extend a contract
	* Via EthPM or write your own
6. Optional
	* Implement an upgradeable design pattern
	* Write a smart contract in LLL or Vyper
	* Integrate with an additional service
		* IPFS
		* uPort
		* ENS
		* Oracle
