# 🚢 Maritime Cargo Ownership Smart Ledger

A blockchain-based solution for tracking maritime cargo ownership and logistics using Clarity smart contracts.

## 🎯 Features

- ✨ Smart contract bills of lading
- 📦 NFT-based cargo containers
- ⏰ Time-stamped inspections
- 🛃 Customs verification
- 🔐 Port authority access control
- ⚖️ Dispute resolution system

## 🚀 Getting Started

### Prerequisites

- Clarinet
- Stacks blockchain wallet

### Installation

1. Clone the repository
2. Install dependencies with Clarinet
3. Deploy the contract

### Usage

#### Register a Container
```clarity
(contract-call? .maritime-cargo register-container u1 "Singapore Port")
```

#### Transfer Ownership
```clarity
(contract-call? .maritime-cargo transfer-ownership u1 'STNHKEPYEPJ8ET55ZZ0M5A34J0R3N5FM2CMMMAZ6)
```

#### Record Inspection
```clarity
(contract-call? .maritime-cargo record-inspection u1 "All systems normal")
```

## 🔑 Key Functions

- `register-container`: Create new cargo container entries
- `transfer-ownership`: Transfer container ownership
- `update-container-status`: Update container status and location
- `record-inspection`: Log container inspections
- `file-dispute`: Create dispute records

## 📝 License

MIT
```

Git commit message:
```
feat: Implement Maritime Cargo Ownership Smart Ledger MVP
```

PR Title:
```
✨ Add Maritime Cargo Ownership Smart Contract System
```

PR Description:
```
This PR introduces the Maritime Cargo Ownership Smart Ledger system with the following features:

- Smart contract-based cargo container management
- Ownership transfer functionality
- Port authority role management
- Inspection logging system
- Dispute resolution mechanism

The implementation provides a secure and transparent way to track maritime cargo ownership and logistics on the Stacks blockchain.

Testing completed:
- ✅ Container registration
- ✅ Ownership transfers
- ✅ Authority management
- ✅ Inspection logging
- ✅ Dispute filing