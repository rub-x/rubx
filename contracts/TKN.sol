// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

/**
 * @title RUBx
 * @notice RUBx 
 */
contract RUBx is ERC20, AccessControl {

  bool public lock = false;

  function MINTER_ROLE() public pure returns (bytes32) {
    return keccak256("MINTER_ROLE");
  }
  
  function BLACKLIST() public pure returns (bytes32) {
      return keccak256("BLACKLIST");
  }

  function LOCK_ROLE() public pure returns (bytes32) {
      return keccak256("LOCK_ROLE");
  }

  function isBlacklisted(address account) public view returns (bool) {
    return hasRole(BLACKLIST(), account);
  }

  modifier notBlacklisted(address to, address from) {
    require(!isBlacklisted(to), "RUBx: recipient is blacklisted");
    require(!isBlacklisted(from), "RUBx: sender is blacklisted");
    _;
  }

  modifier notLocked() {
    require(!lock, "RUBx: contract is locked");
    _;
  }

  constructor() ERC20("RUBx", "RUBx") {
    _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
  }

  function setLock(bool _lock) external onlyRole(LOCK_ROLE()) {
    lock = _lock;
  }

  function mint(address to, uint256 amount) external onlyRole(MINTER_ROLE()) notLocked() {
    _mint(to, amount);
  }
  
  function burn(address from, uint256 amount) external onlyRole(MINTER_ROLE()) notLocked() {
    _burn(from, amount);
  }

  function transfer(address to, uint256 amount) public virtual override notBlacklisted(to, msg.sender) notLocked() returns (bool) {
    return super.transfer(to, amount);
  }
  
  function transferFrom(address from, address to, uint256 amount) public virtual override notBlacklisted(to, from) notLocked() returns (bool) {
    return super.transferFrom(from, to, amount);
  }

  function decimals() public pure override returns (uint8) {
    return 2;
  }
}