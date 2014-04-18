<style>

 footer, section{
	margin: 0;
	padding: 0;
	border: 0;
	font-size: 100%;
	font: inherit;
	vertical-align: baseline;
}

footer, section {
	display: block;
}

table {
	border-collapse: collapse;
	border-spacing: 0;
}

hr {
	
	border: 0;
	border-top: 1px solid #ccc;
	margin: 0 0 1.5em;
	padding: 0;
}



/**
 * Font normalization inspired by YUI Library's fonts.css: developer.yahoo.com/yui/
 */

body {
	font:13px/1.231 sans-serif;
	*font-size:small;
} /* Hack retained to preserve specificity */


/* PIE */
.page, .nav-container, footer -container {
	}

/* Always force a scrollbar in non-IE */
html {
	overflow-y: scroll;
}

a:hover, a:active {
	outline: none;
	
}

ul, ol {
	margin-left: 2em;
}

ol {
	list-style-type: decimal;
}

/* Remove margins for navigation lists */
nav ul, nav li {
	margin: 0;
	list-style:none;
	list-style-image: none;
}


strong, th {
	font-weight: bold;
}

td {
	vertical-align: top;
}



/* Footer ================================================================================ */
footer {
	border:1px solid #ddd;
	padding:10px;
}

footer p {
	text-align:right;
}

footer address {
	text-align:right;
}

footer ul {
}

footer ul li {
	display:inline;
}

footer-container {
	text-align:center;
}

/* ======================================================================================= */



.footer-before-container .widget-banner li { margin:0; }


/* `Widths
----------------------------------------------------------------------------------------------------*/


	

html, body, div, span, object, iframe, h1, h2, h3, h4, h5, h6, p, blockquote, pre, abbr, address, cite, code, del, dfn, em, img, ins, kbd, q, samp, small, strong, sub, sup, var, b, i, dl, dt, dd, ol, ul, li, fieldset, form, label, legend, table, caption, tbody, tfoot, thead, tr, th, td, article, aside, canvas, details, figcaption, figure, footer, header, hgroup, menu, nav, section, summary, time, mark, audio, video { margin:0; padding:0; border:0; outline:0; font-size:100%; vertical-align:baseline; background:transparent; }
article, aside, details, figcaption, figure, footer, header, hgroup, menu, nav, section { display:block; }
ul, ol { list-style:none; }

body { font-family: proxima-nova, "Helvetica Neue", Arial, Helvetica, Geneva, sans-serif; font-size: 13px; line-height: 18px; color: #4f4f4f; text-align: left; }
.col-main { width: 700px; padding: 0; border: none; }

/*  @group Header  */
.header-container, header { height: 120px; width: 940px; margin: 0 auto; }
header { height: 90px; width: 940px; }
.page { padding: 0; }
header a.logo { margin: 23px 0 0 0; }



/*  @group footer  */
.footer-container { width: 100%; background: #a0a0a0; padding: 18px 0 20px 0; }
footer { margin: 0 auto; width: 940px; color: #fff; font-size: 14px; }
footer div { width: 100%; clear: both; }
footer div section { float: left; width: 205px; }
footer div section:nth-child(2) { width: 250px; }
footer div section:nth-child(3) { width: 240px; }
footer div section:last-child { float: right; width: 211px; }
footer section h3 { text-transform: uppercase; font-weight: 400; letter-spacing: .3px; }
footer ul li { display: block; }
footer section li { color: #fff; line-height: 20px; }
footer section li a { color: #545454 !important; text-decoration: none; }
.copyright a { color: #fff !important; text-decoration: none; }
footer section li a:hover, .copyright a:hover { color: #fff !important; text-decoration: underline; }
.copyright { width: 940px; text-transform: uppercase; font-size: 12px; float: left; white-space: nowrap; display: inline-block; margin-top: -5px !important;} /*margin-top: 17px;*/
.copyright a, .copyright span { display: inline-block; float: left; }
.copyright span.sep { margin: 0 10px; }


/*.powered { width: 940px; text-transform: uppercase; font-size: 12px; margin-top: 17px; white-space: nowrap; display: inline-block; font-weight:bold; }
.powered a, { display: inline-block; float: left; }
.powered { color: #fff; line-height: 20px; }
.powered a { color: #fff !important; font-weight:bold; text-decoration: none; }
.powered a:hover, .copyright a:hover { color: #fff !important; font-weight:bold; text-decoration: underline; }
*/


/* @group FOOTER FIXES */
footer section h3, footer section ul li, footer section ul li a, footer section li a:hover, .form-subscribe label { font-size:13px; font-weight:600; }
footer seciont ul li a { font-weight: 600; }
.copyright span, .copyright, .copyright a, .copyright a:hover, .copyright a:active, .copyright a:visited { font-size:10px; font-weight:600; letter-spacing:1px; }
/* @end */


/* @group Footer */

footer section h3 { text-transform: uppercase; font-weight: 600; letter-spacing: 1px; margin-bottom: 1px; }
.footer-container { width: 100%; background: #a0a0a0; padding: 17px 0 15px 0; }
/*  REMOVED THIS TO FIX STYLING THAT DID NOT MATCH REST OF SITE  */

/*textarea, select, select:active, select:focus, input[type="date"], input[type="datetime"], input[type="datetime-local"], input[type="email"], input[type="month"], input[type="number"], input[type="password"], input[type="search"], input[type="tel"], input[type="text"], input[type="time"], input[type="url"], input[type="week"], input.qty, input.input-text {
	box-shadow: inset 0 1px 1px rgba(133, 133, 133, 0.24);
	-moz-box-shadow: inset 0 1px 1px rgba(133, 133, 133, 0.24);
	-webkit-box-shadow: inset 0 1px 1px rgba(133, 133, 133, 0.24);
	border: none;
}*/

footer div section:last-child { float: right; width: 211px; margin-top: 4px; }
.form-subscribe button { border: none; border-radius: 0; -moz-box-shadow: none; -webkit-box-shadow: none; box-shadow: none; width: 52px; height: 23px;  *height: 23px;
color: #fff; background: #6b6e6e; /* Old browsers */ background: -moz-linear-gradient(top, #6b6e6e 0%, #5b5e5e 100%); /* FF3.6+ */ background: -webkit-gradient(linear, left top, left bottom, color-stop(0%, #6b6e6e), color-stop(100%, #5b5e5e)); /* Chrome,Safari4+ */ background: -webkit-linear-gradient(top, #6b6e6e 0%, #5b5e5e 100%); /* Chrome10+,Safari5.1+ */ background: -o-linear-gradient(top, #6b6e6e 0%, #5b5e5e 100%); /* Opera11.10+ */ background: -ms-linear-gradient(top, #6b6e6e 0%, #5b5e5e 100%); /* IE10+ */  filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#6b6e6e', endColorstr='#5b5e5e', GradientType=0 ); /* IE6-9 */
background: linear-gradient(top, #6b6e6e 0%, #5b5e5e 100%); /* W3C */ float:right !important; font-weight: 400; line-height: 10px;  *line-height: 12px;
text-shadow: none; text-transform: uppercase; text-align: center; padding: 0; margin: 0 10px 0 0; }
.dealeraccess { float: right; margin-top: 34px; }
.form-subscribe button { margin-top: 1px; }
/* @end */



.copyright span, .copyright, .copyright a, .copyright a:hover, .copyright a:active, .copyright a:visited { font-size:11px; font-weight:600; letter-spacing:1px; }

</style>
<div class="footer-container noprint">
<footer>
<style>
.socialicons { float: right; width: auto; text-align:left; }
</style>


<div>
<section class="socialicons">
<ul > 
<li style="font-size:16px; padding-bottom:30px; line-height:25px; float:right;"><table>
  <tr>
    <th scope="col" style="font-size:16px; line-height:25px; font-weight:bold;">Social &nbsp;</th>
    <th scope="col"> <a href="http://www.facebook.com/AmericanStandardPlumbing" target="_blank"><img src="../../Library/Styles/facebook.png" /></a>&nbsp;</th>
    <th scope="col">&nbsp;<a target="_blank" href="https://twitter.com/intent/follow?original_referer=http%3A%2F%2Fwww.americanstandard-us.com%2F&region=follow_link&screen_name=AmercanStandard&source=followbutton&variant=2.0"><img src="../../Library/Styles/twitter.png" /></a>&nbsp;</th>
    <th scope="col">&nbsp;<a target="_blank" href="http://www.youtube.com/user/AmericanStandard01" /><img src="../../Library/Styles/youtube.png" /></a></th>
  </tr>
</table>

</li>
<li>
<img src="../../Library/Styles/bsb_version_revised_0004_Vector-Smart-Object.png" height="62" width="265" styl="float:right !important;" />
</li>
</ul>
</section>
<section>
	<h3>About American Standard</h3>
	<ul>
		<li><a href="http://www.americanstandard-us.com/learn/american-standard-advantage/total-project-solutions/" target="_blank">Our Brands</a></li>
		<li><a href="http://www.americanstandard-us.com/pressroom/" target="_blank">News and Press</a></li>
		<li><a href="http://www.americanstandard-us.com/for-the-pros/" target="_blank">Professional Resources</a></li>
		<li><a href="http://www.americanstandardpro.com/" target="_blank">American Standard ProSite</a></li>
	</ul>
</section>
<section>
	<h3>Assistance</h3>
	<ul>
		<li><a href="http://www.americanstandard-us.com/contactUs.aspx" target="_blank">Contact Us</a></li> <!--http://www.americanstandard-us.com/contactUs.aspx-->
		<!--<li><a href="shipping.html" target="_blank">Shipping &amp; Delivery</a></li>
		<li><a href="returns.html" target="_blank">Returns &amp; Exchanges</a></li>
		<li><a href="faq.html" target="_blank">FAQs</a></li> commented as George Sam asked -->
	</ul>
</section>
<section>
	
</section>
</div>
<div class="copyright">
	<span>&copy; 2012 American Standard</span>
		<span class="sep">|</span>
		<!--<a href="http://www.americanstandard.com/terms-conditions/" target="_blank">Terms &amp; Conditions</a>
		<span class="sep">|</span>-->
	<a href="http://www.americanstandard-us.com/legal.aspx" target="_blank">Privacy Policy</a>
</div>
<div>

<table width="80%" bgcolor="#a0a0a0" style="margin-left:100px;">
  <tr>
    <th scope="col"><img src="../../Library/Styles/clientelefooter.png" alt="clientele" /></th>
    
  </tr>
  </table>
  <!--<tr style="text-align:center;"><th>Powered by <a href="http://www.answerthink.com/solutions/suite.jsp" style="color:#FFF !important;" target="_blank">Answerthink</a></th></tr>
</table>
<table style="width:100%;">
<tr><th style="text-align:center; color:#FFF !important;">Powered by <a href="http://www.answerthink.com/solutions/suite.jsp" style="color:#FFF !important;" target="_blank">Answerthink</a></th></tr>
</table>-->
<table style="width:100%;">
<tr><th style="text-align:center; color:#FFF !important;">Powered by <a href="http://www.answerthink.com/solutions/suite.jsp" style="color:#FFF !important;" target="_blank">Answerthink</a></th></tr>
</table>
</div>

</footer>
