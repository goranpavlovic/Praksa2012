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

	foreach($container->find('p') as $p)
	{
		if($i === 1)
		{

		}
		else 
		{
			$description = $description . $p->plaintext;
		}	
		$i++;
	}

	$info = array();
	$info['Valid'] = false;
	if($description)
		$info['Description'] = $description;
	if($frequency)
		$info['Frequency'] = $frequency->plaintext;
	if($synopsys)
		$info['Synopsys'] = $synopsys->plaintext;
	if($image)
		$info['Image'] = $image->src;
	$info['Valid'] = true;
	return $info;
}

$link = 'http://www.b92.net/tv/program.php';

$timestamp = date("d-m-Y");


for($i=1; $i<=7; $i++)
{
$html = file_get_html('http://www.b92.net/tv/program.php' . '?id=' . strval($i));

if($i !== 1)
{
	$t = date_create($timestamp);
	$t = date_add($t,date_interval_create_from_date_string('1day'));
	$timestamp = $t->format('d-m-Y');
}

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
	$show['Attributes'] = Array();
	
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
	
	
	//name
	$attribute['AttributeName'] = 'Name';
	$attribute['AttributeSet'] = 'General';
	$attribute['AttributeValue'] = $name;
	array_push($show['Attributes'], $attribute);
	if($link['Valid'])
	{
		//description
		if($link['Description'])
		{
			$attribute['AttributeName'] = 'Description';
			$attribute['AttributeSet'] = 'General';
			$attribute['AttributeValue'] = $link['Description'];
			array_push($show['Attributes'], $attribute);
		}
		//image
		if($link['Image'])
		{
			$attribute['AttributeName'] = 'Picture';
			$attribute['AttributeSet'] = 'General';
			$attribute['AttributeValue'] = $link['Image'];
			array_push($show['Attributes'], $attribute);
		}
		//synopsys
		if($link['Synopsys'])
		{
			$attribute['AttributeName'] = 'Synopsis';
			$attribute['AttributeSet'] = 'Movie Set';
			$attribute['AttributeValue'] = $link['Synopsys'];
			array_push($show['Attributes'], $attribute);
		}
	}
	
	$show['Time'] = $time;
	$show['Type']= $type;
	array_push($shows, $show);
}

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