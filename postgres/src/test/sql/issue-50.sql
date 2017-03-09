BEGIN;
set datestyle to 'iso, mdy';

CREATE TABLE issue_50 (
   id serial8 NOT NULL PRIMARY KEY,
   field1 uuid,
   field2 uuid[]
);
INSERT INTO issue_50 VALUES (default,
                             'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11',
                             ARRAY['a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a12']::uuid[]);
CREATE INDEX idxissue_50 ON issue_50 USING zombodb (zdb(issue_50), zdb_to_json(issue_50)) WITH (url='http://localhost:9200/');

SELECT * FROM issue_50 WHERE zdb(issue_50) ==> 'field1:"a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11"';
SELECT * FROM issue_50 WHERE zdb(issue_50) ==> 'field2:"a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11"';
SELECT * FROM issue_50 WHERE zdb(issue_50) ==> 'field2:"a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a12"';

ROLLBACK;   /* no need to save this table */