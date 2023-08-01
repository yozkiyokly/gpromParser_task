#package ConfigFile;
#Скрипт маленький, потому смело пользуемся глобальными переменными, массивами и валим код безо STRICT:
# Если потребуется абсолютный url (без слэша в конце):
 $baseurl="/cgi-bin";

#Конфигурацию SQL, тем не менее, прячем внутри функции:
sub ConnectToMySql {
my $host = "localhost";
#my $db = "gprom";
#my $userid = "gprom";
#my $passwd = "miller";
my $db = "yozki";
my $userid = "yozki";
my $passwd = "qwe123_QWE123";
my $connectionInfo="dbi:mysql:$db;$host";
my $dbHeader = DBI->connect($connectionInfo,$userid,$passwd);
return $dbHeader;
}

$dbh = ConnectToMySql($Database); #Коннектимся в начале скрипта, до появления заголовков.


#----------------------------------------------------------------------
sub printHeader($title){
return header,'
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//RU" >
<html lang="ru">
<head>
<meta charset="UTF8" />
<title>',@_[0],'</title></head>
<body>';
}

#----------------------------------------------------------------------
sub printFooter(){
print "<br><br><pre><small><font color='orange'>Прошу простить за дзен в оформлении: \nпредполагая, что первичным для анализа навыков и стиля мышления претендента является код, \nпредпочитаю посвятить больше времени именно этой стороне дела.\n\n
Sincerely, WRB-RIPN (yozki.com)</small></pre><font>";
print "\n\n</body></html>\n\n";}


#----------------------------------------------------------------------
sub searchForm($search){
print <<HTML;
<form method="get" name="searching" action="$baseurl/index.pl">
	<table>
	<tr><td width=22%>&nbsp</td><td>
        <INPUT TYPE="text" NAME="search" id="search" size="30" value="$search">
        </td><td>
	    <input type="submit" value="search"></td></tr>
	</table>
</form>
HTML
}

return true;
