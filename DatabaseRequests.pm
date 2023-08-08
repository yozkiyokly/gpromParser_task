use DBI;

# не вылетаем при Raise Error, удобнее для отладки:
my $stopOnDBIErrors=0;


#Конфигурацию SQL, тем не менее, прячем внутри функции, наружу уйдёт только готовый указатель:
sub ConnectToMySql {
    # Серверозависимые credentials для БД ради единства версии на тестовом сервере и на гитхабе:
use Sys::Hostname;
use Socket;
my $addr = inet_ntoa((gethostbyname(hostname))[4]);
    if ($addr eq '192.168.1.11'){
use DBD::MariaDB; # для отладочного сервера (где Debian bookworm _Testing_).
         $host = "localhost";
         $port=3306;
         $db = "gprom";
         $userid = "gprom";
         $passwd = "miller";
        }else{
use DBD::mysql; # для традиционно убогого shared-хостинга
         $host = "127.0.0.1";
         $port=3308;
         $db = "yozki";
         $userid = "yozki";
         $passwd = "qwe123_QWE123";
        }
     $connectionInfo="dbi:mysql:$db;$host;$port";
     $dbHandler = DBI->connect($connectionInfo,$userid,$passwd, { RaiseError => $stopOnDBIErrors, PrintError => 1, PrintWarn => 1,AutoCommit=>1,
HandleError=>\&dbierrorlog });
return $dbHandler;
}

# Пришлось выпечатывать ошибки MySQL, ибо драйверы DBD несказанно огорчили.
sub dbierrorlog{print "<h3>Database error</h3>";
	print	"<table border='1' bordercolor=red cellpadding='8' style='border-radius: 5px;'>\n";
	print "<tr><td colspan=3 bgcolor='ff7755'><font color=white>Database driver raised an error: <font color=cyan>[ <b>";
    print $DBI::errstr;
	print "</b> ]</font><br>Your last data could be lost, unfortunately.";
print "<div align=right><form action='?go=home'><input type=submit value='go next =>'></form></div></td></tr></table></html>";
exit;}


#Две таблицы, два количества. Дополнительно даём диапазоны дат. Сможем сузить при необходимости.
sub obtain_records_count($){ #ф-ция получит ровно один скаляр - указатель на соединение с бд
my $dbHandler=shift;	
	my $query = 'select count(*), MIN(created) AS minDate, MAX(created) AS maxDate  FROM message';
	my $sth = $dbHandler->prepare($query);
	$sth->execute() or die "messagetable count fails";
	my ($numrowsOld, $minDateOld,$maxDateOld)= $sth->fetchrow_array() or die('innoDB table with old export not reads');

	$query='SELECT COUNT(*), MIN(created) AS minDate, MAX(created) AS maxDate  FROM log';
	$sth = $dbHandler->prepare($query);
	$sth->execute() or die "logtable count fails";
	my ($numrowsCache, $minDateCache,$maxDateCache) = $sth->fetchrow_array() or die('Table memory-type not reads');
return $numrowsOld, $minDateOld,$maxDateOld,$numrowsCache, $minDateCache,$maxDateCache ;
}


#################################################
sub restore_memtable_from_innodb_copy(){
# Красивое regexp_SUBSTR в один запрос предлагает Mysql,  начиная с версии 8, 
# но в 2023 году не везде есть восьмёрка, не говоря о десятке.
# Проставил-таки восьмёрку у себя на хостинге в spaceWEB. 
# * Когда я уже заведу себе человеческий VDS и перестану страдать?
# "Красивое вложенное с регекспом" заработало на унылом Shared-хостинге.:
$sth = $dbHandler->prepare(
"INSERT INTO `log` (`created`, `int_id`, `str`, `address`)
 SELECT  `created`,	`int_id`,	`str`,	
 	REGEXP_SUBSTR (str, '[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,6}') 
 FROM `message`;"
);
$sth->execute(); }


#################################################
# Clear both innoDB and Memory tables with logs.
sub truncateAllTables($dbHandler){
	my $i=truncateMessageTable($dbHandler);
	my $k=truncateLogTable($dbHandler);
return $i*$k;}
#---------------
				#---------
				sub truncateMessageTable($dbHandler){
					$query = "TRUNCATE TABLE message";
					$sth = $dbHandler->prepare($query);
					$sth->execute() or die "cannot truncate innodb Table";
				return true;
				}
				#---------
				sub truncateLogTable($dbHandler){
					$query = "TRUNCATE TABLE log";
					$sth = $dbHandler->prepare($query);
					$sth->execute() or die "cannot truncate MEMORY Table";
				return true;
				}

#################################################
sub insert_both_tables ($$$$$$){ #six scalars as args
my ($date, $int_Id, $log_string,$email,$flag,$dbHandler) = @_;

#--OTLaDka:--# print $flag,$dbHandler;
 	$query = "INSERT into message (created,	int_id,	str, status) VALUES ('$date', '$int_Id', '$log_string', '$flag')";
 	$sth = $dbHandler->prepare($query) or die "msgTable preparation fails";
 	$sth->execute() or die "cannot insert into msgTable";
 	my $query = "INSERT into log (created,	int_id,	str, address) VALUES ('$date', '$int_Id', '$log_string', '$email')";
#--OTLaDka:--# print $query."<br>";
 	 my $sth = $dbHandler->prepare($query) or die "logTable prep fails";
 	 $sth->execute() or return '<h3>cannot insert into logTable - possible out of memory</h3>'; 
	return false;
}

return true;