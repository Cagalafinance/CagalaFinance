/**
 *Submitted for verification at BscScan.com on 2026-03-17
*/

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract CagalaFinance {
    string public name = "Cagala Finance";
    string public symbol = "CML";
    uint8 public decimals = 18;

    uint256 public totalSupply = 50_000_000 * 10 ** 18;

    address public owner;

    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;

    constructor() {
        owner = msg.sender;
        balanceOf[msg.sender] = totalSupply;
    }

    function transfer(address to, uint256 value) public returns (bool) {
        require(balanceOf[msg.sender] >= value, "Balance low");

        balanceOf[msg.sender] -= value;
        balanceOf[to] += value;

        emit Transfer(msg.sender, to, value);
        return true;
    }

    function approve(address spender, uint256 value) public returns (bool) {
        allowance[msg.sender][spender] = value;

        emit Approval(msg.sender, spender, value);
        return true;
    }

    function transferFrom(address from, address to, uint256 value) public returns (bool) {
        require(balanceOf[from] >= value, "Balance low");
        require(allowance[from][msg.sender] >= value, "Not allowed");

        balanceOf[from] -= value;
        balanceOf[to] += value;
        allowance[from][msg.sender] -= value;

        emit Transfer(from, to, value);
        return true;
    }

    function burn(uint256 value) public {
        require(balanceOf[msg.sender] >= value, "Balance low");

        balanceOf[msg.sender] -= value;
        totalSupply -= value;

        emit Transfer(msg.sender, address(0), value);
    }

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
}
