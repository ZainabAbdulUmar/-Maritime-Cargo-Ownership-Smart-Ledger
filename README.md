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

## New Features

### Cargo Value Declaration

- 💰 Declare and update monetary values for cargo containers
- ⏱️ Timestamped value updates for audit trails
- 📊 Enhanced financial transparency for insurance and disputes

### Usage

#### Declare Cargo Value
```clarity
(contract-call? .maritime-cargo declare-cargo-value u1 u1000000)
```

#### Get Cargo Value
```clarity
(contract-call? .maritime-cargo get-cargo-value u1)
```

## 🔑 Updated Key Functions

- `register-container`: Create new cargo container entries
- `transfer-ownership`: Transfer container ownership
- `update-container-status`: Update container status and location
- `record-inspection`: Log container inspections
- `file-dispute`: Create dispute records
- `declare-cargo-value`: Set monetary value for containers
- `get-cargo-value`: Retrieve declared container value

Git commit message:
```
feat: Enable cargo value declarations for financial transparency
```

PR Title:
```
💰 Cargo Value Declaration Enhancement
```

PR Description:
```
Dive into the future of maritime asset management with our groundbreaking Cargo Value Declaration feature. This innovative addition allows container owners to securely declare monetary values, complete with immutable timestamped updates that create a robust audit trail. By integrating financial data directly into the blockchain ledger, we're bridging the gap between physical logistics and digital finance, ensuring every container's worth is transparently tracked and verifiable.

Unlock unparalleled benefits for stakeholders across the maritime ecosystem:

- 🔐 Owner-exclusive value setting with stringent access controls
- ⏱️ Block-height timestamped declarations for precise historical tracking
- 📈 Enhanced datasets powering advanced insurance and dispute resolution algorithms
- 🚀 Streamlined API for seamless developer integration and automation

This feature not only elevates the smart ledger's capabilities but also sets a new standard for blockchain-driven supply chain transparency. Experience the convergence of maritime logistics and decentralized finance like never before.

#MaritimeFinance #BlockchainValuation #SupplyChainInnovation
```