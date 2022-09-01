CREATE SCHEMA IF NOT EXISTS "account_mgt";

CREATE SCHEMA IF NOT EXISTS "user_mgt";

CREATE TABLE  account_mgt.accounts(
  "id" bigserial PRIMARY KEY,
  "owner_id" bigint NOT NULL,
  "balance" bigint DEFAULT 0,
  "account_no" varchar UNIQUE NOT NULL,
  "currency" varchar NOT NULL,
  "created_at" timestamptz NOT NULL DEFAULT (now())
);

CREATE TABLE  account_mgt.entries (
  "id" bigserial PRIMARY KEY,
  "account_id" bigint NOT NULL,
  "amount" bigint DEFAULT 0,
  "created_at" timestamptz NOT NULL DEFAULT (now())
);

CREATE TABLE  account_mgt.transfers (
  "id" bigserial PRIMARY KEY,
  "from_account_id" bigint NOT NULL,
  "to_account_id" bigint NOT NULL,
  "amount" bigint DEFAULT 0,
  "created_at" timestamptz NOT NULL DEFAULT (now())
);

CREATE TABLE  user_mgt.users (
  "id" bigserial PRIMARY KEY,
  "full_name" varchar NOT NULL,
  "id_card_no" varchar,
  "created_at" timestamptz NOT NULL DEFAULT (now())
);

CREATE INDEX ON  account_mgt.accounts  ("owner_id");

CREATE INDEX ON  account_mgt.accounts ("account_no");

CREATE INDEX ON  account_mgt.entries ("account_id");

CREATE INDEX ON  account_mgt.transfers ("from_account_id");

CREATE INDEX ON  account_mgt.transfers ("to_account_id");

CREATE INDEX ON  account_mgt.transfers ("from_account_id", "to_account_id");

COMMENT ON COLUMN  account_mgt.entries.amount IS 'Can either be negative or positive';

COMMENT ON COLUMN account_mgt.transfers.amount IS 'Must be positive';

ALTER TABLE  account_mgt.accounts ADD FOREIGN KEY ("owner_id") REFERENCES user_mgt.users ("id");

ALTER TABLE  account_mgt.entries ADD FOREIGN KEY ("account_id") REFERENCES account_mgt.accounts ("id");

ALTER TABLE  account_mgt.transfers ADD FOREIGN KEY ("from_account_id") REFERENCES account_mgt.accounts ("id");

ALTER TABLE  account_mgt.transfers ADD FOREIGN KEY ("to_account_id") REFERENCES account_mgt.accounts ("id");