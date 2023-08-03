# Exim Maillog parser with DBstorage and rapid analisys abilities
Employment task for perl devel position in GPB JSC co. 
Perl script index.pl must parse a EXIM  maillog format (see specs. https://www.exim.org/exim-html-3.20/doc/html/spec_51.html) and push stripped and divided data to Database fields.

Once pushed, program must gave ability to search base by sender address.
Data for quick search additionally puts inside a temporary MEMORY table so quick analisys could ran rapidly. 
In case of SQLserver crash or plan shutdown script must have ability to restore MEMORY table from innoDB table.

At package state, this software must have module to insert parser inside logrotate chain or as pipeline to keep mail history in  database and once need, to deploy MEMORY table for analitical purposes. Filtering by criteria and searching by all fields is a plus for packaged software state.

Generally, that is all, except small detail: 
Initially this project is intended to show for employer all pretender skills in perl language.
Since question about database logging have 19 years history (see https://exim-users.exim.narkive.com/BPp7IQNU/logging-to-a-database) this feature are still unavailable in EXIM distribution. Hope this software - once reach the stable state, would helpful as quick utility for administering corporative mailboxes and be included to EXIM package. 
