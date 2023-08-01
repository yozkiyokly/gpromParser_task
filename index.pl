#!/usr/bin/perl
use DBI;
use warnings;
							##-- отладка --:# use Data::Dump qw(dump);
							##-- отладка --:# use strict;
use DBD::mysql; # и надо же ему было устареть! Теперь гляньте - МарияДБ и внезапное участие Оракла.
#use DBD::MariaDB;
use CGI qw(:standard);
require ('./ConfigFile.pm');
print printHeader("maillog parser with searchFiltering");
#-OTLADKA--#  print "$action <br>";
$search = param("search");
searchForm($search);
my $filename = './out';

open(FH, '<', $filename) or die $!;
print("<pre>Log $filename have been opened. Let's parse...\n");
while(<FH>){
##########
# вначале откусим от лога дату. Она занимает 19 байт плюс пробел. После этого в логе будут разночтения.
# не будем тошнить точностью поиска \d{4}(?:-\d{2}(?:-\d{2}(?: \d{2}(?::\d{2}(?::\d{2})?)?)?)?)?
# а тупо резанём 19 циферок, минусиков и двоеточиев и пробелов.
#### 
# затем следует выковырять внутренний ID. Пока по логу не видно, предусмотрено ли увеличение разрядности.
# презюмирую, что разрядность не будет расширяться и ограничиваю парсинг фиксированной структурой, 
# содержащей дефисы на конкретных позициях и находящейся \bвнутри\b "слова". 1Rm0kE-00027I-IY
# ради темпа обработки не делаю проверку на маловерояное несодержание @, 
# но так и быть, ограничиваю набор знаков через \w     
#           \b\w{6}-\w{6}-\w{2}\b|  			^^^ спокойствия для:

@parseBasic= $_ =~ /(^[0-9-:\s]{19})\s(\w{6}-\w{6}-\w{2})\b/s;
					##-- отладка --:#  print "datetime: ";
					##-- отладка --:#  print @parseBasic[0];
					##-- отладка --:#  print "\nid: ";
					##-- отладка --:#  print @parseBasic[1];
					##-- отладка --:#  print "\n";
					##-- отладка --:#dump(@parseBasic);
# Очередь вытрясти флаг, в неизменном виде. Дальше его статус будет являться признаком участия записи в поиске, уже в виде числа.
# Строка лога может (!) содержать более одного флага,
# поэтому пришлось нашинковать красивый длинный регексп на малые.
# Цитируем такой случай из лога:
############
# 	2012-02-13 14:39:22 1RwtJa-000AGs-7A <= <> R=1Rm0kE-00027I-IY U=mailnull P=local S=2551
############  							 ^^-^^---ВОТ КАК бывает.	
# С этого места, при отсутствии флага можно брейкнуть функцию, 
# в которой будут собраны регэкспы, чтобы перейти к следующей строке без задержки. 
# Дело в том, что лог содержит также пустые отчёты о подключениях к SMTP,
# полезных данных такие строки будто бы не содержат; стало быть и пихать их в БД незачем.
# Отметим и этот факт цитатой из лога:
##########################
#	2012-02-13 14:40:34 1RwtJT-0009RI-Gl Completed
#	2012-02-13 14:40:35 1RwtEr-0002zL-NQ Spool file is locked (another process is handling this message)
#	2012-02-13 14:40:35 SMTP connection from [194.226.65.146] (TCP/IP connection count = 1)
##########################

@flag= $_ =~ /([=><*]{2})/s;
					##-- отладка --:#  print "flag: ";
					##-- отладка --:#  print @flag[0];
if (@flag[0]){
	if 		(@flag[0] eq "<="){$flag=1;}
	elsif	(@flag[0] eq "=>"){$flag=2;}
	elsif	(@flag[0] eq "=="){$flag=3;}
	elsif	(@flag[0] eq "**"){$flag=4;}
}else {$flag=0;}

# Дерём первый встретившийся email. Вариант без бюрократического соблюдения RFC-5322, как у emailregex.com, но работает.
# Массив содержит в ячейках все адреса, найденные в строке.
@email= $_ =~ /
\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,6}\b
/gxs;
					##-- отладка --:# print "\nemail: ";
					##-- отладка --:# print $email[0];


# вырезаем и остаток строки от завершения первого вхождения флага:
@log_string= $_ =~ /
[=><*]{2}\s(.*)$
/gxs;
chomp(@log_string[0]);

					##-- отладка --:	# print "\nstr:<font color='dark'>  ";
					##-- отладка --:	# print @log_string[0];
					##-- отладка --:	# print "\n</font><font color='grey'>full string:\n";
					##-- отладка --:   	# print $_;
					##-- отладка --:	# print "</font>\n\n\n";

	if ($flag){ #Если флаг вообще имеет место, тогда вставляем в таблицы всё что напарсилось:
		$query = "INSERT into log (created,	int_id,	str,	address) VALUES ('@parseBasic[0]', '@parseBasic[1]', '@log_string[0]', '@email[0]')";
			$sth = $dbh->prepare($query);
			$sth->execute();
		$query = "INSERT into message (created,	int_id,	str,	status) VALUES ('@parseBasic[0]', '@parseBasic[1]', '@log_string[0]', '$flag')";
			$sth = $dbh->prepare($query);
			$sth->execute();
	}
	$flag[0]="";
}



close(FH);



#######################################
# Отображаем результаты поиска строк с заданным адресом:
if($search){
#-------found log strings list inside primitive table:
print "<table border=0 width=80%>\n";
print "<tr><td>Date</td><td colspan=2>id</td></tr>\n";

$query = "select * FROM log where address LIKE '%$search%' LIMIT 100";
print $query;
$sth = $dbh->prepare($query);
$sth->execute();
while (@data = $sth->fetchrow_array()) 	{
	$date = 		$data[0];
	$internal_ID = 	$data[1];
	$log_string = 	$data[2];
	$email = 		$data[3];

	print "<tr bgcolor=$bgcolor>
	<td>$date</td>
	<td>$internal_ID</td>
	</tr>\n
	<tr><td colspan=2><small>$log_string</small><hr size=1></td></tr>\n";
	if ($bgcolor =~ "#EEEEEE") { $bgcolor = "white"; }else{$bgcolor = "#EEEEEE";}
	}
print "</table>\n";
}

$dbh->disconnect; 
printFooter();
exit;


