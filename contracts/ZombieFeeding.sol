// SPDX-License-Identifier: MIT

pragma solidity 0.8.16;

import "./ZombieFactory.sol";
import "./Interfaces/IKitty.sol";

contract ZombieFeeding is ZombieFactory {
    address private kittyCoreAddress =
        0x06012c8cf97BEaD5deAe237070F9587f8E7A266d;

    IKitty kittyAddress = IKitty(kittyCoreAddress);

    function feedAndMultiply(uint256 _zombieId, uint256 _targetDna) public {
        require(msg.sender == zombieToOwner[_zombieId]);
        Zombie storage myZombie = zombies[_zombieId];
        _targetDna = _targetDna % dnaModulus;
        uint256 newDna = (myZombie.dna + _targetDna) / 2;
        _createZombie("NoName", newDna);
    }
}
