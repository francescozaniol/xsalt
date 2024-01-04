<?php
include '../tools/php/Xsalt.php';

$dirs = [
  'basic',
  'slots',
  'sfc',
  'autobem',
  'x-store/inline',
  'x-store/js',
  'x-store/local',
  'x-store/xslt',
  'autoselect',
  'custom-elements',
  'petite-vue',
  'petite-vue-components',
];

foreach ($dirs as $dir) {
  Xsalt::build("./$dir/index.xhtml", "./$dir/build.html");
}
