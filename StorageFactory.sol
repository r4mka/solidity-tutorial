// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import { SimpleStorage } from "./SimpleStorage.sol";

contract StorageFactory {
    SimpleStorage[] public storages;

    function createSimpleStorageContract() public {
        SimpleStorage newStorage = new SimpleStorage();
        storages.push(newStorage);
    }
}
