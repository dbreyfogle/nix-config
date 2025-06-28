; Use SQL in strings that start with a "-- sql" marker
(string
  (string_content) @injection.content
  (#match? @injection.content "^--\\s*sql")
  (#set! injection.language "sql")
)
