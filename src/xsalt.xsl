<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:ext="http://exslt.org/common"
  xmlns="http://www.w3.org/1999/xhtml"
>

  <xsl:output method="html" encoding="utf-8" indent="yes" doctype-system="about:legacy-compat" omit-xml-declaration="yes" />
  <xsl:strip-space elements="*" />

  <!-- ========= x-store ========= -->

  <xsl:variable name="x-store-source">
    <xsl:choose>
      <xsl:when test="//x-store/*"> <!-- x-store's content is inlined -->
        <xsl:copy-of select="//x-store/*"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates mode="x-store" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="x-store" select="ext:node-set($x-store-source)" />

  <!-- ========= Boot ========= -->

  <xsl:template match="/">
    <xsl:copy>
      <xsl:variable name="init">
        <xsl:apply-templates select="@*|node()" />
      </xsl:variable>
      <xsl:variable name="xalur">
        <xsl:apply-templates select="ext:node-set($init)/*" mode="xalur" />
      </xsl:variable>
      <xsl:variable name="bbb">
        <xsl:apply-templates select="ext:node-set($xalur)/*" mode="bbb" />
      </xsl:variable>
      <xsl:variable name="ccc">
        <xsl:apply-templates select="ext:node-set($bbb)/*" mode="ccc" />
      </xsl:variable>
      <xsl:variable name="eee">
        <xsl:apply-templates select="ext:node-set($ccc)/*" mode="eee" />
      </xsl:variable>
      <xsl:apply-templates select="ext:node-set($eee)/*" mode="ddd" />
    </xsl:copy>
  </xsl:template>

  <!-- ========= Init ========= -->

  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()" />
    </xsl:copy>
  </xsl:template>

  <!-- ========= xalur ========= -->

  <xsl:template match="@*|node()" mode="xalur">
    <xsl:choose>
      <xsl:when test="self::text()">
        <xsl:copy-of select="self::text()"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:variable name="x-component-transformed">
          <xsl:apply-templates select="." mode="x-component" />
        </xsl:variable>
        <xsl:variable name="x-component-orig-innerhtml">
          <xsl:copy-of select="./* | ./text()" />
        </xsl:variable>
        <xsl:choose>
          <xsl:when test="name(.) = name(ext:node-set($x-component-transformed)/*)"><!-- TODO: mettere qua un check piu forte -->
            <xsl:element name="{name()}" namespace="">
              <xsl:copy-of select="./@*" />
              <xsl:apply-templates select="./* | ./text()" mode="xalur" />
            </xsl:element>
          </xsl:when>
          <xsl:otherwise>

            <xsl:variable name="x-component">
              <xsl:element name="x-component" namespace="">

                <xsl:attribute name="x-component-orig-tag">
                  <xsl:value-of select="name()" />
                </xsl:attribute>
                <xsl:attribute name="x-component-id"><xsl:value-of select="generate-id(.)" /></xsl:attribute>
                <xsl:copy-of select="./@*" />

                <xsl:copy-of select="$x-component-transformed" />
                <xsl:element name="x-component-orig-innerhtml" namespace="">
                  <xsl:apply-templates select="ext:node-set($x-component-orig-innerhtml)" mode="xalur" />
                </xsl:element>

              </xsl:element>
            </xsl:variable>

            <xsl:variable name="x-component-scope">
              <xsl:apply-templates select="ext:node-set($x-component)" mode="scope" />
            </xsl:variable>
            <xsl:variable name="x-component-bem">
              <xsl:apply-templates select="ext:node-set($x-component-scope)" mode="bem" />
            </xsl:variable>
            <xsl:variable name="x-component-aaa">
              <xsl:apply-templates select="ext:node-set($x-component-bem)" mode="aaa" />
            </xsl:variable>
            <xsl:variable name="x-component-x-slot">
              <xsl:apply-templates select="ext:node-set($x-component-aaa)" mode="x-slot" />
            </xsl:variable>
            <xsl:apply-templates select="ext:node-set($x-component-x-slot)" mode="xalur" />

          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- ========= x-component ========= -->

  <xsl:template match="@*|node()" mode="x-component">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()" mode="x-component" />
    </xsl:copy>
  </xsl:template>

  <!-- ========= scope ========= -->

  <xsl:template match="@*|node()" mode="scope">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()" mode="scope" />
    </xsl:copy>
  </xsl:template>

  <xsl:template match="x-component[starts-with(./script/@autoselect, 'true')]/template/*" mode="scope">
    <xsl:copy>
      <xsl:copy-of select="./@*" />
      <xsl:attribute name="data-x-{ancestor::x-component[1]/@x-component-orig-tag}-id"><xsl:value-of select="ancestor::x-component[1]/@x-component-id"/></xsl:attribute>
      <xsl:apply-templates mode="scope" />
    </xsl:copy>
  </xsl:template>

  <xsl:template match="x-component[starts-with(./script/@autoselect, 'true')]/template/*//*[@class]" mode="scope">
    <xsl:copy>
      <xsl:copy-of select="./@*" />
      <xsl:attribute name="data-x-{ancestor::x-component[1]/@x-component-id}"></xsl:attribute>
      <xsl:apply-templates mode="scope" />
    </xsl:copy>
  </xsl:template>

  <!-- ========= Apply template bem ========= -->

  <xsl:template match="@*|node()" mode="bem">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()" mode="bem" />
    </xsl:copy>
  </xsl:template>

  <xsl:template name="construct-bem-class">

    <xsl:param name="x-component" />

    <xsl:variable name="block-prefix">
      <xsl:value-of select="concat(
        $x-component/@x-component-orig-tag,
        '__'
      )" />
    </xsl:variable>

    <xsl:variable name="bemmed-class-init">
      <xsl:choose>
        <xsl:when test="starts-with(./@class, '__')"><xsl:value-of select="concat(
          $block-prefix,
          substring(./@class,3)
        )" /></xsl:when>
        <xsl:otherwise><xsl:value-of select="./@class" /></xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:variable name="bemmed-class-init-2">
      <xsl:value-of select="translate(
        $bemmed-class-init,
        ' ',
        '^'
      )" />
    </xsl:variable>

    <xsl:variable name="bemmed-class-init-3">
      <xsl:call-template name="string-replace-all">
        <xsl:with-param name="text" select="$bemmed-class-init-2" />
        <xsl:with-param name="replace">^__</xsl:with-param>
        <xsl:with-param name="by" select="concat(
          ' ',
          $block-prefix
        )"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="bemmed-class">
      <xsl:value-of select="translate(
        $bemmed-class-init-3,
        '^',
        ' '
      )" />
    </xsl:variable>

    <xsl:attribute name="class"><xsl:value-of select="$bemmed-class" /></xsl:attribute>

  </xsl:template>

  <xsl:template match="x-component/template[@autobem='true']//*[not(name()='x-component')][@class]" mode="bem">
    <xsl:copy>
      <xsl:copy-of select="./@*[name()!='class']" />
      <xsl:call-template name="construct-bem-class">
        <xsl:with-param name="x-component" select="ancestor::x-component[1]" />
      </xsl:call-template>
      <xsl:apply-templates mode="bem" />
    </xsl:copy>
  </xsl:template>

  <!-- ========= Expand: bem ========= -->

  <xsl:template match="@*|node()" mode="aaa">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()" mode="aaa"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="x-component/template[@autobem='true']/*" mode="aaa">
    <xsl:copy>
      <xsl:copy-of select="./@*[name()!='class']" />
      <xsl:variable name="tag-name">
        <xsl:value-of select="../../@x-component-orig-tag" />
      </xsl:variable>
      <xsl:variable name="bem-class">
        <xsl:choose>
          <xsl:when test="./@class">
            <xsl:choose>
              <xsl:when test="contains(concat(' ', ./@class, ' '), concat(' ', $tag-name, ' '))">
                <xsl:value-of select="./@class" />
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="concat(./@class, concat(' ' , $tag-name))" />
              </xsl:otherwise>
            </xsl:choose>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$tag-name" />
          </xsl:otherwise>
        </xsl:choose>
      </xsl:variable>
      <xsl:attribute name="class">
        <xsl:value-of select="$bem-class" />
      </xsl:attribute>
      <xsl:apply-templates mode="aaa"/>
    </xsl:copy>
  </xsl:template>

  <!-- ========= Slots handling ========= -->

  <xsl:template match="@*|node()" mode="x-slot">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()" mode="x-slot"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="x-component/template//*[name()='x-slot' and not(@name)]" mode="x-slot">
    <xsl:variable name="x-component-orig-innerhtml" select="ancestor::x-component[1]/x-component-orig-innerhtml[1]" />
    <xsl:copy-of select="$x-component-orig-innerhtml/* | $x-component-orig-innerhtml/text()" /><!-- TODO: aggiungi default slot content -->
  </xsl:template>

  <xsl:template match="x-component/template//*[name()='x-slot' and @name]//x-slot-content" mode="x-slot">
    <xsl:copy>

      <xsl:variable name="x-slot" select="ancestor::x-slot[@name][1]" />
      <xsl:variable name="x-component-orig-innerhtml" select="ancestor::x-component[1]/x-component-orig-innerhtml[1]" />
      <xsl:variable
        name="template"
        select="$x-component-orig-innerhtml//*[name()='template' and @x-slot=$x-slot/@name][1]"
      />

      <xsl:choose>
        <xsl:when test="$template" >
          <xsl:copy-of select="$template/* | $template/text()" />
        </xsl:when>
        <xsl:otherwise>
          <xsl:element name="x-slot-remove" namespace="" /><!-- TODO: aggiungi default slot content -->
        </xsl:otherwise>
      </xsl:choose>

    </xsl:copy>
  </xsl:template>

  <!-- ========= Add: component-orig-tag ========= -->

  <xsl:template match="@*|node()" mode="bbb">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()" mode="bbb"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template name="merge-components">

    <xsl:param name="x-component" />
    <xsl:param name="class" />

    <xsl:variable name="class-merged">
      <xsl:choose>
        <xsl:when test="$class and $x-component/@class">
          <xsl:value-of select="concat($class , concat(' ' , $x-component/@class))" />
        </xsl:when>
        <xsl:when test="$x-component/@class">
          <xsl:value-of select="$x-component/@class" />
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$class" />
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:choose>
      <xsl:when test="name($x-component)='x-component'">
        <xsl:copy-of select="$x-component/@*[name()!='x-component-orig-tag']" />
        <xsl:call-template name="merge-components">
          <xsl:with-param name="x-component" select="$x-component/../.." />
          <xsl:with-param name="class" select="$class-merged" />
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:if test="$class!=''">
          <xsl:attribute name="class"><xsl:value-of select="$class" /></xsl:attribute>
        </xsl:if>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="x-component/template/*" mode="bbb">
    <xsl:copy>
      <xsl:copy-of select="./@*" />
      <xsl:copy-of select="../../@*" />
      <xsl:call-template name="merge-components">
        <xsl:with-param name="x-component" select = "../.." />
        <xsl:with-param name="class" select = "./@class" />
      </xsl:call-template>
      <xsl:apply-templates mode="bbb"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="x-component/*" mode="bbb">
    <xsl:variable name="x-component" select=".." />
    <xsl:copy>
      <xsl:copy-of select="./@*" />
      <xsl:copy-of select="$x-component/@x-component-orig-tag" />
      <xsl:apply-templates mode="bbb"/>
    </xsl:copy>
  </xsl:template>

  <!-- ========= Handle: body + head ========= -->

  <xsl:template match="@*|node()" mode="ccc">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()" mode="ccc"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="body" mode="ccc">
    <xsl:copy>

      <xsl:for-each select="//body/@*|node()|text()">
        <xsl:copy-of select="." />
      </xsl:for-each>

      <xsl:variable name="js-def">
        window.xsalt={componentInit:{}};
        <xsl:if test="//x-component/script[@autoselect]">
        window.xsalt.autoselect=function(tag,node,wrapper){
          var r=[];
          Array.prototype.slice.call(
            node?[node]:document.querySelectorAll('[data-x-'+tag+'-id]')
          ).forEach(function(n,i){
            r[i]={};
            r[i].$refs={};
            var els=Array.prototype.slice.call(n.querySelectorAll('[data-x-'+n.getAttribute('data-x-'+tag+'-id')+'][class*="$"]'));
            els.push(n);
            els.forEach(function(e){
              Array.prototype.slice.call(e.classList).forEach(function(className){
                if(className.indexOf('$')!==0)return;
                var el=className.slice(1);
                if(!r[i].$refs[el])r[i].$refs[el]=e;
                else if(Array.isArray(r[i].$refs[el]))r[i].$refs[el].push(e);
                else r[i].$refs[el]=[r[i].$refs[el],e];
              });
            });
            if(wrapper)for(var e in r[i].$refs)r[i].$refs[e]=wrapper(r[i].$refs[e]);
          });
          return r;
        };
        </xsl:if>
        <!-- customelement -->
        <xsl:if test="//x-component/custom-elements[@xslt-import-url]">
        window.xsalt.importXsl=function(url){
          return new Promise(function(res,rej){
            var xhr=new XMLHttpRequest();
            xhr.open('GET',url,false);
            xhr.onload=function(){
              var xsl=xhr.responseXML;
              window.xsalt.XSLTProcessor=new XSLTProcessor();
              window.xsalt.XSLTProcessor.importStylesheet(xsl);
              xsl=document.implementation.createDocument('','',null);
              window.xsalt.DOMParser=new DOMParser();
              window.xsalt.customElements.define([<xsl:for-each select="//x-component/custom-elements/*"><xsl:sort select="position()" data-type="number" order="descending" />'<xsl:value-of select="./@x-component-orig-tag" />',</xsl:for-each>]);
              if(xhr.status>=200&amp;&amp;xhr.status&lt;300)res(xhr.response);
              else rej({status:xhr.status,statusText:xhr.statusText});
            };
            xhr.onerror=function(){rej({status:xhr.status,statusText:xhr.statusText})};
            xhr.send(null);
          });
        };
        window.xsalt.customElements={
          id:0,
          define:function(tag){
            if(Array.isArray(tag)){tag.forEach(window.xsalt.customElements.define);return;}
            if(window.customElements.get(tag))return;
            window.customElements.define(tag,class extends HTMLElement{constructor(){super();
            var doc=window.xsalt.DOMParser.parseFromString(this.outerHTML,'application/xml');
            var fragment=window.xsalt.XSLTProcessor.transformToFragment(doc, document);
            var node=fragment.firstElementChild;
            this.parentNode.replaceChild(node,this);
            const xId=node.getAttribute('data-x-'+tag+'-id');
            node.setAttribute('data-x-'+tag+'-id','id-ce-'+(++window.xsalt.customElements.id));
            node.querySelectorAll('[data-x-'+xId+']').forEach(function(n){
              n.removeAttribute('data-x-'+xId);
              n.setAttribute('data-x-'+'id-ce-'+window.xsalt.customElements.id,'');
            });
            window.xsalt.componentInit[tag]&amp;&amp;window.xsalt.autoselect(
              tag,
              node,
              window.xsalt.componentInit[tag].wrapper
            ).forEach(function(e){window.xsalt.componentInit[tag].call(e);});
          }})}
        };
        window.xsalt.importXsl('<xsl:value-of select="//x-component/custom-elements/@xslt-import-url" />');
        </xsl:if>
        <!-- \customelement -->
      </xsl:variable>

      <xsl:if test="//x-component/script[@autoselect] or //x-component/custom-elements[@xslt-import-url]">
        <xsl:element name="script" namespace=""
          ><xsl:value-of select="normalize-space($js-def)"
        /></xsl:element>
      </xsl:if>

      <xsl:if test="ext:node-set($x-store)/@x-store-js = 'true' or ext:node-set($x-store)//*/@x-store-js = 'true'">
        <xsl:element name="script" namespace="">
          <xsl:attribute name="type" namespace="">application/xml</xsl:attribute>
          <xsl:attribute name="id" namespace="">xsalt-x-store</xsl:attribute>
          <xsl:choose>
            <xsl:when test="ext:node-set($x-store)/@x-store-js = 'true'">
              <xsl:apply-templates select="ext:node-set($x-store)/*" mode="x-store-js" />
            </xsl:when>
            <xsl:otherwise>
              <xsl:apply-templates select="ext:node-set($x-store)//*[@x-store-js = 'true'][1]" mode="x-store-js" />
            </xsl:otherwise>
          </xsl:choose>
        </xsl:element>
        <xsl:element name="script" namespace="">if(!window.xsalt)window.xsalt={};window.xsalt.xStore=(new DOMParser()).parseFromString(window.document.getElementById('xsalt-x-store').innerHTML,'text/xml');</xsl:element>
      </xsl:if>

      <xsl:for-each select="//x-component/insertAdjacentHTML[
        @tagName='body' and
        @position='beforeend' and
        not(@x-component-orig-tag=preceding::insertAdjacentHTML
          [@tagName='body' and @position='beforeend']/@x-component-orig-tag
        )
      ]"><xsl:copy-of select="./*" /></xsl:for-each>

      <xsl:if test="//x-component/script">
        <xsl:element name="script" namespace="">
          <xsl:for-each select="//x-component/script[
            not(@x-component-orig-tag=preceding::script/@x-component-orig-tag)
          ]">
            <xsl:sort select="position()" data-type="number" order="descending" />
            <xsl:choose>
              <xsl:when test="starts-with(./@autoselect, 'true')">window.xsalt.componentInit['<xsl:value-of select="./@x-component-orig-tag"/>']=function(){var $refs=this.$refs;<xsl:value-of select="." />};window.xsalt.componentInit['<xsl:value-of select="./@x-component-orig-tag"/>'].wrapper=<xsl:choose>
                  <xsl:when test="starts-with(./@autoselect, 'true|')">
                    <xsl:variable name="wrapper">
                      <xsl:call-template name="string-replace-all">
                        <xsl:with-param name="text" select="./@autoselect" />
                        <xsl:with-param name="replace">true|</xsl:with-param>
                        <xsl:with-param name="by"></xsl:with-param>
                      </xsl:call-template>
                    </xsl:variable><xsl:value-of select="$wrapper"/>
                  </xsl:when>
                  <xsl:otherwise>null</xsl:otherwise>
                </xsl:choose>;window.xsalt.autoselect('<xsl:value-of select="./@x-component-orig-tag"/>',null,window.xsalt.componentInit['<xsl:value-of select="./@x-component-orig-tag"/>'].wrapper).forEach(function(e){window.xsalt.componentInit['<xsl:value-of select="./@x-component-orig-tag"/>'].call(e)});</xsl:when>
              <xsl:when test="./@scoped='false'"><xsl:value-of select="." /></xsl:when>
              <xsl:otherwise>(function(){<xsl:value-of select="." />}());</xsl:otherwise>
            </xsl:choose>
          </xsl:for-each>
        </xsl:element>
      </xsl:if>

    </xsl:copy>
  </xsl:template>

  <xsl:template match="head" mode="ccc">
    <xsl:copy>

      <xsl:for-each select="//head/@*|node()|text()">
        <xsl:copy-of select="." />
      </xsl:for-each>

      <xsl:for-each select="//x-component/insertAdjacentHTML[
        @tagName='head' and
        @position='beforeend' and
        not(@x-component-orig-tag=preceding::insertAdjacentHTML
          [@tagName='head' and @position='beforeend']/@x-component-orig-tag
        )
      ]">
        <xsl:copy-of select="./*" />
      </xsl:for-each>

      <xsl:element name="style" namespace="">
        <xsl:for-each select="//x-component/style[
          not(@x-component-orig-tag=preceding::style/@x-component-orig-tag)
        ]">
          <xsl:variable name="style-content">
            <xsl:choose>
              <xsl:when test="./@autobem = 'true'">
                <xsl:call-template name="string-replace-all">
                  <xsl:with-param name="text" select="." />
                  <xsl:with-param name="replace">\$\</xsl:with-param>
                  <xsl:with-param name="by" select="./@x-component-orig-tag"/>
                </xsl:call-template>
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="." />
              </xsl:otherwise>
            </xsl:choose>
          </xsl:variable>
          <xsl:choose>
            <xsl:when test="./@normalize-space = 'false'">
              <xsl:value-of select="$style-content" />
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="normalize-space($style-content)" />
            </xsl:otherwise>
          </xsl:choose>
        </xsl:for-each>
      </xsl:element>

    </xsl:copy>
  </xsl:template>

  <!-- ========= auto-xmlns-namespace ========= -->

  <xsl:template match="@*|node()" mode="eee">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()" mode="eee"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="*[attribute::*[contains(local-name(),'..')]]" mode="eee">
    <xsl:copy>
      <xsl:for-each select="@*">
        <xsl:choose>
          <xsl:when test="contains(local-name(),'..')" >
            <xsl:attribute
              name="{substring-before(local-name(),'..')}:{substring-after(local-name(),'..')}"
              namespace="/"
            >
              <xsl:value-of select="." />
            </xsl:attribute>
          </xsl:when>
          <xsl:otherwise>
            <xsl:copy-of select="." />
          </xsl:otherwise>
        </xsl:choose>
      </xsl:for-each>
      <xsl:apply-templates mode="eee"/>
    </xsl:copy>
  </xsl:template>

  <!-- ========= Cleanup ========= -->

  <xsl:template match="@*|node()" mode="ddd">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()" mode="ddd"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="template[@x-component-orig-tag]" mode="ddd">
    <xsl:apply-templates mode="ddd"/>
  </xsl:template>
  <xsl:template match="x-component" mode="ddd">
    <xsl:apply-templates mode="ddd"/>
  </xsl:template>
  <xsl:template match="x-slot" mode="ddd">
    <xsl:apply-templates mode="ddd"/>
  </xsl:template>
  <xsl:template match="x-slot-content" mode="ddd">
    <xsl:apply-templates mode="ddd"/>
  </xsl:template>
  <xsl:template match="template[@x-slot]" mode="ddd">
    <xsl:apply-templates mode="ddd"/>
  </xsl:template>
  <xsl:template match="x-store" mode="ddd" />
  <xsl:template match="x-component-orig-innerhtml" mode="ddd" />
  <xsl:template match="x-component/*[@x-component-orig-tag and name(.)!='template']" mode="ddd" />
  <xsl:template match="//x-slot[.//x-slot-remove]" mode="ddd" />
  <xsl:template match="template[@x-slot]" mode="ddd" />
  <xsl:template match="@x-component-orig-tag" mode="ddd" />
  <xsl:template match="@x-component-id" mode="ddd" />

  <!-- ========= Helpers ========= -->

  <xsl:template name="string-replace-all"><!-- https://stackoverflow.com/questions/3067113/xslt-string-replace -->
    <xsl:param name="text" />
    <xsl:param name="replace" />
    <xsl:param name="by" />
    <xsl:choose>
      <xsl:when test="$text = '' or $replace = ''or not($replace)" >
        <xsl:value-of select="$text" />
      </xsl:when>
      <xsl:when test="contains($text, $replace)">
        <xsl:value-of select="substring-before($text,$replace)" />
        <xsl:value-of select="$by" />
        <xsl:call-template name="string-replace-all">
          <xsl:with-param name="text" select="substring-after($text,$replace)" />
          <xsl:with-param name="replace" select="$replace" />
          <xsl:with-param name="by" select="$by" />
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$text" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="@*|node()" mode="x-store-js">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()" mode="x-store-js"/>
    </xsl:copy>
  </xsl:template>
  <xsl:template match="script" mode="x-store-js" />
  <xsl:template match="@x-store-js" mode="x-store-js" />

</xsl:stylesheet>