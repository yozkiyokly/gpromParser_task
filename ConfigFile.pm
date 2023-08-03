# package ConfigFile;
# Скрипт маленький, потому смело пользуемся глобальными переменными, массивами и валим код безо STRICT:
# Если потребуется абсолютный url (без слэша в конце):
 $baseurl="/cgi-bin";

#Конфигурацию SQL, тем не менее, прячем внутри функции, наружу уйдёт только готовый указатель:
sub ConnectToMySql {
    my $host = "localhost";

    # Серверозависимые credentials для БД ради единства версии на тестовом сервере и на гитхабе:
    # С переходом к стрикту весь этот мусор будет смыт.
    use Sys::Hostname;
    if (hostname() == 'yozki'){
use DBD::MariaDB; # для отладочного сервера (где Debian bookworm _Testing_).
        my $port=3306;
         $db = "gprom";
         $userid = "gprom";
         $passwd = "miller";
        }else{
use DBD::mysql; # и надо же mySQL устареть! Теперь гляньте - МарияДБ и внезапное участие Оракла.
         $port=3308;
         $db = "yozki";
         $userid = "yozki";
         $passwd = "qwe123_QWE123";
        }
    my $connectionInfo="dbi:mysql:$db;$host;$port";
    my $dbHandler = DBI->connect($connectionInfo,$userid,$passwd);
    return $dbHandler;
}

$dbh = ConnectToMySql($Database); #Коннектимся в начале скрипта, до появления заголовков.

return true;
