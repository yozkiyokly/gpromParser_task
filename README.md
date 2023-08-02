#gpromParser_task
Maillog parser with DBstorage and rapid analisys abilities
Employment task for perl devel position in GP JSC co. 
Perl script index.pl must parse a maillog (out.small) and push the data to the DB.
Once pushed, it must gave ability to search base by sender address.
Data for quick search puts inside a MEMORY table so quick analisys coud ran rapidly.

Generally, that is all, except small detail: 
Initially this project is intended to show for employer all pretender skills in perl language.
Hope it still would helpful as quick utility for administering small corporative mailbox.
As packaged, software must insert parser to logrotate chain to keep mail history in 
human readable form and once need, deploy MEMORY table for analitical purposes.
