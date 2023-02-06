<?php
include '../tools/php/Xsalt.php';

$dirs = [
  'basic',
  'slots',
  'sfc',
];

foreach ($dirs as $dir) {
  Xsalt::build("./$dir/index.xhtml", "./$dir/build.html");
}
