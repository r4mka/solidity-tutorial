// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import { SimpleStorage } from "./SimpleStorage.sol";

contract StorageFactory {
    SimpleStorage[] public listOfSimpleStorageContracts;

    function createSimpleStorageContract() public {
        SimpleStorage newStorage = new SimpleStorage();
        listOfSimpleStorageContracts.push(newStorage);
    }

    function sfStore(uint256 _index, uint256 _number) public {
        SimpleStorage simpleStorage = listOfSimpleStorageContracts[_index];
        simpleStorage.store(_number);
    }

    function sfGet(uint256 _index) public view returns (uint256) {
        SimpleStorage simpleStorage = listOfSimpleStorageContracts[_index];
        return simpleStorage.retrieve();
    }
}
