// SPDX-License-Identifier: MIT

pragma solidity 0.8.16;

interface IZombieFactory {
    event ZombieFactory__NewZombie(uint256 zombieId, string name, uint256 dna);

    error ZombieFactory__ZombieAlreadyCreated();

    function createRandomZombie(string calldata _name) external;
}
