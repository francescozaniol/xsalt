<?php
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
