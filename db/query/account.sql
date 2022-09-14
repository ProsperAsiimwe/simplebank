-- name: CreateAccount :one
INSERT INTO account_mgt.accounts (
  owner_id, 
  balance,
  account_no,
  currency
) VALUES (
  $1, $2, $3, $4
)
RETURNING *;

-- name: GetAccount :one
SELECT * FROM account_mgt.accounts
WHERE id = $1 LIMIT 1;

-- name: ListAccounts :many
SELECT * FROM account_mgt.accounts
ORDER BY id
LIMIT $1
OFFSET $2;

-- name: UpdateAccount :one
UPDATE account_mgt.accounts 
SET 
balance = $2
WHERE id = $1
RETURNING *;

-- name: DeleteAccount :exec
DELETE FROM account_mgt.accounts WHERE id = $1;