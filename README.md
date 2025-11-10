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
- `file-insurance-claim`: Submit insurance claims for cargo incidents
- `resolve-insurance-claim`: Process and resolve insurance claims
- `get-insurance-claim`: Retrieve insurance claim details

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

## New Features

### Insurance Claim System

- 🛡️ Streamlined insurance claim filing for cargo incidents
- ⏱️ Timestamped claim submissions with immutable records
- 📋 Comprehensive incident tracking and resolution workflow
- 🔒 Owner-exclusive claim initiation with administrative resolution

### Usage

#### File Insurance Claim
```clarity
(contract-call? .maritime-cargo file-insurance-claim u1 u1 u500000 "storm-damage")
```

#### Resolve Insurance Claim
```clarity
(contract-call? .maritime-cargo resolve-insurance-claim u1 "approved" "Claim approved for storm damage")
```

#### Get Insurance Claim Details
```clarity
(contract-call? .maritime-cargo get-insurance-claim u1)
```

Git commit message:
```
feat: Integrate insurance claim management for cargo incidents
```

PR Title:
```
🛡️ Insurance Claim Management System
```

PR Description:
```
Revolutionize maritime risk management with our cutting-edge Insurance Claim System. This groundbreaking feature empowers cargo owners to seamlessly file claims for incidents like storms, theft, or damage, creating an immutable digital trail that transforms traditional insurance processes.

Elevate your maritime ecosystem with:

- 🔐 Owner-controlled claim submissions with robust authentication
- ⏱️ Block-height timestamped filings ensuring chronological integrity
- 📊 Detailed incident categorization for precise risk assessment
- ⚖️ Administrative resolution mechanisms with transparent status tracking
- 📈 Enhanced data analytics for insurance underwriting and loss prevention

This innovation bridges the gap between blockchain transparency and insurance efficiency, delivering unprecedented trust and speed in maritime claim settlements. Embrace the future of decentralized risk management today.

#MaritimeInsurance #BlockchainClaims #RiskManagement
```
```
Git commit message:
```
feat: Introduce temperature monitoring for cargo containers
```

PR Title:
```
🌡️ Temperature Monitoring System for Cargo Integrity
```

PR Description:
```
Elevate maritime cargo management to unprecedented levels of precision with our revolutionary Temperature Monitoring System. This cutting-edge feature empowers container owners to log and track temperature readings in real-time, ensuring optimal conditions for sensitive cargo throughout the entire supply chain journey.

Transform your logistics operations with:

- 🌡️ Granular temperature logging with block-height timestamping for chronological accuracy
- 🔐 Owner-exclusive access controls maintaining data integrity and privacy
- 📊 Comprehensive historical temperature data enabling predictive analytics and compliance reporting
- 🚀 Developer-friendly API facilitating seamless integration with IoT sensors and monitoring platforms
- ⚡ Instant verification capabilities for regulatory compliance and insurance requirements

This innovation represents a quantum leap in supply chain visibility, enabling proactive temperature management that protects cargo value and minimizes losses. Experience the convergence of blockchain immutability and environmental monitoring technology.

#TemperatureTracking #CargoIntegrity #SupplyChainTech

## New Features

### Temperature Monitoring

- 🌡️ Real-time temperature logging for cargo containers
- ⏱️ Timestamped entries with immutable blockchain records
- 🔒 Owner-controlled data management and access
- 📈 Historical temperature data for compliance and analytics

### Usage

#### Log Temperature
```clarity
(contract-call? .maritime-cargo log-temperature u1 25)
```

#### Get Temperature History
```clarity
(contract-call? .maritime-cargo get-temperature-history u1 u12345)
```

## 🔑 Updated Key Functions

- `register-container`: Create new cargo container entries
- `transfer-ownership`: Transfer container ownership
- `update-container-status`: Update container status and location
- `record-inspection`: Log container inspections
- `file-dispute`: Create dispute records
- `declare-cargo-value`: Set monetary value for containers
- `get-cargo-value`: Retrieve declared container value
- `file-insurance-claim`: Submit insurance claims for cargo incidents
- `resolve-insurance-claim`: Process and resolve insurance claims
- `get-insurance-claim`: Retrieve insurance claim details
- `log-temperature`: Record temperature readings for containers
- `get-temperature-history`: Retrieve temperature logs by timestamp
```