// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

contract FundMe {
    uint256 public minUSD = 5e18; // we want all numbers to have 18 decimals
    address private priceFeedETHUSD =
        0x694AA1769357215DE4FAC081bf1f309aDC325306;

    function fund() public payable {
        require(msg.value >= minUSD, "minimum fund is 5 USD");
    }

    function getPrice() public view returns (uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(
            priceFeedETHUSD
        );
        (, int256 price, , , ) = priceFeed.latestRoundData();

        /*
            Price of ETH in terms of USD
            
            Solidity doesn't have floating point numbers. Everithing is stored as integers,
            so protocols represnt decimal values by scaling them.

            1$       -> 100000000
            2.02$    -> 202000000
            2500.12$ -> 250012000000

            Formula: returned_price = actual_price * 1e8
        
            That's because this Chainlink feed uses 8 decimals
        
            1 ETH = 1e18 wei (18 decimals)
            We want to make our returned price to have 18 decimals too
        */

        return uint256(price * 1e10);
    }

    function getConversionPrice(
        uint256 ethAmount
    ) public view returns (uint256) {
        uint256 ethPrice = getPrice();
        uint256 ethAmountUSD = (ethAmount * ethPrice) / 1e18;
        return ethAmountUSD;
    }

    function getVersion() public view returns (uint256) {
        return AggregatorV3Interface(priceFeedETHUSD).version();
    }

    function getDecimals() public view returns (uint8) {
        return AggregatorV3Interface(priceFeedETHUSD).decimals();
    }
}
