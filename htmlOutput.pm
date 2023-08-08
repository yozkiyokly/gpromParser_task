# package HTMLOutput;
# Впоследствии можем упаковать ради красивых HTMLOutput::searchResultsPrint
# Любопытно, что Perl CRiTiC неустанно ругает меня за кэмелНэймы. 
# Это всё раслабленные привычки PHP.


### Строка поиска, с сохранением ввода.
sub searchForm($search,$baseurl){
my ($search,$baseurl) = @_;
print '<form method="get" name="searching" action="'.$baseurl.'index.pl">';
print <<HTML
	<table>
	<tr><td width=22%>&nbsp</td><td>
        <INPUT TYPE="text" NAME="search" id="search" size="40" value="$search">
        </td><td>
	    <input type="submit" value="search"></td></tr>
	</table>
</form>
HTML
}

### вывод результатов поиска:
sub searchResultsPrint($search,$dbHandler){

my ($search,$dbHandler,$baseurl,$resultsPerPage,$fromPage) = @_;
#--OTLaDka:--# print $search. " <br>".$dbHandler. " <br>".$baseurl. " <br>".$resultsPerPage. " <br>".$fromPage. " <br>";

my $query = "SELECT COUNT(*) FROM log WHERE address LIKE '%$search%'";
my $sth = $dbHandler->prepare($query);
$sth->execute();
my @data = $sth->fetchrow_array();

$results_count = @data[0];
print '<ul><li>найдено: '.$results_count.'</li></ul>'; #--OTLaDka:--# parameters for pager = @data[0],$resultsPerPage,$fromPage,$link
#              ^^^^^^^^^^^^^^ ВОТ ЭТО - для бюрократически формального исполнения тестового задания.
# Требовалось: "ограничить сотней записей, если количество  превышает, должно выдаваться соответствующее сообщение."
# Следующие же две строки делают разбиение по страницам:
my $link='?search='.$search.'&fromPage=%d';
my $pager=Habra_pager ($results_count,$resultsPerPage,$fromPage,$link);
print $pager;

	$fromPage=$fromPage*$resultsPerPage-$resultsPerPage; #Приводим единицы к кратным числам 
	$query = "select * FROM log where address LIKE '%$search%' LIMIT $fromPage, 100";
	$sth = $dbHandler->prepare($query);
	$sth->execute();

	print '<table border=0 width=70% cellspacing=0  cellpadding=3 >';
	$bgcolor = '#ffe0e0';

	while (@data = $sth->fetchrow_array()) 	{

		$date = 		$data[0];
		$internal_ID = 	$data[1];
		$log_string = 	$data[2];
		$email = 		$data[3];
		if ($bgcolor =~ "#ffEEEE") { $bgcolor = "#ffe0e0"; }else{$bgcolor = "#ffEEEE";}
		$log_string =~ s/$search/\<font color=red\>$search\<\/font\>/g; #подкраска найденных подстрок
		print "<tr bgcolor=$bgcolor>
		<td>$date</td>
		<td>$internal_ID</td>
		</tr>
		<tr bgcolor=$bgcolor style='border-bottom: solid 1px'><td colspan=2><small>$log_string</small></td></tr>\n";
		}
	print "</table>\n\n";
print '<ul><li>всего: '.$results_count.'</li></ul>';
print $pager; #нижний постраничный стрип 
}

#######################################
sub Habra_pager($$$$){ # на входе 4 скаляра
# Это заимствованный исправленный ($linkCount+1, $i) вариант пейджера xoma	от 18.6.2009 11:51:
# 1 $count   - общее кол-во записей
# 2 $perPage - записей на странице
# 3 $curPage - текущая (активная)  страничка
# 4 $link    - ссылка, которая будет подставляться (пример "show/page/%d") - вместо %d - подставится номер страницы
 
my $count    = int(shift);
my $perPage  = int(shift);
my $curPage  = int(shift);
my $link     = shift;
    
my $linkCount = $count / $perPage;
my $start = $curPage - 4;
$start    = 1 if ($start <= 0);
my $stop  = $curPage + 4;
#--IIPABka:--# 	$stop     = $linkCount if ($stop > $linkCount);
				$stop     = $linkCount+1 if ($stop > $linkCount);
    
    my $out = '<ul class="pageList">';
    # ссылка на первые элементы списка
    $out.= "<li><a href='".sprintf($link,1)."'><---</a></li>" if ($start > 1);
    for(my $i = $start; $i <= $stop; $i++){
            my $displayLink = "<a href='".sprintf($link,$i)."'>$i</a>";
            # выделить текущую страницу
            if($i == $curPage){
#--IIPABka:--# $out.= "<li class='activePageLink'>$displayLink</li>";
               $out.= "<li class='activePageLink'>$i</li>";
            }else{
               $out.= "<li>$displayLink</li>";
            }
      }
    # ссылка "далее" на последний элемент списка
    $out .="<li><a href='".sprintf($link,$linkCount)."'>---></li>" if($stop < $linkCount);
    $out .= '</ul>';
return $out;
}




sub printHeader($title){
charset('utf-8'); # Всегда забываю о кодировке: вспоминаю при появлении кракозябров.
print header.'
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//RU" >
<html lang="ru">
<head>
<meta charset="UTF-8" />
<title>',@_[0],'</title>
<style>
body {
  background-color: linen;
  font-family: monospace;
}

input {
    border-radius: 5px;
	font-family: monospace;
    background-color: #fCfFf0;
    border: 1px solid #73AD21;
    color: 222;
    padding: 5px 8px;
    text-align: center;
    display: inline-block;
    font-size: 12px;
    margin: 8px 8px;
	-webkit-transition-duration: 0.4s; 
    transition-duration: 0.4s;
}
input[type=text] {
    text-align: left;
}

input:hover {
    background-color: #dffFd0;
}

ul,li {
       display:inline-block;
   margin: 11px 11px;
	-webkit-transition-duration: 0.4s; 
    transition-duration: 0.4s;
}

li {

	border-radius: 5px;
	font-family: monospace;
    background-color: #fCfFf0;
    border: 1px solid #73AD21;
    color: 222;
	padding: 3px 12px; 
}
li.activePageLink{
    background-color: #dffFd0;
	text-decoration: none;
}

</style></head>
<body>
';
}

#---###########
sub printFooter(){
print "<br><br><pre><small><font color='grey'>
\n
yozki.com<font></small></pre>";
print "\n\n</body></html>\n\n";}



### вывод блока управления таблицами:
sub show_menu($$$$$$){ # 6 скаляров входит в ф-цию. 4 сценария:
my ($numrowsOld, $minDateOld,$maxDateOld,$numrowsCache, $minDateCache,$maxDateCache) = @_;
#--OTLaDka:--# print $numrowsOld, $minDateOld,$maxDateOld,$numrowsCache, $minDateCache,$maxDateCache;
#--OTLaDka:--# print "sdsd<br>". int($numrowsOld);
	print	"<table border='0' cellpadding='8'>\n";
if (!$numrowsCache){
	print "<tr><td colspan=3 bgcolor='ff7755'><font color=white> Аналитическая таблица пуста.";
	print "<br>Восстановите предыдущую загрузку или " if int($numrowsOld);
	print "обработайте новый файл лога:</font></td></tr>";
}
	print "<tr>
			<td valign='top' style='border: 1px solid black;padding: 8px;border-bottom:none;'>В предыдущей загрузке: <b>$numrowsOld</b> строк.<br>";
	print	"<small>min: <b>$minDateOld</b><br>max: <b>$maxDateOld</b><br><a href=\"?delete=prev\"><font color=red>очистить</font></a></small>" 
	if int($numrowsOld) >0;
	print	"</td>";

	print	"<td width='10%'>&nbsp;</td>\n" ;
	print	"<td valign='top' style='border: 1px solid black;padding: 8px;border-bottom:none;'>В аналитическом буфере: <b>".$numrowsCache."</b> строк<br>";
	print	"<small>min: <b>$minDateCache</b> <br>max: <b>$maxDateCache</b><a href=\"?delete=cache\"><br><font color=red>очистить</font></a></small>"
	if $numrowsCache;
	print	"</td></tr>\n" ;

	print "<br><tr><td valign=bottom style='border: 1px solid black;padding: 8px;border-top:none;'>";
	print "<form action='?refill=1' method=post>Можно скопировать данные<br>отсюда в буфер:<br>
	<input type='submit' name='restore' value='Восстановить из предыдущей загрузки'></form>
	" if int($numrowsOld) >0; 
	print'</td><td></td>';

	print"<td valign=bottom style='border: 1px solid black;padding: 8px;border-top:none;'>
	<form action='?refill=2' method=post  ENCTYPE='MULTIPART/FORM-DATA'>
	Можно загрузить <br>новый файл лога:<br>
	<nobr><input type='file' size=24 name='upload' value='' title='Выбрать новый файл'><input type='submit' name=submit value='ok'></nobr></form>
	</td></tr></table>";
return 	$numrowsCache; #Далее будет удобно иметь колво строк в логе. Чтобы решения принимать.
}


#досвидос#
return true;
