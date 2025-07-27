# Event UUID

Ultra simple code to generate IDs (a little like UUID v7) to deduplicate browser- and server-side events.

Example value:

`1753614284833-741581-294635-978946-256573`


The first part of this pseudo-UUID is a timestamp which means the IDs are sortable, which is great for debugging.

In order to ensure a variable base don this template keeps value when used in multiple tags it keeps the value in a template storage.


**Important:** using advanced tags sequencing may break the logic. Event if two tags are firing with the same trigger but one is set to fire before or after the other one it will be fired with different dataLayer state which will cause the ID to change.

