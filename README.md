# RTpay Smart Contracts

This repository contains two main smart contracts: a comprehensive Multi-Signature Wallet and a custom TRC20 token with blacklisting functionality.

## Contracts Overview

### 1. MultiSigWallet.sol

A secure multi-signature wallet implementation that requires multiple owner confirmations before executing transactions. This contract provides comprehensive owner management functionality and secure transaction execution.

#### Features
- **Multi-Owner System**: Support for multiple wallet owners with unique address validation
- **Configurable Confirmations**: Customizable number of required confirmations (1 to number of owners)
- **Transaction Management**: Submit, confirm, revoke, and execute transactions
- **Advanced Owner Management**: Add, remove, and replace owners through wallet consensus
- **Requirements Management**: Dynamic adjustment of confirmation requirements

#### Core Functions

**Transaction Management:**
- `submitTransaction(address _to, uint256 _value, bytes memory _data)`: Submit a new transaction for confirmation
- `confirmTransaction(uint256 _txIndex)`: Confirm a pending transaction
- `executeTransaction(uint256 _txIndex)`: Execute a transaction with sufficient confirmations
- `revokeConfirmation(uint256 _txIndex)`: Revoke a previous confirmation

**View Functions:**
- `getOwners()`: Returns array of all owner addresses
- `getTransactionCount()`: Returns total number of transactions
- `getTransaction(uint256 _txIndex)`: Returns transaction details

**Owner Management (requires wallet execution):**
- `addOwner(address owner)`: Add a new owner to the wallet
- `removeOwner(address owner)`: Remove an existing owner
- `replaceOwner(address owner, address newOwner)`: Replace an existing owner
- `changeRequirement(uint256 _required)`: Change the number of required confirmations

#### Security Features
- Only owners can submit and confirm transactions
- Transactions require minimum confirmation threshold before execution
- Protection against duplicate confirmations and re-execution
- Automatic requirement adjustment when owners are removed
- Comprehensive input validation and access control


### 2. TKN.sol

An TRC20 token contract with role-based access control and blacklisting functionality. This token implements additional security features beyond the standard TRC20 specification.

#### Features
- **Standard TRC20**: Full TRC20 token implementation with custom decimals (2)
- **Role-Based Minting**: Only addresses with MINTER_ROLE can mint tokens
- **Blacklisting System**: Prevent blacklisted addresses from sending or receiving tokens
- **Access Control**: Uses OpenZeppelin's AccessControl for role management
- **Transfer Restrictions**: Both sender and recipient blacklist checks

#### Token Details
- **Name**: TKN
- **Symbol**: TKN
- **Decimals**: 2 (custom implementation)
- **License**: GPL-3.0

#### Key Functions
- `mint(address to, uint256 amount)`: Mint new tokens (requires MINTER_ROLE)
- `transfer(address to, uint256 amount)`: Transfer tokens (blocked for blacklisted addresses)
- `transferFrom(address from, address to, uint256 amount)`: Transfer tokens from another address (blocked for blacklisted addresses)
- `isBlacklisted(address account)`: Check if an address is blacklisted

#### Roles
- `DEFAULT_ADMIN_ROLE`: Can grant/revoke other roles and manage the contract
- `MINTER_ROLE`: Can mint new tokens to any address
- `BLACKLIST`: Addresses with this role cannot send or receive tokens