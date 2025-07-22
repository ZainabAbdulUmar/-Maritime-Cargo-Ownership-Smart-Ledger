(define-constant ERR-NOT-AUTHORIZED (err u100))
(define-constant ERR-INVALID-CARGO (err u101))
(define-constant ERR-ALREADY-EXISTS (err u102))
(define-constant ERR-NOT-FOUND (err u103))
(define-constant ERR-INVALID-STATE (err u104))

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
    customs-cleared: bool
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
        customs-cleared: false
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