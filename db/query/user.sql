-- name: CreateUser :one
INSERT INTO user_mgt.users (
  full_name, 
  id_card_no
) VALUES (
  $1, $2
)
RETURNING *;

-- name: GetUser :one
SELECT * FROM user_mgt.users
WHERE id = $1 LIMIT 1;

-- name: ListUsers :many
SELECT * FROM user_mgt.users
ORDER BY id
LIMIT $1
OFFSET $2;

-- name: UpdateUser :one
UPDATE user_mgt.users 
SET 
full_name = $2,
id_card_no = $3
WHERE id = $1
RETURNING *;

-- name: DeleteUser :exec
DELETE FROM user_mgt.users WHERE id = $1;



--NOTE: On ListUsers Use Pagination because there could be many records so we use LIMIT to get the number of rows we want to get 
-- and OFFSET to tell Postgres to skip this many rows before starting to return the result