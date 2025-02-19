import { Kysely, MysqlDialect, sql } from "kysely";
import { createPool } from "mysql2";
import assert from "node:assert/strict";
import { after, before, test } from "node:test";

let db;

before(function () {
  db = new Kysely({
    dialect: new MysqlDialect({
      pool: createPool({
        database: "test",
        host: "127.0.0.1",
        user: "root",
        password: "root",
        port: 3306,
        connectionLimit: 10,
      }),
    }),
  });
});

after(async function () {
  await db.destroy();
});

test("smoke", async function () {
  const row = await db.selectNoFrom(sql`1`.as("foo")).executeTakeFirstOrThrow();

  assert.equal(row.foo, 1);
});
