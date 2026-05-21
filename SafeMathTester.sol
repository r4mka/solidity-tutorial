// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract SafeMathTester {
    uint8 public bigNumber = 255;

    function add() public {
        /*
            Before 0.8.0, arithmetic would wrap around silently:
            
            uint8 x = 255; // unchecked
            x = x + 1;     // result 0

            uint8 x = 0;   // unchecked
            x = x - 1;     // result 255

            Solidity added built-in overflow and underflow checking in version 0.8.0.

            you can skip this mechanism by wrapping expression with unchecked keyword
            unchecked { bigNumber = bigNumber + 1; }

            this is useful when you want to make your code a little bit more gas efficient
        */

        bigNumber = bigNumber + 1;
    }
}