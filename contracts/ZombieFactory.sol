// SPDX-License-Identifier: MIT

pragma solidity 0.8.16;

import "./Interfaces/IZombieFactory.sol";

contract ZombieFactory is IZombieFactory {
    uint256 private dnaDigits = 16;
    uint256 private idCounter = 0;
    uint256 internal dnaModulus = 10**dnaDigits;

    struct Zombie {
        string name;
        uint256 dna;
    }

    Zombie[] public zombies;

    mapping(uint256 => address) public zombieToOwner;
    mapping(address => uint256) private ownerZombieCount;

    function _createZombie(string calldata _name, uint256 _dna) internal {
        zombies.push(Zombie(_name, _dna));
        uint256 newZombieId = ++idCounter;
        zombieToOwner[newZombieId] = msg.sender;
        ownerZombieCount[msg.sender]++;
        emit ZombieFactory__NewZombie(newZombieId, _name, _dna);
    }

    function _generateRandomDna(string memory _str)
        private
        view
        returns (uint256)
    {
        return uint256(keccak256(abi.encodePacked((_str)))) % dnaModulus;
    }

    function createRandomZombie(string calldata _name) public override {
        if (ownerZombieCount[msg.sender] != 0)
            revert ZombieFactory__ZombieAlreadyCreated();
        uint256 randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }
}
