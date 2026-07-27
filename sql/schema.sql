-- E-commerce Cosmetics Shop — Table Schema

DROP TABLE IF EXISTS events;

CREATE TABLE events (
    event_time      TIMESTAMP,
    event_type      VARCHAR(20),
    product_id      BIGINT,
    category_id     BIGINT,
    category_code   TEXT,
    brand           TEXT,
    price           NUMERIC(10,2),
    user_id         BIGINT,
    user_session    UUID
);