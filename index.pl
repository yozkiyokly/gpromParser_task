#!/usr/bin/perl
use DBI;
use warnings;
							##-- отладка --:# use Data::Dump qw(dump);
							##-- отладка --:# use strict;
use CGI qw(:standard);
require ('./ConfigFile.pm');
require ('./htmlOutput.pm');
require ('./Parser.pm');

printHeader("Yozki perl maillog parser with searchFiltering");


# Теперь найтмар. Мы проверяем таблицу 'log' на предмет упавшести МарияДБ\Миэскюэля
# И если таблица "message" полна, а "log" - пуста, предлагаем: 
# - либо зеркальнуть таблицу 'message';       *структура отличается: там нет пропарсенных email!!
# - либо отпарсить файл лога заново.
$countLog=checkLogTable($dbh);

#######################
# ф-ция восстановления буфера после падения ДБ:
if (param('restore')){  
# Красивое regexp_SUBSTR в один запрос предлагает Mysql,  начиная с версии 8, 
# но в 2023 году не везде есть восьмёрка, не говоря о десятке.
# Проставил-таки восьмёрку у себя на хостинге в spaceWEB. 
# * Когда я уже заведу себе человеческий VDS и перестану страдать?
# "Красивое вложенное с регекспом" заработало на унылом Shared-хостинге.:
$query="INSERT INTO `log` (`created`, `int_id`, `str`, `address`)
 SELECT 
 	`created`,	`int_id`,	`str`,	
 	REGEXP_SUBSTR (str, '[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,6}') 
 FROM
 	`message`;";
				$sth = $dbh->prepare($query);
			$sth->execute();

########################
# ф-ция загрузки файла из браузера:
} elsif (param('upload')){ 
$query = new CGI;
$filename = $query->upload('upload');
$filename =~ s/.*[\/\\](.*)/$1/;
truncateAllTables($dbh);

$ss,$ff= parseMaillogFile($filename);
print 'ss='.$ss. "  обработано строк: ".$ff;
}

#Очистка таблиц вручную, по ссылке:
if ($delete==1){truncateMessageTable($dbh);}elsif($delete==2){truncateLogTable($dbh);}

$search = param("search"); #  Надо убрать. Эту переменную потом используем целый один раз.
#Если мем-таблица LOG не пуста, показываем форму поиска:
if ($countLog){searchForm($search);} 
else{}

# Отображаем результаты поиска строк с заданным адресом:
if($countLog&&$search){ searchResultsPrint($search,$dbh);	}

$dbh->disconnect; 

printFooter();




exit;

