# Exim Maillog parser with DBstorage and rapid analisys abilities
Perl CGI script index.pl parsing an EXIM  maillog file (see specs. https://www.exim.org/exim-html-3.20/doc/html/spec_51.html) and pushes divided data to database. We  use two tables: InnoDB (message) and MEMORY (log). InnoDB is used just for keeping data for case of SQLserver crash or reboot.
There is ability to restore MEMORY table from innoDB table in any time.

MEMORY table is used for quick analisys via fulltext search by sender address from browser window. 
This trick with MEMORY table engine is pretty good to analisys really big logs, 
for example for searching data after mailbombing or track user mail till long period.

Program gives an ability to search base by sender address only. Future release could search the whole log additionally.

At package state, this software would have module to insert parser inside logrotate chain or as pipeline to keep mail history in  database and once need, to deploy MEMORY table for analitical purposes. Filtering by criteria and searching by all fields is a plus for packaged software state.

Since question about Exim logging to database has 19 years history (see https://exim-users.exim.narkive.com/BPp7IQNU/logging-to-a-database) this feature is still unavailable in EXIM distribution. Hope this software would helpful as quick utility for administering corporative mailboxes and be included to EXIM package once this project willl reach the stable state. 
