<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ci" lang="ci">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
<body>
<?php
include 'simplehtmldom_1_5/simple_html_dom.php';

function RTSDatumi($mesec)
{

$result = null;
	switch($mesec) {
		case 'jan':
			$result = '01';
			break;
		case 'feb':
			$result = '02';
			break;
		case 'mar':
			$result = '03';
			break;
		case 'apr':
			$result = '04';
			break;
		case 'maj':
			$result = '05';
			break;
		case 'jun':
			$result = '06';
			break;
		case 'jul':
			$result = '07';
			break;
		case 'avg':
			$result = '08';
			break;
		case 'sep':
			$result = '09';
			break;
		case 'okt':
			$result = '10';
			break;
		case 'nov':
			$result = '11';
			break;
		case 'dec':
			$result = '12';
			break;
}

return $result;
			
}
//$html = file_get_html('http://www.rts.rs/page/tv/ci/broadcast/17/%D0%A0%D0%A2%D0%A1+1.html');
$html = file_get_html('http://www.rts.rs/page/tv/sr/broadcast/20/RTS+1.html');

$datum = $html->find('div[id=center]',0)->find('h1',0)->plaintext;

$datum = strstr($datum, ',');

$datum = str_replace('&nbsp;', ' ',$datum);

$niz = explode(' ',$datum);
$dan  = str_replace('.','',$niz[1]);	//dan
$mesec = RTSDatumi($niz[2]);//mesec
$godina = $niz[3];//godina

	echo 'dan: ' . $dan . '<br/>Mesec: ' . $mesec . '<br/>Godina: ' . $godina . '<br/>';
$tabela = $html->find('div[id=ProgramskaSemaContainer]',0);

$file = fopen('parse.json','w');
if(!$file)
	echo 'error opening file';
else
{

	foreach($tabela->children() as $child)
	{
		$time = trim($child->find('div[class=ProgramTime]',0)->plaintext);
		//echo mb_detect_encoding(trim($child->find('div[class=ProgramName]',0)->plaintext));
		$name = trim($child->find('div[class=ProgramName]',0)->plaintext);
		$age = trim($child->find('div[class=ProgramAge]',0)->first_child()->alt);
		$age = str_replace('pg','',$age);
		//echo '<br/>';

		$type = '';
		if($child->find('div[class=ProgramType ColorVesti]', 0))
		{
			$type = 'Broadcast';
		}
		else if($child->find('div[class=ProgramType ColorSport]', 0))
		{
			$type = 'Sports Event';
		}
		else if($child->find('div[class=ProgramType ColorSerije]', 0))
		{
			$type = 'TV Show';
		}
		else if($child->find('div[class=ProgramType ColorFilmovi]', 0))
		{
			$type = 'Movie';
		}
		else
		{
			$type = 'Show';
		}
		$string = trim($time) .' ' . trim($name) .' '. trim($age) . "\n";
		$date = $dan . '-' . $mesec . '-' . $godina;
		$arr = array('Date' => $date ,'Time' => $time, 'Name' => $name, 'Age' => $age, 'Type' => $type, 'TV' => 'RTS1');
		$json = json_encode($arr);
		fwrite($file,$json);
	}
}

fclose($file);
echo 'file closed';
$upis = fopen('text.txt','w');
if(! $fajl = fopen("parse.json","r"))
{
	echo "error";
}
else
{
	$pom = fgets($fajl);
	//fwrite($upis,mb_convert_encoding(pack( 'H*',$pom)), 'UTF-8');
	$assocArray = json_decode($pom, true);

	echo 'test';
	
	foreach($assocArray as $elem)
	{
		fwrite($upis, $elem->Name);
	}

	//echo $pom . '<br/>';
	if(!json_encode($pom))
		echo 'error';
	fclose($fajl);
	fclose($upis);
}
?>

</body>
</html>
