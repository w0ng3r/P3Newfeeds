<?php

/*

Parsing the RSS feed

*/
    echo 'Start </br>';
  $doc = new DOMDocument();
  #$doc->load('http://www.softarea51.com/rss/windows/Web_Development/XML_CSS_Utilities.xml');
  $doc->load('http://rss.cnn.com/rss/cnn_topstories.rss');
  $arrFeeds = array();
  foreach ($doc->getElementsByTagName('item') as $node) {
    $itemRSS = array ( 
      'title' => $node->getElementsByTagName('title')->item(0)->nodeValue,
      'desc' => $node->getElementsByTagName('description')->item(0)->nodeValue,
      'link' => $node->getElementsByTagName('link')->item(0)->nodeValue,
      'date' => $node->getElementsByTagName('pubDate')->item(0)->nodeValue
      );
      echo 'record -- </br>';
      echo  'TITLE: ' . $node->getElementsByTagName('title')->item(0)->nodeValue .
      'desc => '  . $node->getElementsByTagName('description')->item(0)->nodeValue .
      'link => ' . $node->getElementsByTagName('link')->item(0)->nodeValue .
      'date => ' . $node->getElementsByTagName('pubDate')->item(0)->nodeValue . '</br>';
      
    array_push($arrFeeds, $itemRSS);
  }

?>
