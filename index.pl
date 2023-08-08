#!/usr/bin/perl
use strict;
use warnings;
use DBI;
use CGI qw(:standard); # WHY i used here this old stuff:
# 1. CGI::Tiny still (2023) had not installed at any sharedHost servers where i have access
# 2. Mojolicious::Lite.  Even LITE verison of mojo is too complex for such small scripts like this parser
# 3. i would try use Plack::Handler::CGI but same problem: not installed at my shared hostngs.
require './DatabaseRequests.pm';
require './htmlOutput.pm';
require './Parser.pm';

my $baseurl="/cgi-bin/";
my $resultsPerPage=100;
my $search=param('search');
my $fromPage=param('fromPage');$fromPage=1 if !$fromPage;
# Куда складывать загруженные ранее файлы с логами( '/tmp/eximParserLogs' would be also good choice):
my $upload_directory = '/var/www/gpromParser_task/upload';
my $cgi=CGI->new;
my $dbHandler = ConnectToMySql();   #Коннектимся в начале скрипта, до появления заголовков.
use CGI::Carp qw(warningsToBrowser fatalsToBrowser);

printHeader('Yozki Exim maillog parser');
warningsToBrowser(1);


# Восстановление буфера после падения ДБ.
# Если таблица "message" полна, а "log" - пуста, предлагаем: 
# - либо зеркальнуть таблицу 'message';    *структура отличается: там нет пропарсенных email!!
# - либо отпарсить файл лога заново.

if (param('restore')){  
restore_memtable_from_innodb_copy();

# загрузка файла из браузера:
} elsif (param('upload')){ 
    my $filename = $cgi->param('upload');
    my $fh       = $cgi->upload('upload');
    $filename=upload_file($filename,$fh,$upload_directory)or die 'upload function fails';
    truncateAllTables($dbHandler); #Чистим обе таблицы под корень
    my $strings_affected=parse_maillog_file($filename,$dbHandler);  
    print '<br>  обработано строк: <b>'.$strings_affected.'</b><br>';
}elsif (param('delete')){
    truncateMessageTable($dbHandler) if param('delete')eq'prev';
    truncateLogTable($dbHandler) if param('delete')eq'cache';
}
my ($numrowsOld,  $minDateOld, $maxDateOld, $numrowsCache, $minDateCache, $maxDateCache) = obtain_records_count($dbHandler);
my $countLog=show_menu(obtain_records_count($dbHandler));

#TODO: add deletion links):
#Очистка таблиц вручную, по ссылке 
if (param('delete')&&param('delete') eq '1'){truncateMessageTable($dbHandler)or die "message table truncation fails";}
elsif(param('delete')&&param('delete')eq '2'){truncateLogTable($dbHandler)or die "log table truncation fails";}

#Если мем-таблица LOG не пуста, показываем форму поиска.
if ($countLog){searchForm($search);} 
else{}

# Отображаем результаты поиска строк с заданным адресом:
if($countLog && $search) {  
    searchResultsPrint($search,$dbHandler,$baseurl,$resultsPerPage, $fromPage);
}

#Finally: 
$dbHandler->disconnect;
printFooter();

#######################
# Загружаем файл _И_ направляем его в директорию, где копим старые загрузки.
# Старые загрузки позже сможем обрабатывать mem-кэширующим движком, без MySQL.
#######################
sub upload_file{  
    my ($filename,$fh) =shift;
        open my $upload_fh, '>', "$upload_directory/$filename" or die "Can't open $upload_directory/$filename: $!";
         open $fh, '<', $filename or die "Can't open '$filename': $!";
         print $upload_fh $_ while <$fh>; #Переносим файл в файл, построчно. Не буфером.
         close $fh;
     close $upload_fh;
return "$upload_directory/$filename";
}

exit;

