# Smart Contracts Project

This repository contains two main smart contracts: a Multi-Signature Wallet and a custom ERC20 token with blacklisting functionality.

## Contracts Overview

### 1. MultiSigWallet.sol

A secure multi-signature wallet implementation that requires multiple owner confirmations before executing transactions.

#### Features
- **Multi-Owner System**: Support for multiple wallet owners
- **Configurable Confirmations**: Customizable number of required confirmations
- **Transaction Management**: Submit, confirm, revoke, and execute transactions
- **Owner Management**: Replace existing owners through wallet consensus
- **Event Logging**: Comprehensive event emission for all actions

#### Key Functions
- `submitTransaction()`: Submit a new transaction for confirmation
- `confirmTransaction()`: Confirm a pending transaction
- `executeTransaction()`: Execute a transaction with sufficient confirmations
- `revokeConfirmation()`: Revoke a previous confirmation
- `replaceOwner()`: Replace an existing owner (requires wallet execution)


### 2. TKN.sol

An ERC20 token contract with role-based access control and blacklisting functionality.

#### Features
- **Standard ERC20**: Full ERC20 token implementation
- **Role-Based Minting**: Only addresses with MINTER_ROLE can mint tokens
- **Blacklisting System**: Prevent blacklisted addresses from transferring tokens
- **Access Control**: Uses OpenZeppelin's AccessControl for role management

#### Key Functions
- `mint()`: Mint new tokens (requires MINTER_ROLE)
- `transfer()`: Transfer tokens (blocked for blacklisted addresses)
- `transferFrom()`: Transfer tokens from another address (blocked for blacklisted addresses)
- `isBlacklisted()`: Check if an address is blacklisted

#### Roles
- `DEFAULT_ADMIN_ROLE`: Can grant/revoke other roles
- `MINTER_ROLE`: Can mint new tokens
- `BLACKLIST`: Addresses with this role cannot transfer/receive tokens
