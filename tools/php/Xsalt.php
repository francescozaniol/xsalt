<?php

/**
 * Usage example:
 * - Xsalt::render('./index.xhtml') = renders to standard output
 * - Xsalt::build('./index.xhtml', './index.html') = builds to static code and writes to ./index.html
 */
class Xsalt {

  public static function render($src) {

    $xml = new DOMDocument;
    $xsl = new DOMDocument;
    $proc = new XSLTProcessor;

    $xml->load($src);

    foreach ($xml->childNodes as $node) {
      if ( $node->nodeName === 'xml-stylesheet' ) {
        preg_match('/href=[\'"]([^\'"]+)[\'"]/i', $node->nodeValue, $xslHref);
        if ( count($xslHref) ) $xslHref = $xslHref[1];
        else $xslHref = null;
        continue;
      }
    }

    if ( !$xslHref ) return;

    $xsl->load(dirname(realpath($src))."/$xslHref");

    if ( $_GET['xsalt_debug'] === 'true' ) {
      libxml_use_internal_errors(true);
      ini_set('display_errors',1);
      error_reporting(E_ERROR);
    }

    $result = $proc->importStyleSheet($xsl);
    $errors = libxml_get_errors();

    if ( $_GET['xsalt_debug'] === 'true' ) {
      libxml_use_internal_errors(false);
    }

    echo $proc->transformToXML($xml);

    foreach ($errors as $error) {
      echo "Libxml error: {$error->message}<br/>";
    }
  }

  static function build($src, $target) {
    ob_start();
    self::render($src);
    $contents = ob_get_contents();
    ob_end_clean();

    file_put_contents($target, $contents);
  }
}