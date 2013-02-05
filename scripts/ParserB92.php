<?php

include 'simplehtmldom_1_5/simple_html_dom.php';

function getInfo($href,$type)
{
	$href = 'http://www.b92.net' . $href;
	$html = file_get_html($href);
	
	$container = $html->find('div[class=article-text]',0);
	
	$name = $container->find('h1',0);
	
	$frequency = $container->find('span[class=article-info1]',0);
	
	$synopsys = $container->find('p',0);
	
	$image = $container->find('img',0);
	
	$i = 1;
	$description = '';
	/*$rezija = '';
	$uloge = '';
	$trajanje = '';
	$zanr = '';
	$produkcija = '';
	$autor= '';
	$produkcija = '';*/
	foreach($container->find('p') as $p)
	{
		if($i === 1)
		{
			echo $p->plaintext;
		}
		/*//filtriranje
		else if(strpos($p->plaintext,'Režija:'))
			echo '<br/>rezija: ' . str_replace('Režija:', '', $rezija = $p->plaintext);
		else if(strpos($p->plaintext,'Uloge:'))
			echo '<br/>uloge: ' . str_replace('Uloge:', '', $uloge = $p->plaintext);
		else if(strpos($p->plaintext,'Žanr:'))
			echo '<br/>zanr: ' . str_replace('Žanr:', '', $zanr = $p->plaintext);
		else if(strpos($p->plaintext,'Trajanje:'))
			echo '<br/>trajanje: ' . str_replace('Trajanje:', '', $trajanje = $p->plaintext);
		else if(strpos($p->plaintext,'Produkcija:'))
			echo '<br/>produkcija: ' . str_replace('Produkcija:', '', $produkcija = $p->plaintext);
		else*/
			$description = $description . $p->plaintext;
			
		$i++;
	}
	echo '<br/><br/>opis: ' . $description . '<br/>';
	$info = array();
	$info['Valid'] = false;
	$info['Description'] = $description;
	$info['Frequency'] = $frequency;
	$info['Synopsys'] = $synopsys;
	$info['Image'] = $image;
	$info['Valid'] = true;
	return $info;
}

$link = 'http://www.b92.net/tv/program.php';

$timestamp = date("d-m-Y");


for($i=1; $i<=7; $i++)
{
	//$i = 1;
$html = file_get_html('http://www.b92.net/tv/program.php' . '?id=' . strval($i));

if($i !== 1)
{
	$t = date_create($timestamp);
	$t = date_add($t,date_interval_create_from_date_string('1day'));
	$timestamp = $t->format('d-m-Y');
}

//$dateTag = $html->find('div[class=currentDate]', 0);
$table = $html->find('table[class=program]',0);

$json = array();
$json["TV"] = 'B92';
$json["Date"] = $timestamp;
$json['Shows'] = array();
$shows = array();


foreach($table->find('tr') as $tr)
{
	$attribute = array();
	$attributes = array();
	$show = array();
	
	$time = $tr->find('td[class=vreme]',0)->plaintext;
	
	$name = $tr->find('td',4)->plaintext;
	
	$type = '';
	if($info = $tr->find('td[class=info]',0)->plaintext)
	{
		$type = $info;
		if($type = 'Serija')
			$type = 'TV Show';
		else if($type = 'Film')
			$type = 'Movie';
		else
			$type = $type;
	}
	else
		$type = 'Broadcast';

	$link = array();
	$link['Valid'] = false;
	if($checkLink = $tr->find('td',4)->find('a',0))
		$link = getInfo($checkLink->href,$type);
	
	//echo 'Time: ' . $time . ' Name: ' . $name . ' Type: ' . $type . '  Link:' . $link . '</br>';
	
	//name
	$attribute['AttributeName'] = 'Name';
	$attribute['AttributeSet'] = 'General';
	$attribute['AttributeValue'] = $name;
	array_push($attributes, $attribute);
	/*if($link['Valid'])
	{
		//description
		$attribute['AttributeName'] = 'Description';
		$attribute['AttributeSet'] = 'General';
		$attribute['AttributeValue'] = $link['Description'];
		array_push($attributes, $attribute);
		//image
		$attribute['AttributeName'] = 'Picture';
		$attribute['AttributeSet'] = 'General';
		$attribute['AttributeValue'] = $link['Image'];
		array_push($attributes, $attribute);
		//synopsys
		$attribute['AttributeName'] = 'Synopsis';
		$attribute['AttributeSet'] = 'Movie Set';
		$attribute['AttributeValue'] = $link['Synopsys'];
		array_push($attributes, $attribute);
	}*/
	
	$show['Time'] = $time;
	$show['Type']= $type;
	//$show['Attributes'] = array();
	//array_push($show['Attributes'], $attributes);
	$show["Attributes"] = $attributes;
	array_push($shows, $show);
}

//array_push($json['Shows'], $shows);
$json["Shows"] = $shows;
$encode = json_encode($json);

$connection = mysql_connect('localhost', 'root', 'Praksa2012');

$database = mysql_select_db('Praksa2012', $connection);

$query = "SELECT Location from Path where Name='JsonFiles'";

$result = mysql_query($query);

$row = mysql_fetch_array($result);

$jsonFilesPath = $row["Location"];

$fajl = fopen($jsonFilesPath . 'B92'. $timestamp . ".json", 'w');
fwrite($fajl, $encode);
fclose($fajl);
}
?>