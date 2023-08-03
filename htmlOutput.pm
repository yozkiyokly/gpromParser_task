# package HTMLOutput;

#---###########
sub printHeader($title){
charset('utf-8'); # Всегда забываю о кодировке: вспоминаю при появлении кракозябров.
print header.'
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//RU" >
<html lang="ru">
<head>
<meta charset="UTF-8" />
<title>',@_[0],'</title></head>
<body>
';
}

#---###########
sub printFooter(){
print "<br><br><pre><small><font color='grey'>
\n
yozki.com</small></pre><font>";
print "\n\n</body></html>\n\n";}


#---##########
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

#---############# Сюда же временнно разщмещён вывод админ-меню:
sub checkLogTable($dbh){
$query = "select count(*), MIN(created) AS minDate, MAX(created) AS maxDate  FROM message";
$sth = $dbh->prepare($query);
$sth->execute();
@dataOld = $sth->fetchrow_array();

$query = "select count(*), MIN(created) AS minDate, MAX(created) AS maxDate  FROM log";
$sth = $dbh->prepare($query);
$sth->execute();
@data = $sth->fetchrow_array();
	print	"<table border=0 cellpadding=8><tr>
			<td valign='top'>В предыдущей загрузке: <b>$dataOld[0]</b> строк.<br>";
	print	"<small>	min: <b>$dataOld[1]</b><br>
			max: <b>$dataOld[2]</b></small>" if  $dataOld[0];
	print	"</td>";

	print	"<td width='10%'>&nbsp;</td>\n" ;
	print	"<td valign='top'>В аналитическом буфере: <b>"	.	$data[0]. "</b> строк<br>";
	print	"<small> min: <b>$data[1]</b> <br> 
			max: <b>$data[2]</b></small> " if $data[0];
	print	"</td></tr>\n" ;

	print	"<tr><td colspan=3 bgcolor='ffebeb'> Аналитическая таблица пуста. <br>
			Восстановите предыдущую загрузку или обработайте новый файл лога:</td></tr>" if !$data[0];

	print	"<br><tr><td valign=bottom>
			<form action='?refill=1' method=post>
			<input type='submit' name='restore' value='Восстановить из предыдущей загрузки'></form>\n
			</td><td></td><td valign=bottom>
			<form action='?refill=2' method=post  ENCTYPE='MULTIPART/FORM-DATA'>
			<input type='file' name='upload' value='' title='Выбрать новый файл'><br>
			<input type='submit' name=submit value='...загрузить и обработать новый лог'>
			</form>
			</td>
			</tr></table>";
return 	$data[0];
}

#---##################
sub searchResultsPrint($search,$dbh){
#-------found log strings and do listing inside primitive table:
print "<table border=0 width=80%>\n";
print "<tr><td>Date</td><td colspan=2>id</td></tr>\n";

$query = "select * FROM log where address LIKE '%$search%' LIMIT 100";
$sth = $dbh->prepare($query);
$sth->execute();

$bgcolor = "#EEEEEE";
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

return true;

