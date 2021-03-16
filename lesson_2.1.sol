pragma solidity >=0.5.0 <0.6.0;

contract ZombieFactory {

    event NewZombie(uint zombieId, string name, uint dna);

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    struct Zombie {
        string name;
        uint dna;
    }

    Zombie[] public zombies;                                        // For a financial app, storing a uint that holds the user's account balance:
                                                                           // mapping (address => uint) public accountBalance;
                                                                    // Or could be used to store / lookup usernames based on userId
                                                                           // mapping (uint => string) userIdToName;

    mapping (uint => address) public zombieToOwner;
    mapping (address => uint) ownerZombieCount;
            
                                                                  // In Solidity, there are certain global variables that are available to all functions.
                                                                  // One of these is msg.sender, which refers to the address of the person (or smart contract) who called the current function.                                                                
                                                                  
                                                                  //Note: In Solidity, function execution always needs to start with an external caller.
                                                                  //A contract will just sit on the blockchain doing nothing until someone calls one of its functions. So there will always be a msg.sender.
        
 */ mapping (address => uint) favoriteNumber;

function setMyNumber(uint _myNumber) public {
  // Update our `favoriteNumber` mapping to store `_myNumber` under `msg.sender`
  favoriteNumber[msg.sender] = _myNumber;
  // ^ The syntax for storing data in a mapping is just like with arrays
}

function whatIsMyNumber() public view returns (uint) {
  // Retrieve the value stored in the sender's address
  // Will be `0` if the sender hasn't called `setMyNumber` yet
  return favoriteNumber[msg.sender];
} */
        
    function _createZombie(string memory _name, uint _dna) internal {
        uint id = zombies.push(Zombie(_name, _dna)) - 1;
        zombieToOwner[id] = msg.sender;
        ownerZombieCount[msg.sender]++;
        emit NewZombie(id, _name, _dna);
    }

    function _generateRandomDna(string memory _str) private view returns (uint) {
        uint rand = uint(keccak256(abi.encodePacked(_str)));
        return rand % dnaModulus;
    }

    function createRandomZombie(string memory _name) public {
        require(ownerZombieCount[msg.sender] == 0);
        uint randDna = _generateRandomDna(_name);
        randDna = randDna - randDna % 100;
        _createZombie(_name, randDna);
    }

}
