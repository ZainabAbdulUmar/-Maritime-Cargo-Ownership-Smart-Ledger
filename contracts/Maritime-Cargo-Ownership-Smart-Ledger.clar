(define-constant ERR-NOT-AUTHORIZED (err u100))
(define-constant ERR-INVALID-CARGO (err u101))
(define-constant ERR-ALREADY-EXISTS (err u102))
(define-constant ERR-NOT-FOUND (err u103))
(define-constant ERR-INVALID-STATE (err u104))
(define-constant ERR-SEAL-BROKEN (err u105))
(define-constant ERR-SEAL-NOT-APPLIED (err u106))

(define-data-var contract-owner principal tx-sender)

(define-map cargo-containers
  { container-id: uint }
  {
    owner: principal,
    status: (string-ascii 20),
    current-port: (string-ascii 50),
    destination: (string-ascii 50),
    bill-of-lading: (string-ascii 64),
    last-inspection: uint,
    customs-cleared: bool,
    seal-status: (string-ascii 20),
    current-seal-id: (string-ascii 64)
  }
)

(define-map port-authorities
  { port-id: (string-ascii 50) }
  {
    authority: principal,
    is-active: bool
  }
)

(define-map inspection-logs
  { container-id: uint, timestamp: uint }
  {
    inspector: principal,
    port: (string-ascii 50),
    status: (string-ascii 20),
    notes: (string-ascii 256)
  }
)

(define-map disputes
  { dispute-id: uint }
  {
    container-id: uint,
    complainant: principal,
    status: (string-ascii 20),
    timestamp: uint,
    resolution: (string-ascii 256)
  }
)

(define-map seal-records
  { container-id: uint, seal-id: (string-ascii 64) }
  {
    applied-by: principal,
    applied-at: uint,
    broken-by: (optional principal),
    broken-at: (optional uint),
    seal-type: (string-ascii 20),
    location: (string-ascii 50)
  }
)

(define-public (register-container (container-id uint) (destination (string-ascii 50)))
  (let ((sender tx-sender))
    (asserts! (is-eq sender (var-get contract-owner)) ERR-NOT-AUTHORIZED)
    (asserts! (is-none (map-get? cargo-containers {container-id: container-id})) ERR-ALREADY-EXISTS)
    (ok (map-set cargo-containers
      {container-id: container-id}
      {
        owner: sender,
        status: "registered",
        current-port: "origin",
        destination: destination,
        bill-of-lading: "",
        last-inspection: u0,
        customs-cleared: false,
        seal-status: "unsealed",
        current-seal-id: ""
      }))))

(define-public (transfer-ownership (container-id uint) (new-owner principal))
  (let ((container (unwrap! (map-get? cargo-containers {container-id: container-id}) ERR-NOT-FOUND)))
    (asserts! (is-eq tx-sender (get owner container)) ERR-NOT-AUTHORIZED)
    (ok (map-set cargo-containers
      {container-id: container-id}
      (merge container {owner: new-owner})))))

(define-public (update-container-status (container-id uint) (new-status (string-ascii 20)) (port (string-ascii 50)))
  (let ((container (unwrap! (map-get? cargo-containers {container-id: container-id}) ERR-NOT-FOUND))
        (authority (unwrap! (map-get? port-authorities {port-id: port}) ERR-NOT-AUTHORIZED)))
    (asserts! (is-eq tx-sender (get authority authority)) ERR-NOT-AUTHORIZED)
    (ok (map-set cargo-containers
      {container-id: container-id}
      (merge container 
        {
          status: new-status,
          current-port: port
        })))))

(define-public (register-port-authority (port-id (string-ascii 50)) (authority-principal principal))
  (let ((sender tx-sender))
    (asserts! (is-eq sender (var-get contract-owner)) ERR-NOT-AUTHORIZED)
    (ok (map-set port-authorities
      {port-id: port-id}
      {
        authority: authority-principal,
        is-active: true
      }))))

(define-public (record-inspection (container-id uint) (notes (string-ascii 256)))
  (let ((container (unwrap! (map-get? cargo-containers {container-id: container-id}) ERR-NOT-FOUND))
        (authority (unwrap! (map-get? port-authorities {port-id: (get current-port container)}) ERR-NOT-AUTHORIZED))
        (timestamp stacks-block-height))
    (asserts! (is-eq tx-sender (get authority authority)) ERR-NOT-AUTHORIZED)
    (map-set inspection-logs
      {container-id: container-id, timestamp: timestamp}
      {
        inspector: tx-sender,
        port: (get current-port container),
        status: (get status container),
        notes: notes
      })
    (ok (map-set cargo-containers
      {container-id: container-id}
      (merge container {last-inspection: timestamp})))))

(define-public (file-dispute (container-id uint) (dispute-id uint) (details (string-ascii 256)))
  (let ((container (unwrap! (map-get? cargo-containers {container-id: container-id}) ERR-NOT-FOUND))
        (timestamp stacks-block-height))
    (asserts! (is-eq tx-sender (get owner container)) ERR-NOT-AUTHORIZED)
    (ok (map-set disputes
      {dispute-id: dispute-id}
      {
        container-id: container-id,
        complainant: tx-sender,
        status: "open",
        timestamp: timestamp,
        resolution: details
      }))))

(define-read-only (get-container-details (container-id uint))
  (ok (unwrap! (map-get? cargo-containers {container-id: container-id}) ERR-NOT-FOUND)))

(define-read-only (get-inspection-history (container-id uint))
  (ok (map-get? inspection-logs {container-id: container-id, timestamp: (get last-inspection (unwrap! (map-get? cargo-containers {container-id: container-id}) ERR-NOT-FOUND))})))

(define-public (apply-seal (container-id uint) (seal-id (string-ascii 64)) (seal-type (string-ascii 20)))
  (let ((container (unwrap! (map-get? cargo-containers {container-id: container-id}) ERR-NOT-FOUND))
        (authority (unwrap! (map-get? port-authorities {port-id: (get current-port container)}) ERR-NOT-AUTHORIZED))
        (timestamp stacks-block-height))
    (asserts! (is-eq tx-sender (get authority authority)) ERR-NOT-AUTHORIZED)
    (asserts! (is-eq (get seal-status container) "unsealed") ERR-INVALID-STATE)
    (asserts! (is-none (map-get? seal-records {container-id: container-id, seal-id: seal-id})) ERR-ALREADY-EXISTS)
    (map-set seal-records
      {container-id: container-id, seal-id: seal-id}
      {
        applied-by: tx-sender,
        applied-at: timestamp,
        broken-by: none,
        broken-at: none,
        seal-type: seal-type,
        location: (get current-port container)
      })
    (ok (map-set cargo-containers
      {container-id: container-id}
      (merge container 
        {
          seal-status: "sealed",
          current-seal-id: seal-id
        })))))

(define-public (break-seal (container-id uint) (reason (string-ascii 256)))
  (let ((container (unwrap! (map-get? cargo-containers {container-id: container-id}) ERR-NOT-FOUND))
        (authority (unwrap! (map-get? port-authorities {port-id: (get current-port container)}) ERR-NOT-AUTHORIZED))
        (seal-record (unwrap! (map-get? seal-records {container-id: container-id, seal-id: (get current-seal-id container)}) ERR-NOT-FOUND))
        (timestamp stacks-block-height))
    (asserts! (is-eq tx-sender (get authority authority)) ERR-NOT-AUTHORIZED)
    (asserts! (is-eq (get seal-status container) "sealed") ERR-SEAL-NOT-APPLIED)
    (asserts! (is-none (get broken-by seal-record)) ERR-SEAL-BROKEN)
    (map-set seal-records
      {container-id: container-id, seal-id: (get current-seal-id container)}
      (merge seal-record 
        {
          broken-by: (some tx-sender),
          broken-at: (some timestamp)
        }))
    (ok (map-set cargo-containers
      {container-id: container-id}
      (merge container 
        {
          seal-status: "broken",
          current-seal-id: ""
        })))))

(define-read-only (verify-seal (container-id uint))
  (let ((container (unwrap! (map-get? cargo-containers {container-id: container-id}) ERR-NOT-FOUND)))
    (if (is-eq (get seal-status container) "sealed")
      (ok (some (map-get? seal-records {container-id: container-id, seal-id: (get current-seal-id container)})))
      (ok none))))

(define-read-only (get-seal-history (container-id uint) (seal-id (string-ascii 64)))
  (ok (map-get? seal-records {container-id: container-id, seal-id: seal-id})))