#!/usr/bin/perl
use DBI;
use warnings;
							##-- отладка --:# use Data::Dump qw(dump);
							##-- отладка --:# use strict;
use DBD::mysql; # и надо же ему было устареть! Теперь гляньте - МарияДБ и внезапное участие Оракла.
#use DBD::MariaDB;
use CGI qw(:standard);
require ('./ConfigFile.pm');
require ('./htmlOutput.pm');
require ('./Parser.pm');
print printHeader("maillog parser with searchFiltering");


#-OTLADKA--# print "<h3>$action $userid</h3>";
$search = param("search");
searchForm($search);

my $filename = './out';



# Отображаем результаты поиска строк с заданным адресом:
if($search){ searchResultsPrint($search,$dbh);	}

$dbh->disconnect; 
printFooter();
exit;


