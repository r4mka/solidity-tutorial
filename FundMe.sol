// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import { PriceConverter } from "./PriceConverter.sol";

error NotOwner();

/* 
    transaction costs:
    772,281 - initial 
    752,546 - make minUSD constant
*/
contract FundMe {
    using PriceConverter for uint256;

    uint256 public constant MIN_USD = 5e18; // we want all numbers to have 18 decimals
    // 303   - constant
    // 2,402 - non-constant

    address public immutable i_owner;
    // 439   - immutable
    // 2,551 - non-immutable 

    address[] public funders;
    mapping(address funder => uint256 amountFunded) public addressToAmountFunded;

    constructor() {
        i_owner = msg.sender;
    }

    function fund() public payable {
        require(msg.value.getConversionRate() >= MIN_USD, "minimum contribution is 5 USD");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] += msg.value;
    }

    function withdraw() public onlyOwner {
        for (uint256 i = 0; i < funders.length; i++) {
            address funder = funders[i];
            addressToAmountFunded[funder] = 0;
        }

        funders = new address[](0);
        (bool callSuccess, ) = payable(msg.sender).call{ value: address(this).balance }("");
        require(callSuccess, "Call failed");
    }

    modifier onlyOwner() {
        // require(msg.sender == i_owner, "Sender is not owner!");
        if (msg.sender != i_owner) {
            revert NotOwner();
        }
        _;
    }
}
