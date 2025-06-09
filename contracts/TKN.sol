// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

/**
 * @title TKN
 * @notice TKN 
 */
contract TKN is ERC20, AccessControl {

  function MINTER_ROLE() public pure returns (bytes32) {
    return keccak256("MINTER_ROLE");
  }
  
  function BLACKLIST() public pure returns (bytes32) {
      return keccak256("BLACKLIST");
  }

  function isBlacklisted(address account) public view returns (bool) {
    return hasRole(BLACKLIST(), account);
  }

  constructor() ERC20("TKN", "TKN") {
    _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
  }

  function mint(address to, uint256 amount) external onlyRole(MINTER_ROLE()) {
    _mint(to, amount);
  }
  
  function transfer(address to, uint256 amount) public virtual override returns (bool) {
    require(!isBlacklisted(msg.sender), "TKN: sender is blacklisted");
    require(!isBlacklisted(to), "TKN: recipient is blacklisted");
    return super.transfer(to, amount);
  }
  
  function transferFrom(address from, address to, uint256 amount) public virtual override returns (bool) {
    require(!isBlacklisted(from), "TKN: sender is blacklisted");
    require(!isBlacklisted(to), "TKN: recipient is blacklisted");
    return super.transferFrom(from, to, amount);
  }

  function decimals() public pure override returns (uint8) {
    return 2;
  }
}