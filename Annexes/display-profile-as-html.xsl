<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:profile="http://www.lido-schema.org/lidoProfile/" xmlns:tei="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="profile tei">
	<xsl:output method="html" encoding="UTF-8" indent="yes"/>
	
	<xsl:key match="tei:div[@type='ap_unit']" name="child-unit" use="tei:div[@type='ap_export']/tei:div[@type='ap_context']/tei:ref/@target"/>
	
	<xsl:variable name="uc" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'"/>
	<xsl:variable name="lc" select="'abcdefghijklmnopqrstuvwxyz'"/>
	<xsl:variable name="quot">&quot;</xsl:variable>
	<xsl:variable name="apos">&apos;</xsl:variable>
	
	<xsl:variable name="header">
		<head class="html_boxed"><meta charset="utf-8"/><meta http-equiv="X-UA-Compatible" content="IE=edge"/><meta name="viewport" content="width=device-width, initial-scale=1"/><title><xsl:value-of select="profile:lidoProfile/profile:title"/></title><style>body { font-family: Verdana, Tahoma, Geneva, Arial, Helvetica, sans-serif; margin: 0; color: #333; } .complexType, .attribute, .element { margin-bottom: 20px; margin-left: 40px; width: 90%; padding-bottom: 40px; border-bottom: 1px solid #333; } .description { border-bottom: 1px solid #eee; padding-bottom: 19px; } .description-content, .tech-info { margin-left: 20px; } .description-content + .description-content { margin-top: 20px; } .tech-info + .tech-info { margin-top: 10px; } ul, ol, dl { display: inline-block; margin: 0; padding-left: 10px; } div ul, p ul, span ul { display: block; margin: 0; margin-bottom: 20px; padding-left: 10px; } ul { list-style-type: circle; } a { text-decoration: none; color: #1A7979; } a:hover { text-decoration: underline; color: #549E9E; } .sequence, .in-sequence { margin-left: 80px; } h1, h2, h3 { color: #CA952C; font-weight: 300; } h1 { font-size: xx-large; } h2 { font-size: x-large; } h3 { font-size: large; } h4 { font-size: medium; } .label, .tech-label { color: #C0983A; font-weight: 500; display: inline-block; } .tech-label { width: 200px; vertical-align: top; } .tech-value { float: right; display: block; width: 600px; } .main-title { text-align: center; padding-top: 20px; margin-top: 0; } .main { width: 75%; float: right; } .text { margin: 15px; font-size: small; } .intro { margin-bottom: 60px; } .nav { list-style-type: none; margin: 0; padding: 0; width: 25%; background-color: #f1f1f1; height: 50%; /* Half height */ position: fixed; /* Make it stick, even on scroll */ overflow: auto; /* Enable scrolling if the sidenav has too much content */ } .nav-tree { list-style-type: none; margin: 0; padding: 0; width: 25%; top: 50%; background-color: #f1f1f1; height: 50%; /* Half height */ position: fixed; /* Make it stick, even on scroll */ overflow: auto; /* Enable scrolling if the sidenav has too much content */ } dt { font-weight: bold; margin-top: 5px;} .nav li a { display: block; color: #000; padding: 8px 16px; text-decoration: none; font-size: x-small; } .nav-tree li a { display: inline; color: #000; padding: 3px 0px; text-decoration: none; font-size: x-small; white-space: nowrap; } #tree-view-buttons a { display: block; color: #000; padding: 3px 0px; text-decoration: none; font-size: x-small; } .nav li a::after { content: ""; } .nav li a.active { background-color: #4CAF50; color: white; } .nav li a:hover:not(.active) { background-color: #555; color: white; } .nested { list-style-type: none; } .top-scroll { display: block; border-radius: 3px; border: 1px solid #ccc; padding: 10px; color: #ccc; position: fixed; margin-left: 96%; margin-top: 64%; } .equivalents-label { display: inline-block; width: 135px; } .dropbtn-icon { float: right; } .dropdown-content { display: none; } .dropdown-content-visible { margin-left: 15px; display: block !important; } .icon-active { transform: rotate(180deg); } .nav-title { padding: 10px; } .dropbtn { cursor: pointer; } .container { display: flex; flex-wrap: wrap; } img { display: block; margin-left: auto; margin-right: auto; } .info, .technical + .technical { border-top: 1px solid #eee; padding-top: 19px; margin-top: 19px; } .pattern { padding-bottom: 40px; padding-top: 20px; border-bottom: 1px solid #333; } .schematron-container { margin-left: 20px; } .info-table { margin-top: 10px; } .info-table, .info-table tr, .info-table td { border: 1px solid #333; border-collapse: collapse; } .info-table td { padding: 10px; } .further-reading-link, .recommentation, .recommendation-intro { display: block; } .recommendation + .recommendation { border-top: 1px solid #eee; padding-top: 19px; margin-top: 19px; } .header {  margin-left: 40px; margin-right: 40px; padding-bottom: 40px; border-bottom: 1px solid #333; } .header-heading { font-weight: bold; margin-top: 10px; } .header-indent { margin-left: 2%; } .indent { margin-left: +10px; } .note { background-color: lightgray; } .centred { text-align: center; } .change-log { margin-top: 20px; margin-left: +20px;  }</style></head>		
	</xsl:variable>
	<xsl:template match="/">
		<html>
			<xsl:copy-of select="$header"/>
			<body>
				<div class="nav">
					<ul class="nav">
						<li class="nav-title">Ordre Alphabétique</li>
						<!--li class="dropdown"><a onclick="document.getElementById('complexType-nav').classList.toggle('dropdown-content-visible'); document.getElementById('dropbtn-complexType').classList.toggle('icon-active');" class="dropbtn complexType-btn">complexTypes<span id="dropbtn-complexType" class="dropbtn-icon">▼</span></a>
							<div id="complexType-nav" class="dropdown-content"></div></li-->
						<li class="dropdown"><a onclick="document.getElementById('element-nav').classList.toggle('dropdown-content-visible'); document.getElementById('dropbtn-element').classList.toggle('icon-active');" class="dropbtn element-btn">units of information<span id="dropbtn-element" class="dropbtn-icon">▼</span></a>
							<div id="element-nav" class="dropdown-content"><xsl:apply-templates select="//tei:div[@type='ap_unit'][.//tei:div[@type='ap_structure']/*]" mode="id-link"><xsl:sort select="translate(@xml:id, $uc, $lc)"/></xsl:apply-templates></div></li>
						<li class="dropdown"><a onclick="document.getElementById('attribute-nav').classList.toggle('dropdown-content-visible'); document.getElementById('dropbtn-attribute').classList.toggle('icon-active');" class="dropbtn attribute-btn">attributes<span id="dropbtn-attribute" class="dropbtn-icon">▼</span></a>
							<div id="attribute-nav" class="dropdown-content"><xsl:apply-templates select="//tei:div[@type='ap_unit'][not(.//tei:div[@type='ap_structure'])]" mode="id-link"><xsl:sort select="@xml:id"/></xsl:apply-templates></div></li>
					</ul>
					<ul class="nav-tree">
						<li class="nav-title">Ordre du document</li>  
						<style> /* Remove default bullets */ #lido-tree-view { list-style-type: none; } /* Remove margins and padding from the parent ul */ #lido-tree-view { margin: 0; padding: 0; } #lido-tree-view ul{ margin-right: 10px; margin-bottom: 5px; margin-top: 5px; } #lido-tree-view li{ margin-left: 5px; margin-bottom: 0px; } #lido-tree-view span{ margin-left: 5px; } /* Style the caret/arrow */ .caret { cursor: pointer; user-select: none; /* Prevent text selection */ } /* Create the caret/arrow with a unicode, and style it */ .caret::before { content: "\25B6"; color: black; display: inline-block; margin-right: 10px; } /* Rotate the caret/arrow icon when clicked on (using JavaScript) */ .caret-down::before { transform: rotate(90deg); } /* Hide the nested list */ .nested { display: none; } /* Show the nested list when the user clicks on the caret/arrow (with JavaScript) */ .active { display: block; } /* Class for elements which cannot be expanded */ #lido-tree-view .ground { margin-left: 50px; } #tree-view-buttons { margin-bottom: 5px; } .tree-view-button { margin-right: 10px; } </style> 
						<div id="lido-tree-view-container" style=""> <!--div id="tree-view-buttons"> <a onclick="expandAllTreeElements();return false;" href="" class="tree-view-button">Expand all</a> <a onclick="collapseAllTreeElements();return false;" href="" class="tree-view-button">Collapse all</a> </div--> 
							<ul id="lido-tree-view"><xsl:apply-templates select=".//tei:div[@type='ap_unit'][not(tei:div[@type='ap_export']/tei:div[@type='ap_context'])]" mode="tree-view"/></ul>
						</div>
					</ul>
				</div>
				<script> var toggler = document.getElementsByClassName("caret"); var i; for (i = 0; i != toggler.length; i++) { toggler[i].addEventListener("click", function() { this.parentElement.querySelector(".nested").classList.toggle("active"); this.classList.toggle("caret-down"); }); }; function expandAllTreeElements() { var elementListExpanded = document.getElementById("lido-tree-view-wrapper").querySelectorAll("ul.nested:not(.active)"); elementListExpanded.forEach(changeAllTreeElements); }; function collapseAllTreeElements() { var elementListExpanded = document.getElementById("lido-tree-view-wrapper").querySelectorAll("ul .active"); elementListExpanded.forEach(changeAllTreeElements); }; function changeAllTreeElements(item){ item.classList.toggle("active"); item.previousElementSibling.classList.toggle("caret-down"); }; </script>
				<div class="main">
					<div class="header">
						<img src="EODEM 75dpi color transparent background.png"/>
						<h1 class="main-title"><xsl:value-of select="profile:lidoProfile/profile:schemaMeta/profile:title"/></h1>
						<img src="https://cidoc.mini.icom.museum/wp-content/uploads/sites/6/2020/04/LIDO_logo_main_336x214_trans_dither-w-300x191.png"/>
					</div>
					<!--xsl:apply-templates select="//tei:teiHeader/tei:fileDesc"/>
					<xsl:apply-templates select="//tei:teiHeader/tei:revisionDesc"/>
					<xsl:apply-templates select="//tei:front"/-->
					<div class="header">
						<xsl:apply-templates select="profile:lidoProfile/profile:schemaMeta" mode="front-matter"/> <!-- file metadata -->
					</div>
					<div class="header">
						<xsl:apply-templates select="profile:lidoProfile/profile:schemaMeta/profile:revision"/> <!-- revision history-->
					</div>
					<div class="header">
						<xsl:apply-templates select="profile:lidoProfile/profile:schemaDoc/tei:TEI/tei:text/tei:body/tei:div[@type='guideline_introduction']"/> <!-- front matter -->
					</div>
					<div class="elements">
						<h1>Elements</h1>
						<xsl:apply-templates select="//tei:div[@type='ap_unit'][.//tei:div[@type='ap_structure']/*]" mode="listing"><xsl:with-param name="elts" select="true()"/><!--xsl:sort select="@xml:id"/--></xsl:apply-templates>
					</div>
					<div class="attributes">
						<h1>Attributs</h1>
						<xsl:apply-templates select="//tei:div[@type='ap_unit'][not(.//tei:div[@type='ap_structure'])]" mode="listing"><!--xsl:sort select="@xml:id"/--></xsl:apply-templates>
					</div>
				</div>
			</body>
		</html>
	</xsl:template>
	
	<xsl:template match="*" mode="id-link">
		<xsl:variable name="heading">
			<xsl:choose>
				<xsl:when test="string(./tei:head)">
					<xsl:value-of select="./tei:head"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="@xml:id"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:if test="string(@xml:id)">
			<a href="{concat('#', @xml:id)}"><xsl:value-of select="$heading"/></a>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="*" mode="listing">
		<xsl:param name="elts" select="false()"/>
		<xsl:variable name="heading">
			<xsl:choose>
				<xsl:when test="$elts">&lt;<xsl:value-of select="@xml:id"/>&gt;</xsl:when>
				<xsl:otherwise><xsl:value-of select="@xml:id"/></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="class">
			<xsl:choose>
				<xsl:when test="$elts">element</xsl:when>
				<xsl:otherwise>attribut</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<div class="{$class}" id="{@xml:id}" name="{@xml:id}"><!--h2><xsl:value-of select="$heading"/></h2-->
			<xsl:apply-templates select="tei:head"/>
			<xsl:apply-templates select="tei:div[@type='ap_definition']" mode="sublist"/>
			<!--xsl:apply-templates select="@xml:id" mode="unit-id"/--> <!-- The ID is now declared (and listed) in its own right within tei:div type="ap_unit_ID" -->
			<!--xsl:apply-templates select="tei:head" mode="sublist"/-->
			<xsl:apply-templates select="tei:div[not(@type='ap_definition')]" mode="sublist"/>
		</div>
	</xsl:template>
	
	<xsl:template match="profile:schemaMeta" mode="front-matter">
		<xsl:apply-templates select="profile:title"/>
		<xsl:apply-templates select="profile:author"/>
		<!--xsl:apply-templates select="profile:revision/profile:change[1]" mode="version"/-->
		<xsl:apply-templates select="profile:date"/>
		<xsl:apply-templates select="profile:licence"/>
	</xsl:template>
	
	<xsl:template match="tei:head" priority="-1">
		<h2><xsl:apply-templates/></h2>
	</xsl:template>
	
	<xsl:template match="@xml:id" mode="unit-id">
		<div class="description">
			<h3>ID de l'unité</h3>
			<div class="description-content"><xsl:value-of select="."/></div>
		</div>		
	</xsl:template>
	
	<xsl:template match="tei:front/tei:head">
		<h2 style="text-align: center;"><xsl:apply-templates/></h2>
	</xsl:template>
	
	<xsl:template match="tei:head" mode="sublist">
		<div class="description">
			<h3>Label</h3>
			<div class="description-content">
				<xsl:value-of select="text()"/>
			</div>
		</div>
	</xsl:template>
	
	<xsl:template match="tei:div" priority="-1">
		<div style="margin-top: 20px; margin-left: 40px; margin-right: 20px;">
			<xsl:apply-templates/>
		</div>
	</xsl:template>
	
	<xsl:template match="tei:div[not(*)]" mode="sublist" priority="2"/>
	
	<xsl:template match="tei:div" mode="sublist" priority="-1">
		<xsl:if test="string(normalize-space(.)) or @type='ap_export'">
			<div class="description">
				<h3><xsl:call-template name="div-type-as-heading"/></h3>
				<div class="description-content">
					<xsl:apply-templates mode="subsublist"/>
				</div>
			</div>
		</xsl:if>
	</xsl:template>

	<xsl:template match="tei:div[not(*)]" mode="subsublist" priority="2"/>
	
	<xsl:template match="tei:div" mode="subsublist" priority="-1">
		<xsl:if test="string(.) or parent::tei:div/@type='ap_export'">
			<div class="description">
				<h3><xsl:call-template name="div-type-as-heading"/></h3>
				<div class="description-content">
					<xsl:apply-templates mode="subsublist"/>
				</div>
			</div>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="tei:div[@type='ap_definition']" mode="sublist">
		<div class="description">
			<h3>Description</h3>
			<div class="description-content">
				<xsl:apply-templates mode="subsublist"/>
			</div>
		</div>
	</xsl:template>
	
	<xsl:template match="tei:div" mode="subsublist">
		<xsl:if test="string(.) or string(tei:ref/@target)">
			<div class="tech-info container">
				<div class="tech-label"><xsl:call-template name="div-type-as-heading"/></div>
				<div class="tech-value">
					<xsl:apply-templates/>
				</div>
			</div>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="tei:div[@type='ap_structure']" mode="subsublist" priority="2">
		<!--xsl:if test="string(.)"-->
			<div class="tech-info container">
				<div class="tech-label"><xsl:call-template name="div-type-as-heading"/></div>
				<div class="tech-value">
					<xsl:apply-templates mode="structure"/>
				</div>
			</div>
		<!--/xsl:if-->
	</xsl:template>
	
	<xsl:template match="tei:div" mode="tree-view">
		<xsl:variable name="child-units" select="key('child-unit', concat('#', @xml:id))"/>
		<xsl:choose>
			<xsl:when test="count($child-units) &gt; 0">
				<li><span class="caret"><a href="#{@xml:id}"><xsl:value-of select="tei:head"/></a></span>
					<xsl:if test="count($child-units) &gt; 0">
						<ul class="nested">
							<xsl:apply-templates select="$child-units" mode="tree-view"/>
						</ul>
					</xsl:if>
				</li>
			</xsl:when>
			<xsl:otherwise>
				<li><span class="ground"><a href="#{@xml:id}"><xsl:value-of select="tei:head"/></a></span>
				</li>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="tei:list[@rend='definition']">
		<!--xsl:call-template name="display-definition-list"/-->
		<dl>
			<xsl:apply-templates mode="definition-list"/>
		</dl>		
	</xsl:template>

	<xsl:template match="tei:list[@rend='definition']" mode="subsublist">
		<!--xsl:call-template name="display-definition-list"/-->
		<dl>
			<xsl:apply-templates mode="definition-list"/>
		</dl>		
	</xsl:template>
	
	<xsl:template match="tei:list[@rend='ordered']">
		<div style="margin-left: +20px;">
			<ol>
				<xsl:apply-templates/>
			</ol>
		</div>
	</xsl:template>
	
	<xsl:template match="tei:list[@rend='ordered']" mode="subsublist">
		<div style="margin-left: +20px;">
			<ol>
				<xsl:apply-templates/>
			</ol>
		</div>
	</xsl:template>
	
	<xsl:template match="tei:list[not(@rend)]">
		<ul>
			<xsl:apply-templates/>
		</ul>
	</xsl:template>
	
	<xsl:template match="tei:list[not(@rend)]" mode="subsublist">
		<ul>
			<xsl:apply-templates/>
		</ul>
	</xsl:template>
	
	<xsl:template match="tei:label" mode="definition-list">
		<dt><xsl:apply-templates/></dt>
	</xsl:template>
	
	<xsl:template match="tei:item">
		<li>
			<xsl:apply-templates/>
		</li>
	</xsl:template>
	
	<xsl:template match="tei:item" mode="definition-list">
		<dd><xsl:apply-templates/></dd>
	</xsl:template>
	
	<xsl:template name="div-type-as-heading">
		<xsl:choose>
			<xsl:when test="@type='ap_divergence_from_lido'">Différence avec LIDO-v1.1</xsl:when>
			<xsl:when test="starts-with(@type, 'ap_')">
				<xsl:variable name="head" select="substring-after(@type, 'ap_')"/>
				<xsl:value-of select="translate(substring($head, 1, 1), $lc, $uc)"/>
				<xsl:value-of select="translate(substring($head, 2), '_', ' ')"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="translate(substring(@type, 1, 1), $lc, $uc)"/>
				<xsl:value-of select="translate(substring(@type, 2), '_', ' ')"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template name="display-definition-list">
		<xsl:apply-templates select="tei:label" mode="def-list"/>
	</xsl:template>
	
	<xsl:template match="tei:label" mode="def-list">
		<div>
			<b><xsl:value-of select="."/></b>
			<xsl:text> </xsl:text>
			<xsl:apply-templates select="following-sibling::*[1][self::tei:item]"/>
		</div>
	</xsl:template>
	
	<xsl:template match="tei:div/tei:p|tei:publicationStmt/tei:p|tei:sourceDesc/tei:p">
		<p><xsl:apply-templates/></p>
	</xsl:template>
	
	<xsl:template match="tei:p" mode="subsublist">
		<p><xsl:apply-templates/></p>
	</xsl:template>
	
	<xsl:template match="tei:ref[not(text())][starts-with(@target, '#')]" priority="3">
		<a href="{@target}"><xsl:value-of select="substring(@target, 2)"/></a>
	</xsl:template>
	
	<xsl:template match="tei:ref[not(text())]" priority="2">
		<a href="{@target}"><xsl:value-of select="@target"/></a>
	</xsl:template>
	
	<xsl:template match="tei:ref">
		<a href="{@target}"><xsl:value-of select="text()"/></a>
	</xsl:template>
	
	<xsl:template match="tei:figure">
		<div class="description">
			<xsl:apply-templates/>
		</div>
	</xsl:template>
	
	<xsl:template match="tei:graphic[@url]">
		<img src="{@url}"/>
	</xsl:template>
	
	<xsl:template match="tei:note">
		<span class="note"> (<xsl:apply-templates/>)</span>
	</xsl:template>
	
	<xsl:template match="tei:hi[@rend='bold']">
		<strong><xsl:apply-templates/></strong>
	</xsl:template>
	
	<xsl:template match="tei:emph">
		<em><xsl:apply-templates/></em>
	</xsl:template>
	 
	<xsl:template match="tei:gi">
		<code>&lt;<xsl:value-of select="."/>&gt;</code>
	</xsl:template>

	<xsl:template match="tei:att">
		<code>@<xsl:value-of select="."/></code>
	</xsl:template>

	<xsl:template match="tei:val">
		<code>"<xsl:value-of select="text()"/>"</code>
	</xsl:template>
	
	<!--file description-->
	
	<xsl:template match="tei:fileDesc">
		<div class="centred">
			<xsl:apply-templates/>
		</div>
	</xsl:template>
	
	<xsl:template match="tei:title|profile:title">
		<h1 class="centred"><xsl:apply-templates/></h1>
	</xsl:template>
	
	<xsl:template match="tei:author|profile:author">
		<h2 class="centred"><xsl:apply-templates/></h2>
	</xsl:template>
	
	<xsl:template match="tei:publicationStmt|tei:sourceDesc">
		<xsl:apply-templates/>		
	</xsl:template>
	
	<xsl:template match="tei:publicationStmt/tei:date|profile:date">
		<div class="centred"><b>Date de publication </b><xsl:value-of select="."/></div>
	</xsl:template>
	
	<xsl:template match="profile:licence">
		<div class="centred"><b>Licence </b><a href="{@target}"><xsl:value-of select="."/></a></div>
	</xsl:template>
	
	<!--revision description-->
	
	<xsl:template match="tei:revisionDesc|profile:revision">
		<h2>Version history</h2>
		<xsl:apply-templates/>
	</xsl:template>
	
	<xsl:template match="tei:change|profile:change">
		<div class="indent">
			<h3><xsl:value-of select="concat(@n, ' ', @when)"/></h3>
			<div class="description">
				<dl>
					<xsl:apply-templates select="@resp" mode="dl"/>
					<xsl:apply-templates select="tei:note[@type='documentation_status']" mode="dl"/>
					<xsl:apply-templates select="tei:note[@type='documentation_summary']" mode="dl"/>
				</dl>
			</div>
			<div class="change-log">
				<xsl:apply-templates select="*[not(self::tei:note)]"/>
			</div>
		</div>
	</xsl:template>
	
	<xsl:template match="@resp" mode="dl">
		<dt><xsl:value-of select="'Responsible'"/></dt>
		<dd><xsl:value-of select="."/></dd>
	</xsl:template>
	
	<xsl:template match="tei:note" mode="dl">
		<xsl:variable name="heading" select="substring-after(@type, '_')"/>
		<dt><xsl:value-of select="concat(translate(substring($heading, 1, 1), $lc, $uc), substring($heading, 2))"/></dt>
		<dd><xsl:apply-templates/></dd>
	</xsl:template>
	
	<!--generic templates-->
	
	<xsl:template match="*" mode="structure">
		<div class="indent">&lt;<xsl:value-of select="name()"/><xsl:apply-templates select="@*" mode="structure"/>&gt;<xsl:apply-templates mode="structure"/></div>
	</xsl:template>
	
	<xsl:template match="@*" mode="structure">
		<xsl:choose>
			<xsl:when test="starts-with(., '#')">
				<xsl:value-of select="concat(' ', name(), '=', $quot)"/>
				<a href="{.}"><xsl:value-of select="substring(., 2)"/></a>
				<xsl:value-of select="$quot"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="concat(' ', name(), '=', $quot, ., $quot)"/>
			</xsl:otherwise>
		</xsl:choose>		
	</xsl:template>
	
	<xsl:template match="tei:ref" mode="structure">
		<div class="indent">
			<a href="{@target}"><xsl:value-of select="substring(@target, 2)"/></a>
		</div>
	</xsl:template>
	
	<xsl:template match="text()" mode="structure">
		<xsl:if test=". != '#'"><xsl:value-of select="."/></xsl:if>
	</xsl:template>
	
</xsl:stylesheet>