# Rental Room Smart Contract

This project implements a simple rental room management system using a smart contract in Solidity. The contract allows users to pay and occupy a room, while the owner can reset the room status to "free" for the next renter.

## Features

### Core Functionalities:
1. **Room Occupation and Payment**:
   - Users can occupy a room by paying the required price (1 ether).
   - The room status changes to "occupied" upon successful payment.
   - Emits a `roomOccupied` event when the room is occupied.

2. **Set Room to Free**:
   - Only the owner can reset the room status to "free," allowing it to be rented again.

3. **Owner Authentication**:
   - The contract ensures that only the owner can perform owner-specific operations, such as resetting the room status.

4. **Payment Transfer**:
   - The rental payment is automatically transferred to the owner's address.

### Validation:
- Ensures the room is "free" before a user can rent it.
- Validates that the user sends enough funds to cover the room price.

## Technology

- **Language**: Solidity
- **Development and Testing Platform**: [Remix IDE](https://remix.ethereum.org/)
- **Network**: Simulated in Remix with JavaScript VM or deployed to Ethereum test networks like Goerli or Sepolia.

## Deployment and Testing Instructions

### Prerequisites
- Access to [Remix IDE](https://remix.ethereum.org/) or a local Solidity development environment.
- Basic understanding of Solidity and Ethereum.

### Deployment Steps
1. Copy the contract code into a file named `RentalRoom.sol`.
2. Open Remix and paste the code into a new file.
3. Compile the contract using the Solidity compiler.
4. Deploy the contract in the JavaScript VM or on a test network.

## Notes

- The price for occupying the room is set at **1 ether** but can be updated in future iterations.
- The contract is designed for educational purposes and does not include advanced features such as time-based rental or dynamic pricing.
