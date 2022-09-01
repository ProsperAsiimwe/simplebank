-- name: CreateUser :one
INSERT INTO user_mgt.users (
  full_name, 
  id_card_no
) VALUES (
  $1, $2
)
RETURNING *;