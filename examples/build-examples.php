<?php
ini_set('display_errors',1);
error_reporting(E_ALL | E_STRICT);

include '../tools/php/Xsalt.php';

$dirs = [
  'basic',
  'slots',
  'sfc',
  'autobem',
  'x-store',
  'autoselect',
];

foreach ($dirs as $dir) {
  Xsalt::build("./$dir/index.xhtml", "./$dir/build.html");
}
