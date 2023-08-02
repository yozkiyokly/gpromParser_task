# package HTMLOutput;

#---###########
sub printHeader($title){
charset('utf-8');
return header,'
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//RU" >
<html lang="ru">
<head>
<meta charset="UTF-8" />
<title>',@_[0],'</title></head>
<body>';
}

#---###########
sub printFooter(){
print "<br><br><pre><small><font color='grey'>Прошу простить за дзен в оформлении: \nпредполагая, что первичным для анализа навыков и стиля мышления претендента является код, \nпредпочитаю посвятить больше времени именно этой стороне дела.\n\n
Sincerely, WRB-RIPN (yozki.com)</small></pre><font>";
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

#---#############
sub checkLogTable($dbh){
$query = "select count(*)  FROM log";
$sth = $dbh->prepare($query);
$sth->execute();
@data = $sth->fetchrow_array();
	print "<br>total rows in logtable is "	.	$data[0];
	
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

