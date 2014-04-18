<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"/>
<%
		
	
	
	String userMail		= request.getParameter("to_Email");
	String firstName	= request.getParameter("firstName");
	if(firstName==null || "".equals(firstName) || "null".equals(firstName))firstName="";
	String lastName		= request.getParameter("lastName");	 
	if(lastName==null || "".equals(lastName) || "null".equals(lastName))lastName="";
	String email		= request.getParameter("email");	 
	if(email==null || "".equals(email) || "null".equals(email))email="";
	String phNo		= request.getParameter("phNo");	 
	if(phNo==null || "".equals(phNo) || "null".equals(phNo))phNo="";
	String compName		= request.getParameter("compName");	
	if(compName==null || "".equals(compName) || "null".equals(compName))compName="";
	String compAddr		= request.getParameter("compAddr");	 
	if(compAddr==null || "".equals(compAddr) || "null".equals(compAddr))compAddr="";
	String soldTo		= request.getParameter("soldTo");
	if(soldTo==null || "".equals(soldTo) || "null".equals(soldTo))soldTo="";
	String capImage		= request.getParameter("capImage");	 
	//String details	= request.getParameter("details");
	String sessionCap	= (String)session.getAttribute("key");
	//out.println("Session:::::::::::::::::"+Session);

	
	String messageSub	= "User Registartion.";
	String messageText	= "Dear Team,<Br><Br>Please take action on the below registration.<Br><Br>";
	messageText+= "<Html><Body><Table width = '70%' align=center border=1 borderColorDark='#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0'><Tr><Th style='background-color: #015488;color:#FFFFFF;font-family:arial,sans-serif;font-size:12px' align='right' width='25%'>User Name</Th><Td  style='color:#330000;font-family:arial,sans-serif;font-size:12px'>"+firstName+" "+lastName+"</Td></Tr><Tr><Th  style='background-color: #015488;color:#FFFFFF;font-family:arial,sans-serif;font-size:12px' align='right' width='25%'>Email</Th><Td  style='color:#330000;font-family:arial,sans-serif;font-size:12px'>"+email+"</Td></tr><Tr>	<Th  style='background-color: #015488;color: #FFFFFF;font-family: arial,sans-serif;font-size: 12px' align='right' width='25%'>Phone No.</Th><Td  style='color: #330000;font-family: arial,sans-serif;font-size: 12px'>"+phNo+"</Td></tr><tr><Th  style='background-color: #015488;color: #FFFFFF;font-family: arial,sans-serif;font-size: 12px' align='right'  width='25%'>Company Name</Th><Td  style='color: #330000;font-family: arial,sans-serif;font-size: 12px'>"+compName+"</Td></Tr><Tr><Th  style='background-color: #015488;color: #FFFFFF;font-family: arial,sans-serif;font-size: 12px' align='right' width='25%'>Company Adress </Th><Td  style='color: #330000;font-family: arial,sans-serif;font-size: 12px'>"+compAddr+"</Td></tr><tr><Th  style='background-color: #015488;color: #FFFFFF;font-family: arial,sans-serif;font-size: 12px' align='right' width='25%'>Sold To</Th><Td  style='color: #330000;font-family: arial,sans-serif;font-size: 12px'>"+soldTo+"</Td></Tr></Table><Br><Br></Body></Html>Regards,<Br>"+firstName+" "+lastName+".";
	
%>
	<%@ include file="ezSendPassMail.jsp"%>
	

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<!DOCTYPE html>
<HTML>
<HEAD>
<TITLE>American Standard - Can't access your account?</TITLE>
<LINK rel="shortcut icon" href="../AST_Login/favicon.ico">
<LINK rel="icon"type="image/png" href="../AST_Login/favicon.png">

<SCRIPT type="text/javascript">var contextPath = ""</SCRIPT>
<LINK rel="stylesheet" type="text/css" href="../AST_Login/batch.css"media="all">
<!--[if lt IE 9]>
<link type="text/css" rel="stylesheet" href="../AST_Login/batch.css?conditionalComment=lt+IE+9" media="all">
<![endif]--><!--[if IE 9]>
<LINK rel="stylesheet" type="text/css" href="../AST_Login/batch(1).css"
media="all"><![endif]--><!--[if lte IE 9]>
<LINK rel="stylesheet" type="text/css" href="../AST_Login/batch(2).css" media="all"><![endif]-->

<LINK rel="stylesheet" type="text/css" href="../AST_Login/jira.webresources_global-static.css" media="all">
<LINK rel="stylesheet" type="text/css" href="../AST_Login/jira.webresources_global-static(1).css" media="print">
<link type="text/css" rel="stylesheet" href="../AST_Login/global-static.css" media="all">
<LINK rel="stylesheet" type="text/css" href="../AST_Login/feedback.css" media="all">
<LINK rel="stylesheet" type="text/css" href="../AST_Login/resources.css" media="all">
<LINK rel="stylesheet" type="text/css" href="../AST_Login/quicksearch.css" media="all">
<LINK rel="stylesheet" type="text/css" href="../AST_Login/bonfire-active-session-headsup.css" media="all">

<SCRIPT type="text/javascript" src="../AST_Login/batch.js"></SCRIPT>
<SCRIPT type="text/javascript" src="../AST_Login/gh-globalkeyboardshortcuts.js"></SCRIPT>
<SCRIPT type="text/javascript" src="../AST_Login/feedback.js"></SCRIPT>
<SCRIPT type="text/javascript" src="../AST_Login/resources.js"></SCRIPT>
<SCRIPT type="text/javascript" src="../AST_Login/soy-deps.js"></SCRIPT>
<SCRIPT type="text/javascript" src="../AST_Login/admin-quicksearch.js"></SCRIPT> 
<SCRIPT type="text/javascript" src="../AST_Login/shortcuts.js"></SCRIPT>

<!--<META name="GENERATOR" content="MSHTML 9.00.8112.16440">-->
<style>
/* Rounded Corners start */
.roundedCorners {
-webkit-border-radius: 8px;
-moz-border-radius: 8px;
border-radius: 8px;
-webkit-box-shadow: #666 0px 2px 3px;
-moz-box-shadow: #666 0px 2px 3px;
box-shadow: #666 0px 2px 3px;
behavior: url(/PIE.htc);
}

.roundedCornersWS {
-webkit-border-radius: 8px;
-moz-border-radius: 8px;
border-radius: 8px;

behavior: url(/PIE.htc);
}

/* Rounded Corners end */
</style>

</HEAD>
<BODY id="jira" class="lp type-a">
<DIV id="header">
	<DIV id="header-top">
		<A id="logo" href="../../../ezLogin.jsp">
						<DIV style="width: 62px; height: 67px;"	alt="AMSTAN">
				<img class="logo" src="blackloginlogo.png" alt="AMSTD" height="67" width="200" style="margin-left:30px;">
				<!--<IMG title="" border="0" alt="Get help!" align="middle" src="../AST_Login/amstd_logo.gif" width="200px" height="50">-->
			</DIV>
		</A>
		
	</DIV>
</DIV>
<DIV id="main-content">
	<DIV class="active-area" style="width:100%;">
		<DIV class="content intform">
			<FORM id="forgot-login" class="aui roundedCorners" method="post" style="overflow-x:hidden !important;" >
				<DIV class="content-body">
					 <section id="content" class="roundedCorners" role="main">
					  <div class="content-container">
						<div class="content-body aui-panel">
							<div class="form-body">
								<header>
								    <h1>Registartion Success</h1>
								</header>
								<div class="aui-message success"><span class="aui-icon icon-success"></span>
									<p>Thank you for registering with American Standards</p>
									<p>On verification, your details will be updated with American Standards.</p>
									<p>
									    If you dont hear from us, please contact our <a href="http://www.americanstandard-us.com/contactUs.aspx" target="_blank">Customer Service </a>.
									</p>
								 </div>
							</div>
						</div>
					    </div>
					</section>
				</div>
			</form>
		</div>
	</div>	
</div>		

<!--<DIV id="studio-footer" class="footer">
	<DIV id="poweredby">
		<P>
			<A href="">Powered by Answerthink</A> |
			<A href="">Terms of Use</A> |
			<A href="">Answers</A>
		</P>
	</DIV>
</DIV>-->


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


	

html, div, span, object, iframe, h1, h2, h3, h4, h5, h6, p, blockquote, pre, abbr, address, cite, code, del, dfn, em, img, ins, kbd, q, samp, small, strong, sub, sup, var, b, i, dl, dt, dd, ol, ul, li, fieldset, form, label, legend, table, caption, tbody, tfoot, thead, tr, th, td, article, aside, canvas, details, figcaption, figure, footer, header, hgroup, menu, nav, section, summary, time, mark, audio, video { margin:0; padding:0; border:0; outline:0; font-size:100%; vertical-align:baseline; background:transparent; }
article, aside, details, figcaption, figure, footer, header, hgroup, menu, nav, section { display:block; }
ul, ol { list-style:none; }
blockquote, q { quotes:none; }
blockquote:before, blockquote:after, q:before, q:after { content:''; content:none; }
a { margin:0; padding:0; font-size:100%; vertical-align:baseline; background:transparent; text-decoration: none; color: #5d87a1; }
a:hover { color: #5d87a1; text-decoration: underline; }
a:visited { color: #5d87a1; }
ins { background-color:#ff9; color:#000; text-decoration:none; }
mark { background-color:#ff9; color:#000; font-style:italic; font-weight:bold; }
del { text-decoration: line-through; }
abbr[title], dfn[title] { border-bottom:1px dotted; cursor:help; }
table { border-collapse:collapse; border-spacing:0; }
input, select { vertical-align:middle; }
/*.main { border: none; width: 940px; margin: 0 auto; padding: 0; }*/
.page { width: 100%; background: #fff; }
.cms-index-index .page { overflow-x: hidden; }

body { font-family: proxima-nova, "Helvetica Neue", Arial, Helvetica, Geneva, sans-serif; font-size: 13px; line-height: 18px; color: #4f4f4f; text-align: left; }
.col-main { width: 700px; padding: 0; border: none; }
.catalog-category-view .col-main { padding: 0; }
.col-left { width: 220px; }
textarea, select, select:active, select:focus, input[type="date"], input[type="datetime"], input[type="datetime-local"], input[type="email"], input[type="month"], input[type="number"], input[type="password"], input[type="search"], input[type="tel"], input[type="text"], input[type="time"], input[type="url"], input[type="week"], input.qty, input.input-text { box-shadow: inset 0px 1px 1px #858585; -moz-box-shadow: inset 0px 1px 1px #858585; -webkit-box-shadow: inset 0px 1px 1px #858585; border: none; color: #4f4f4f; }
.fieldset { padding: 0; margin: 0 0 40px 0; border: 0; background: none; }
.fieldset .legend { background: none; border: none; margin: 0; padding: 0; width: 100%; }
.form-list .field { width: 420px; margin: 0 0 10px 0; }
.form-list label { font-weight: 600; color: #4f4f4f; font-size: 12px; float: left; margin: 0 10px 0 0; min-width: 110px; line-height: 23px; }
.form-list .input-box { float: left; clear: none; }
.form-list label.required em { color: #f14848; font-style: normal; position: relative; float: none; right: -2px; }
.buttons-set { margin: 20px 0 0 0 !important; }
a.button, a.button:active, a.button:hover { text-decoration: none; }
DTTT_button ui-button ui-state-default DTTT_button_csv {background: #676a6a !important ;}
button, button.button, p.back-link, .buttons-set .back-link, .pager ol li, .back-to-top .to-top, a.button, button.restock-addtocart { border: none; border-radius: 0; -moz-box-shadow: 0 0 0 #000; -webkit-box-shadow: 0 0 0 #000; box-shadow: 0 0 0 #000; height: 30px; color: #fff  background: #6b6e6e;  background: -moz-linear-gradient(top, #6b6e6e 0%, #5b5e5e 100%);  background: -webkit-gradient(linear, left top, left bottom, color-stop(0%, #6b6e6e), color-stop(100%, #5b5e5e)); background: -webkit-linear-gradient(top, #6b6e6e 0%, #5b5e5e 100%);  background: -o-linear-gradient(top, #6b6e6e 0%, #5b5e5e 100%); background: -ms-linear-gradient(top, #6b6e6e 0%, #5b5e5e 100%);  filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#6b6e6e', endColorstr='#5b5e5e', GradientType=0 );
background: linear-gradient(top, #6b6e6e 0%, #5b5e5e 100%); float:left; font-weight: 400; line-height: 30px; text-shadow: 0px 1px 1px #202020; -moz-text-shadow: 0px 1px 1px #202020; -webkit-text-shadow: 0px 1px 1px #202020; text-transform: uppercase; text-align: center; padding: 0 15px; font-family: proxima-nova, "Helvetica Neue", Arial, Helvetica, Geneva, sans-serif; }
button:hover, button.button:hover, button:active, button.button:active, button.button.button:active, p.back-link:hover, .buttons-set .back-link:hover, p.back-link:active, .buttons-set .back-link:active, .pager ol li:hover, .pager ol li:active, .back-to-top:hover .to-top, .back-to-top:active .to-top, a.button:hover, a.button:active { background: #5b5e5e;  background: -moz-linear-gradient(top, #5b5e5e 0%, #6b6e6e 100%);  background: -webkit-gradient(linear, left top, left bottom, color-stop(0%, #5b5e5e), color-stop(100%, #6b6e6e)); background: -webkit-linear-gradient(top, #5b5e5e 0%, #6b6e6e 100%); background: -o-linear-gradient(top, #5b5e5e 0%, #6b6e6e 100%); background: -ms-linear-gradient(top, #5b5e5e 0%, #6b6e6e 100%);  filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#5b5e5e', endColorstr='#6b6e6e', GradientType=0 ); background: linear-gradient(top, #5b5e5e 0%, #6b6e6e 100%); font-family: proxima-nova, "Helvetica Neue", Arial, Helvetica, Geneva, sans-serif; border: none !important; box-shadow: 0 0 0 #000; -moz-box-shadow: 0 0 0 #000; -webkit-box-shadow: 0 0 0 #000; }
 button:focus, button:active { -moz-box-shadow: 0 0 0 #000; -webkit-box-shadow: 0 0 0 #000; box-shadow: 0 0 0 #000; border: none; z-index: 1; font-family: proxima-nova, "Helvetica Neue", Arial, Helvetica, Geneva, sans-serif; }
p.back-link a { padding: 0; margin: 0; border: none; border-radius: none; background: transparent url('../images/btn-arrow2.png') no-repeat 0 0; -moz-box-shadow: 0 0 0 #000; -webkit-box-shadow: 0 0 0 #000; box-shadow: 0 0 0 #000; font-size: 13px; font-family: proxima-nova, "Helvetica Neue", Arial, Helvetica, Geneva, sans-serif; color: #fff; height: 100%; display: block; padding: 0 0 0 30px; }
.right-link { background: url('../images/btn-arrow.png') no-repeat right center; display: block; height: 30px; margin: 0 10px 0 13px; line-height: 30px; }
.left-link { background: url('../images/btn-arrow2.png') no-repeat left center; display: block; height: 30px; margin: 0 10px 0 13px; line-height: 30px; }
/* ====  ARROW BUTTONS RT ==== */
button.button.submit, .cart-table tfoot td button.button.btn-continue { height: 30px; color: #fff; background: #6b6e6e; background: -moz-linear-gradient(top, #6b6e6e 0%, #5b5e5e 100%); background: -webkit-gradient(linear, left top, left bottom, color-stop(0%, #6b6e6e), color-stop(100%, #5b5e5e)); background: -webkit-linear-gradient(top, #6b6e6e 0%, #5b5e5e 100%); background: -o-linear-gradient(top, #6b6e6e 0%, #5b5e5e 100%); background: -ms-linear-gradient(top, #6b6e6e 0%, #5b5e5e 100%); filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#6b6e6e', endColorstr='#5b5e5e', GradientType=0 ); background: linear-gradient(top, #6b6e6e 0%, #5b5e5e 100%); text-shadow: 0px 1px 0px #000; font-weight: 400; text-align: left; padding: 0; font-family: proxima-nova, "Helvetica Neue", Arial, Helvetica, Geneva, sans-serif; font-size: 12px; }
button.button.submit:active, button.button.submit:hover, .cart-table tfoot td button.button.btn-continue:active, .cart-table tfoot td button.button.btn-continue:hover { background: #5b5e5e; background: -moz-linear-gradient(top, #5b5e5e 0%, #6b6e6e 100%); background: -webkit-gradient(linear, left top, left bottom, color-stop(0%, #5b5e5e), color-stop(100%, #6b6e6e)); background: -webkit-linear-gradient(top, #5b5e5e 0%, #6b6e6e 100%); background: -o-linear-gradient(top, #5b5e5e 0%, #6b6e6e 100%); background: -ms-linear-gradient(top, #5b5e5e 0%, #6b6e6e 100%);  filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#6b6e6e', endColorstr='#6b6e6e', GradientType=0 ); background: linear-gradient(top, #5b5e5e 0%, #6b6e6e 100%); }
button.button.submit span, .cart-table tfoot td button.button.btn-continue span { display: block; height: 30px; }
button.button.submit span span, .cart-table tfoot td button.button.btn-continue span span { background: url('../images/btn-arrow.png') no-repeat right center; display: block; height: 30px; margin: 0 10px 0 13px; line-height: 30px; }
/* ====  ARROW BUTTONS RT END ==== */

/* ====  ARROW BUTTONS LFT ==== */
.cart-table tfoot td button.button.btn-continue { height: 30px; color: #fff; background: #6b6e6e;  background: -moz-linear-gradient(top, #6b6e6e 0%, #5b5e5e 100%);  background: -webkit-gradient(linear, left top, left bottom, color-stop(0%, #6b6e6e), color-stop(100%, #5b5e5e)); background: -webkit-linear-gradient(top, #6b6e6e 0%, #5b5e5e 100%);  background: -o-linear-gradient(top, #6b6e6e 0%, #5b5e5e 100%); background: -ms-linear-gradient(top, #6b6e6e 0%, #5b5e5e 100%);  filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#6b6e6e', endColorstr='#5b5e5e', GradientType=0 );
background: linear-gradient(top, #6b6e6e 0%, #5b5e5e 100%); text-shadow: 0px 1px 0px #000; font-weight: 400; text-align: left; padding: 0; font-family: proxima-nova, "Helvetica Neue", Arial, Helvetica, Geneva, sans-serif; font-size: 12px; }
.cart-table tfoot td button.button.btn-continue:active, .cart-table tfoot td button.button.btn-continue:hover { background: #5b5e5e;  background: -moz-linear-gradient(top, #5b5e5e 0%, #6b6e6e 100%);  background: -webkit-gradient(linear, left top, left bottom, color-stop(0%, #5b5e5e), color-stop(100%, #6b6e6e)); background: -webkit-linear-gradient(top, #5b5e5e 0%, #6b6e6e 100%);  background: -o-linear-gradient(top, #5b5e5e 0%, #6b6e6e 100%); background: -ms-linear-gradient(top, #5b5e5e 0%, #6b6e6e 100%);  filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#6b6e6e', endColorstr='#6b6e6e', GradientType=0 );
background: linear-gradient(top, #5b5e5e 0%, #6b6e6e 100%); }
.cart-table tfoot td button.button.btn-continue span { display: block; height: 30px; }
.cart-table tfoot td button.button.btn-continue span span { background: url('../images/btn-arrow2.png') no-repeat 11px center; display: block; height: 30px; margin: 0 13px 0 10px; line-height: 30px; }
/* ====  ARROW BUTTONS LFT END ==== */

/* ====  BLUE BUTTONS ==== */
button.btn-blue, .opc button.button, .opc a.button.btn-blue { height: 30px; color: #fff; background: #66CC33;  background: -moz-linear-gradient(top, #66cc33 0%, #66CC33 100%);  background: -webkit-gradient(linear, left top, left bottom, color-stop(0%, #66cc33), color-stop(100%, #66cc33)); background: -webkit-linear-gradient(top, #66cc33 0%, #66cc33 100%);  background: -o-linear-gradient(top, #66cc33 0%, #66cc33 100%); background: -ms-linear-gradient(top, #66cc33 0%, #66cc33 100%);  filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#66cc33', endColorstr='#66cc33', GradientType=0 );
background: linear-gradient(top, #7ba2b3 0%, #66CC33 100%); text-shadow: 0px 1px 0px #394b59; font-weight: 400; text-align: left; padding: 0; font-family: proxima-nova, "Helvetica Neue", Arial, Helvetica, Geneva, sans-serif; font-size: 12px; box-shadow: 0 1px 1px 0 #cacaca; -wekit-box-shadow: 0 1px 1px 0 #cacaca; -moz-box-shadow: 0 1px 1px 0 #cacaca; }
button.btn-blue:hover, button.button.btn-blue:active, .opc button.button:hover, .opc button.button:active { background: #7ba2b3;  background: -moz-linear-gradient(top, #66CC33 0%, #7ba2b3 100%);  background: -webkit-gradient(linear, left top, left bottom, color-stop(0%, #66CC33), color-stop(100%, #7ba2b3)); background: -webkit-linear-gradient(top, #66CC33 0%, #7ba2b3 100%);  background: -o-linear-gradient(top, #66CC33 0%, #7ba2b3 100%); background: -ms-linear-gradient(top, #66CC33 0%, #7ba2b3 100%);  filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#66CC33', endColorstr='#7ba2b3', GradientType=0 );
background: linear-gradient(top, #66CC33 0%, #7ba2b3 100%); -moz-box-shadow: 0 0 0 #000; -webkit-box-shadow: 0 0 0 #000; box-shadow: 0 1px 1px 0 #cacaca; -wekit-box-shadow: 0 1px 1px 0 #cacaca; -moz-box-shadow: 0 1px 1px 0 #cacaca; }
button.button.btn-blue span { display: block; height: 30px; }
button.button.btn-blue span span { display: block; height: 30px; margin: 0 10px 0 10px; line-height: 30px; }
/* ====  BLUE BUTTONS ==== */

/* ==== GRID ADD TO CART BUTTON ==== */
.products-grid .actions button.btn-cart.sm-addcart { border: none; border-radius: 0; box-shadow: 0 1px 1px 0 #cacaca; -wekit-box-shadow: 0 1px 1px 0 #cacaca; -moz-box-shadow: 0 1px 1px 0 #cacaca; color: #fff !important; background: url('../images/btn-sm-addtocart.png') no-repeat 0 0; float:left; width: 85px; height: 22px; text-indent: -9999px; filter: none; }
.products-grid .actions button.btn-cart.sm-addcart:hover, .products-grid .actions button.btn-cart.sm-addcart:active { background: url('../images/btn-sm-addtocart.png') no-repeat 0 -28px; }
/* ==== END GRID ADD TO CART BUTTON ==== */


/* ==== PROCEED TO CART BUTTON ==== */
button.btn-proceed-checkout, button.btn-checkout, #review-buttons-container.buttons-set button.btn-checkout { border: none; border-radius: 0; box-shadow: 0 1px 1px 0 #cacaca; -wekit-box-shadow: 0 1px 1px 0 #cacaca; -moz-box-shadow: 0 1px 1px 0 #cacaca; height: 30px; color: #fff !important; background: #ee891d;  background: -moz-linear-gradient(top, #ee891d 0%, #ee7a1d 100%);  background: -webkit-gradient(linear, left top, left bottom, color-stop(0%, #ee891d), color-stop(100%, #ee7a1d)); background: -webkit-linear-gradient(top, #ee891d 0%, #ee7a1d 100%);  background: -o-linear-gradient(top, #ee891d 0%, #ee7a1d 100%); background: -ms-linear-gradient(top, #ee891d 0%, #ee7a1d 100%);  filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#ee891d', endColorstr='#ee7a1d', GradientType=0 );
background: linear-gradient(top, #ee891d 0%, #ee7a1d 100%); float:left; font-weight: 400; line-height: 30px; text-shadow: 0px 1px 1px #bb5606; text-transform: uppercase; text-align: center; padding: 0 8px; font-family: proxima-nova, "Helvetica Neue", Arial, Helvetica, Geneva, sans-serif; letter-spacing: 1px; }
.checkout-cart-index button.btn-proceed-checkout:hover, .checkout-cart-index button.btn-proceed-checkout:active, button.btn-checkout:hover, button.btn-checkout:active, #review-buttons-container.buttons-set button.btn-checkout:active, #review-buttons-container.buttons-set button.btn-checkout:hover { border: none; border-radius: 0; box-shadow: 0 1px 1px 0 #cacaca; -wekit-box-shadow: 0 1px 1px 0 #cacaca; -moz-box-shadow: 0 1px 1px 0 #cacaca; background: #ee7a1d;  background: -moz-linear-gradient(top, #ee7a1d 0%, #ee891d 100%);  background: -webkit-gradient(linear, left top, left bottom, color-stop(0%, #ee7a1d), color-stop(100%, #ee891d)); background: -webkit-linear-gradient(top, #ee7a1d 0%, #ee891d 100%);  background: -o-linear-gradient(top, #ee7a1d 0%, #ee891d 100%); background: -ms-linear-gradient(top, #ee7a1d 0%, #ee891d 100%);  filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#ee7a1d', endColorstr='#ee891d', GradientType=0 );
background: linear-gradient(top, #ee7a1d 0%, #ee891d 100%); top: 0; font-family: proxima-nova, "Helvetica Neue", Arial, Helvetica, Geneva, sans-serif; }
/* ==== END PROCEED TO CART BUTTON ==== */

.dealeraccess { float: right; }
.dealeraccess, .info-box .dash-edit { width: 189px; height: 30px; color: #fff; background: #6b6e6e;  background: -moz-linear-gradient(top, #6b6e6e 0%, #5b5e5e 100%);  background: -webkit-gradient(linear, left top, left bottom, color-stop(0%, #6b6e6e), color-stop(100%, #5b5e5e)); background: -webkit-linear-gradient(top, #6b6e6e 0%, #5b5e5e 100%);  background: -o-linear-gradient(top, #6b6e6e 0%, #5b5e5e 100%); background: -ms-linear-gradient(top, #6b6e6e 0%, #5b5e5e 100%);  filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#6b6e6e', endColorstr='#5b5e5e', GradientType=0 );
background: linear-gradient(top, #6b6e6e 0%, #5b5e5e 100%); text-shadow: 0px 1px 0px #000; font-weight: 400; text-align: left; margin: 37px 11px 0 0; padding: 0; font-family: proxima-nova, "Helvetica Neue", Arial, Helvetica, Geneva, sans-serif; font-size: 12px; display: block; text-transform: uppercase; text-decoration: none; }
.dealeraccess:hover, .dealeraccess:active, .info-box .dash-edit:hover, .info-box .dash-edit:active { background: #5b5e5e;  background: -moz-linear-gradient(top, #5b5e5e 0%, #6b6e6e 100%);  background: -webkit-gradient(linear, left top, left bottom, color-stop(0%, #5b5e5e), color-stop(100%, #6b6e6e)); background: -webkit-linear-gradient(top, #5b5e5e 0%, #6b6e6e 100%);  background: -o-linear-gradient(top, #5b5e5e 0%, #6b6e6e 100%); background: -ms-linear-gradient(top, #5b5e5e 0%, #6b6e6e 100%);  filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#5b5e5e', endColorstr='#6b6e6e', GradientType=0 );
background: linear-gradient(top, #5b5e5e 0%, #6b6e6e 100%); }
.dealeraccess span, .info-box .dash-edit span { display: block; height: 30px; width: 189px; }
.dealeraccess span span, .info-box .dash-edit span span { background: url('../images/btn-arrow.png') no-repeat right center; display: block; height: 30px; width: 164px; margin: 0 10px 0 13px; line-height: 30px; }
.page-title { border: none; padding: 0; margin: 0; display: block; }
.page-title h1 { color: #202020; font-size: 40px; line-height: 40px; margin: 0 0 40px 0; text-transform: uppercase; font-weight: 300; display: block; }
.mycart h1 { color: #202020; font-size: 30px; line-height: 40px; padding-top:10px;margin: 0 0 0 0; text-transform: uppercase; font-weight: 300; display: block; }
h2, .fieldset h2.legend { font-weight: 600; font-size: 20px; color: #202020; text-transform: uppercase; margin: 0 0 14px 0; }
a.dealeraccess:hover { color:#fff; text-decoration:none; }
a.dealeraccess:visited { color:#fff !important; }
a.dealeraccess span span { font-weight:600; font-size:12px; line-height:30px; font-family: proxima-nova, "Helvetica Neue", Arial, Helvetica, Geneva, sans-serif; }
/* @end */

/*  @group Global Tabs  */
#tabs, #tabsRel { padding: 0; height: 30px; width: 940px; display: block; clear: both; }
#tabs li, #tabsRel li { display: block; margin: 0 0 0 1px; float: right; border: none; }
#tabs li a, #tabsRel li a { background: #6b6e6e;  background: -moz-linear-gradient(top, #6b6e6e 0%, #5b5e5e 100%);  background: -webkit-gradient(linear, left top, left bottom, color-stop(0%, #6b6e6e), color-stop(100%, #5b5e5e)); background: -webkit-linear-gradient(top, #6b6e6e 0%, #5b5e5e 100%);  background: -o-linear-gradient(top, #6b6e6e 0%, #5b5e5e 100%); background: -ms-linear-gradient(top, #6b6e6e 0%, #5b5e5e 100%);  filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#6b6e6e', endColorstr='#5b5e5e', GradientType=0 );
background: linear-gradient(top, #6b6e6e 0%, #5b5e5e 100%); float:left; border-right: 1px solid #ccf; border-bottom: none; text-decoration: none; color: #fff; font-weight: 600; height: 10px; line-height: 10px; text-shadow: 0px 1px 0px #000; text-transform: uppercase; text-align: center; border: none; padding: 10px 16px; }
#tabs li a:hover, #tabs li:hover a, #tabsRel li a:hover, #tabsRel li:hover a { background: #5b5e5e;  background: -moz-linear-gradient(top, #5b5e5e 0%, #6b6e6e 100%);  background: -webkit-gradient(linear, left top, left bottom, color-stop(0%, #5b5e5e), color-stop(100%, #6b6e6e)); background: -webkit-linear-gradient(top, #5b5e5e 0%, #6b6e6e 100%);  background: -o-linear-gradient(top, #5b5e5e 0%, #6b6e6e 100%); background: -ms-linear-gradient(top, #5b5e5e 0%, #6b6e6e 100%);  filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#5b5e5e', endColorstr='#6b6e6e', GradientType=0 );
background: linear-gradient(top, #5b5e5e 0%, #6b6e6e 100%); }
#tabs li a:hover span, #tabs li:hover a span, #tabsRel li a:hover span, #tabsRel li:hover a span { opacity: .9; filter:alpha(opacity=90); }
.cms-index-index #tabs li.active { border: 1px solid #cfcfcf; height: 29px; border-bottom: none; position: relative; z-index: 9; margin: 0 1px 0 2px; }
#tabs li.active, #tabsRel li.active { border: none; height: 29px; border-bottom: none; position: relative; z-index: 99; }
#tabs li.active a, #tabsRel li.active a { background: #fff; color: #000; text-shadow: none; border: none; filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#ffffff', endColorstr='#ffffff', GradientType=0 ); }
.content { float: left; clear: both; padding: 10px 20px 20px; width: 400px; }
/*  @end  */

/*  @group Header  */
.header-container, header { height: 120px; width: 940px; margin: 0 auto; }
header { height: 30px; width: 940px; }
.page { padding: 0; }
header a.logo { margin: 23px 0 0 0; }

.quick-access { float: right; position: relative; height: 30px; display: block; z-index: 999; }
.quick-access ul.links.loggedout { height: 30px; background: #6b6e6e; padding: 0; display: inline-block; }
.quick-access ul.links.loggedin { height: 30px; background: #6b6e6e; padding: 0; display: inline-block; }
.quick-access ul.links>li { padding: 0; display: inline-block; height: 30px; background: url('../images/util-sep.png') no-repeat left center; float: left; }
.quick-access ul.links li.first, .quick-access ul.links li:hover+li { background: none; }
.quick-access ul.links li:hover, .quick-access ul.links li.first:hover { background: #000; }
.quick-access ul.links li.last:hover { background: none; }
.quick-access ul.links>li>a { color: #fff; text-decoration: none; font-size: 10px; padding:0 11px 0 12px; text-transform: uppercase; line-height: 28px; height: 30px; display: block; }
.quick-access ul.links li.first a { color: #fff; text-decoration: none; font-size: 10px; text-transform: uppercase; background: none; line-height: 28px; height: 30px; display: block; }
li.my-cart>a { background: url("../images/icon-cart.png") no-repeat scroll 15px 9px transparent; margin: 0; padding: 0 15px !important; text-indent: 20px; }
/*li.my-alerts>a {background: url("../images/alerts.jpg") no-repeat scroll 15px 9px transparent; margin: 0; padding: 0 15px !important; text-indent: 20px; }*/

.quick-access ul.links>.last { float: right; height: 25px; padding: 4px 0 0 0; background: none; min-width:80px; }
.quick-access ul.links>.last>a { background: #ee881d; box-shadow: 0px 1px 1px #666666; -moz-box-shadow: 0px 1px 1px #666666; -webkit-box-shadow: 0px 1px 1px #666666; width: 69px; height: 18px; display: block; margin: 0 10px 0 8px; text-align: center; padding: 0 2px 0 3px; line-height: 18px; }
#wishlist-drop, #cart-drop { width: 330px; height: 340px; padding: 15px; background: #000; position: absolute; top: 30px; z-index: 999; display: none; }
header .form-search { margin: 50px 0 0 0; }
.form-search input { height: 25px; width: 160px; color: #a0a0a0; float: right; -moz-box-shadow: 0 0 0 #000; -webkit-box-shadow: 0 0 0 #000; box-shadow: 0 0 0 #000; background: url('../images/search-bg.png') no-repeat 0 0 #fff; }
.form-search button, .form-search button:hover, .form-search button:active { background: url('../images/btn-search.png') no-repeat 0 0 #fff !important; filter: none; width: 26px; height: 25px; float: right; padding: 0; -moz-box-shadow: 0 0 0 #000; -webkit-box-shadow: 0 0 0 #000; box-shadow: 0 0 0 #000;  *z-index: -10; position: relative; }
/*  ==== MAIN NAV ====  */
.nav-container { width: 940px; height: 30px; margin: 0 0 0 -470px; top: 90px; left: 50%; z-index: 99; }
#nav { padding: 0; border: none; z-index: 99; }
#nav li.parent>a { color: #666666; font-size: 12px; font-weight: 400; height: 30px; line-height: 30px; margin: 0 12px; padding: 0; text-transform: uppercase; }
#nav li.parent { background: url('../images/nav-sep.jpg') no-repeat right center; }
#nav li.level0.active>a { background: url('../images/nav-hover.jpg') repeat-x 0 0; }
#nav>li.first>a { margin: 0 12px 0 0; padding: 0; }
#nav li.parent.nav-6 { margin: 0 0 0 12px; padding: 0; background: none; }
#nav li.parent.nav-7 { margin: 0; padding: 0; background: none; }
#nav li.parent.nav-7, #nav li.parent.nav-8 { float: right; position: relative; }
#nav li.parent.nav-6>a { margin: 0 12px 0 0; }
#nav li.parent.nav-7>a { margin: 0 0 0 12px; }
#nav li.parent.nav-7>a, #nav li.parent.nav-8>a { color: #000; }
#nav li.parent .nav-arrow { width: 16px; height: 8px; display: none; position: absolute; top: 23px; left: 29%; background: url('../images/nav-arrow.png') no-repeat 0 0; }
#nav li.nav-1 .nav-arrow { left: 26px; }
#nav li.nav-2 .nav-arrow { left: 26px; }
#nav li.nav-3 .nav-arrow { left: 26px; }
#nav li.nav-4 .nav-arrow { left: 26px; }
#nav li.nav-5 .nav-arrow { left: 26px; }
#nav li.nav-6 .nav-arrow { left: 26px; }
#nav li.nav-7 .nav-arrow { left: 26px; }
#nav li.nav-8 .nav-arrow { left: 26px; }
#nav li.parent:hover ul, #nav li.parent.over ul { display: block; left: 0; }
#nav li.parent:hover img, #nav li.parent.over img, #nav li.parent:hover .nav-arrow, #nav li.parent.over .nav-arrow { display: block; }
.level0 ul.level0 { background: #000 !important; color: #fff !important; border: none !important; width: 250px !important; padding: 10px 10px 15px 10px !important; position: absolute !important; top: 30px !important; }
.level0.nav-7:hover ul.level0, .level0.nav-8:hover ul.level0, .level0.nav-7.over ul.level0, .level0.nav-8.over ul.level0, .level0.nav-7.slvzr-hover ul.level0, .level0.nav-8:hover ul.level0.slvzr-hover { background: #000 !important; color: #fff !important; border: none !important; width: 250px !important; padding: 175px 10px 17px 10px !important; position: absolute !important; top: 30px !important; right: 0px !important; left: auto !important; }
.level0 ul.level0 li { border: none !important; width: 250px; }
.level0 ul.level0 li.level1 a { padding: 4px 0 0 0 !important;  *padding: 0 !important; }
.level0 img { position: absolute; top: 40px; left: 10px; z-index: 99; }
.level0.nav-7 img, .level0.nav-8 img { position: absolute; top: 40px; left: auto; right: 10px; z-index: 99; }
.level0 ul.level0 li a, .level0 ul.level0 li a span { font-weight: 400; font-size: 12px; color: #fff !important; text-transform: uppercase; letter-spacing: 1px; }
.level0 ul.level0 li a:hover span, .level0 ul.level0 li a:active span { color: #66CC33 !important; }
#nav li.parent img { display: none; }
#nav ul li.last, #nav ul li.last a { padding: 1px 0 0 0 !important; }

/*  ==== MAIN NAV END ====  */
/*  ==== NAV TYPE BUTTON ====  */
#.nav-container { width: 940px; height: 30px; margin: 0 0 0 -470px; top: 90px; left: 50%; z-index: 99; }
#navbutton { padding: 0; border: none; z-index: 99; }
#navbutton li.parent>a { color: #666666; font-size: 12px; font-weight: 400; height: 30px; line-height: 30px; margin: 0 12px; padding: 0; text-transform: uppercase; }
#navbutton li.parent { background: url('../images/nav-sep.jpg') no-repeat right center; }
#navbutton li.level0.active>a { background: url('../images/nav-hover.jpg') repeat-x 0 0; }
#navbutton>li.first>a { margin: 0 12px 0 0; padding: 0; }
#navbutton li.parent.nav-6 { margin: 0 0 0 12px; padding: 0; background: none; }
#navbutton li.parent.nav-7 { margin: 0; padding: 0; background: none; }
#navbutton li.parent.nav-7, #nav li.parent.nav-8 { float: right; position: relative; }
#navbutton li.parent.nav-6>a { margin: 0 12px 0 0; }
#navbutton li.parent.nav-7>a { margin: 0 0 0 12px; }
#navbutton li.parent.nav-7>a, #nav li.parent.nav-8>a { color: #000; }
#navbutton li.parent .nav-arrow { width: 16px; height: 8px; display: none; position: absolute; top: 23px; left: 29%; background: url('../images/nav-arrow.png') no-repeat 0 0; }
#navbutton li.nav-1 .nav-arrow { left: 26px; }
#navbutton li.nav-2 .nav-arrow { left: 26px; }
#navbutton li.nav-3 .nav-arrow { left: 26px; }
#navbutton li.nav-4 .nav-arrow { left: 26px; }
#navbutton li.nav-5 .nav-arrow { left: 26px; }
#navbutton li.nav-6 .nav-arrow { left: 26px; }
#navbutton li.nav-7 .nav-arrow { left: 26px; }
#navbutton li.nav-8 .nav-arrow { left: 26px; }
#navbutton li.parent:hover ul, #nav li.parent.over ul { display: block; left: 0; }
#navbutton li.parent:hover img, #nav li.parent.over img, #nav li.parent:hover .nav-arrow, #nav li.parent.over .nav-arrow { display: block; }
.level0 ul.level0 { background: #000 !important; color: #fff !important; border: none !important; width: 250px !important; padding: 10px 10px 15px 10px !important; position: absolute !important; top: 30px !important; }
.level0.nav-7:hover ul.level0, .level0.nav-8:hover ul.level0, .level0.nav-7.over ul.level0, .level0.nav-8.over ul.level0, .level0.nav-7.slvzr-hover ul.level0, .level0.nav-8:hover ul.level0.slvzr-hover { background: #000 !important; color: #fff !important; border: none !important; width: 250px !important; padding: 175px 10px 17px 10px !important; position: absolute !important; top: 30px !important; right: 0px !important; left: auto !important; }
.level0 ul.level0 li { border: none !important; width: 250px; }
.level0 ul.level0 li.level1 a { padding: 4px 0 0 0 !important;  *padding: 0 !important; }
.level0 img { position: absolute; top: 40px; left: 10px; z-index: 99; }
.level0.nav-7 img, .level0.nav-8 img { position: absolute; top: 40px; left: auto; right: 10px; z-index: 99; }
.level0 ul.level0 li a, .level0 ul.level0 li a span { font-weight: 400; font-size: 12px; color: #fff !important; text-transform: uppercase; letter-spacing: 1px; }
.level0 ul.level0 li a:hover span, .level0 ul.level0 li a:active span { color: #66CC33 !important; }
#navbutton li.parent img { display: none; }
#navbutton ul li.last, #nav ul li.last a { padding: 1px 0 0 0 !important; }

/*  ==== NAV TYPE BUTTON END ====  */

/*  @end  */

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
.copyright { width: 940px; text-transform: uppercase; font-size: 12px; float: left; white-space: nowrap; display: inline-block; } /*margin-top: 17px;*/
.copyright a, .copyright span { display: inline-block; float: left; }
.copyright span.sep { margin: 0 10px; }


/*.powered { width: 940px; text-transform: uppercase; font-size: 12px; margin-top: 17px; white-space: nowrap; display: inline-block; font-weight:bold; }
.powered a, { display: inline-block; float: left; }
.powered { color: #fff; line-height: 20px; }
.powered a { color: #fff !important; font-weight:bold; text-decoration: none; }
.powered a:hover, .copyright a:hover { color: #fff !important; font-weight:bold; text-decoration: underline; }
*/
.form-subscribe .input-text { width: 178px; height: 23px; margin: 0; border: none; float: left !important; color: #a0a0a0; }
#newsletter-validate-detail { display: inline-block; }
.form-subscribe { margin: 0 0 7px 0; }
.form-subscribe button { border: none; border-radius: 0; -moz-box-shadow: 0 0 0 #000; -webkit-box-shadow: 0 0 0 #000; box-shadow: 0 0 0 #000; width: 52px; height: 23px;  *height: 26px; color: #fff; background: #6b6e6e;  background: -moz-linear-gradient(top, #6b6e6e 0%, #5b5e5e 100%);  background: -webkit-gradient(linear, left top, left bottom, color-stop(0%, #6b6e6e), color-stop(100%, #5b5e5e)); background: -webkit-linear-gradient(top, #6b6e6e 0%, #5b5e5e 100%);  background: -o-linear-gradient(top, #6b6e6e 0%, #5b5e5e 100%); background: -ms-linear-gradient(top, #6b6e6e 0%, #5b5e5e 100%);  filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#6b6e6e', endColorstr='#5b5e5e', GradientType=0 ); background: linear-gradient(top, #6b6e6e 0%, #5b5e5e 100%); float:right !important; font-weight: 400; line-height: 10px;  *line-height: 12px; text-shadow: none; text-transform: uppercase; text-align: center; padding: 0; margin: 0 10px 0 0; }
.form-subscribe button span span { font-size: 10px; }
#advice-validate-email-newsletter { background: #00ff00; clear: both; padding: 10px 0 0 0; }
.addthis_toolbox { margin: 10px 0 0 0; }
footer .form-search { margin: 5px 0 0 0; }
footer .form-search button, footer .form-search button:hover, footer .form-search button:active { background: url("../images/btn-search.png") no-repeat scroll 0 0 #FFFFFF !important; -moz-box-shadow: 0 0 0 #000; -webkit-box-shadow: 0 0 0 #000; box-shadow: 0 0 0 #000; filter: none; float: right; height: 25px;  *height: 28px; padding: 0; width: 26px; z-index: 0; }
footer .form-search input {  *width: 157px; }
footer section li a.addthis_button_google_plusone:hover, footer section li a.addthis_button_facebook_like:hover { text-decoration: none; }
.form-subscribe.success { background: url("../images/icon-success-message.png") no-repeat 10px center #8DBD5A; border-radius: 5px 5px 5px 5px; color: #FFFFFF; line-height: 16px; margin: 10px 0; padding: 10px 10px 10px 40px; width: 190px; }
/*  @end  */

/*  @group homepage  */
.cms-index-index .main-container { width: 940px; margin: 0 auto; }
.feature-boxes { width: 940px; height: 265px; margin: 0 0 30px 0; }
.feature { min-width: 300px; height: 265px; margin: 0 20px 0 0; background: #333; float: left; position: relative; overflow: hidden; }
.feature:last-child, .feature.last { margin: 0 !important; }
.feature a, .feature a:hover { width: 100%; height: 100%; text-decoration: none; }
.over-bg { background: url('../images/black-trans.png') repeat 0 0; width: 100%; height: 156px; position: absolute; bottom: -100px; left: 0; }
.feature:hover .over-bg { background: #7ba2b3; }
.feature .over-button { display: none; background: url('../images/feature-arrow.png') no-repeat bottom right; position: absolute; bottom: 0; right: 0; width: 15px; height: 19px; }
.feature:hover .over-button { display: block; }
.over-text { color: #e9e9e9; padding: 10px 15px 0; font-size: 14px; line-height: 18px; font-weight: 600; text-transform: uppercase; letter-spacing: 1px; text-decoration: none; letter-spacing: 0\9; }
.scroll .over-text { padding-top: 14px; }
.scroll .over-text.scrolled { padding-top: 5px; }
.over-copy { color: #fff; width: 90%; padding: 0 15px 0 15px; font-size: 12px; line-height: 17px; font-weight: 600; text-decoration: none; letter-spacing: 0\9; }
.over-copy.hidden { display: none; }
.over-copy span { text-transform: uppercase; clear: both; margin: 5px 0 0 0; display: block; }
.feature:hover .over-text { color: #fff; }
.over-text.center { line-height: 30px; }
.homepagetabs { height: 263px; width: 940px; }
.homepagetabs .content { width: 940px; padding: 20px 0 62px 0; border: none; border-top: 1px solid #cfcfcf; position: relative; overflow: hidden; height: 152px; top: -1px; }
.ba-inner-product-tab-group { width: 890px; margin: 0 25px; float: left; height: 155px; }
.sliderbtn-lft { position: absolute; top: 80px; left: 0; height: 30px; width: 15px; background: url('../images/btn-tabslider.png') no-repeat 0 0; cursor: pointer; }
.sliderbtn-rt { position: absolute; top: 80px; right: 0; height: 30px; width: 15px; background: url('../images/btn-tabslider.png') no-repeat -20px 0; cursor: pointer; }
.ba-rb-tab-product-container-div { width: 140px; height: 155px; float: left; position: relative; }
.ba-rb-home-overlay-div { display: none; position: absolute; top: 0; left: 0; width: 140px; height: 155px; background: #7ba2b3 url('../images/feature-arrow.png') no-repeat bottom right; color: #fff; text-align: center; vertical-align: middle; }
.ba-rb-tab-product-container-div a, .ba-rb-tab-product-container-div:hover a { text-decoration: none; }
.ba-rb-tab-product-container-div:hover a .ba-rb-home-overlay-div { display: block; text-decoration: none; }
.ba-rb-tab-product-container-div:last-child { margin: 0; }
.ba-rb-tab-product-container-div h3 { font-size: 12px; font-weight: 600; line-height: 16px; text-transform: uppercase; width: 110px; margin-left: 15px; margin-right: 15px; }
.ba-rb-tab-product-container-div .box { display: table-cell; vertical-align: middle; height: 154px; width: 140px;  *padding: 60px 0 0 0; }
.ba-rb-tab-product-container-div p { font-size: 12px; font-weight: 400; line-height: 16px; text-transform: uppercase; width: 110px; margin-left: 15px; margin-right: 15px; }
/*  @end  */

/*  @group homepage carousel  */
.jcarousel-skin-rb .jcarousel-container { position: relative; width: 940px; height: 480px; margin: 0 auto; }
.jcarousel-skin-rb .jcarousel-direction-rtl { direction: rtl; }
.jcarousel-skin-rb .jcarousel-shadow { width:  2820px; height: 480px; }
.jcarousel-skin-rb .jcarousel-clip { overflow: hidden; width:  940px; height: 480px; border-left: 1px solid #fff; border-right: 1px solid #fff; }
.jcarousel-skin-rb .jcarousel-shadow .jcarousel-clip { width:  2820px; }
.jcarousel-skin-rb .jcarousel-item { width:  940px; height: 480px; position: relative; }
.jcarousel-skin-rb .jcarousel-item-placeholder { background: #fff; color: #000; }
.jcarousel-skin-rb .jcarousel-next { position: absolute; top: 202px; right: -5px; width: 37px; height: 68px; cursor: pointer; background: transparent url('../images/btn-slider.png') no-repeat -37px 0px; }
.jcarousel-skin-rb .jcarousel-next:active, .jcarousel-skin-rb .jcarousel-next:hover { background: transparent url('../images/btn-slider.png') no-repeat -37px -78px; }
.jcarousel-skin-rb .jcarousel-direction-rtl .jcarousel-next { left: 5px; right: auto; background-position: 0 0; }
.jcarousel-skin-rb .jcarousel-prev { position: absolute; top: 202px; left: 1px; width: 37px; height: 68px; cursor: pointer; background: transparent url('../images/btn-slider.png') no-repeat 0px 0px; }
.jcarousel-skin-rb .jcarousel-prev:active, .jcarousel-skin-rb .jcarousel-prev:hover { background: transparent url('../images/btn-slider.png') no-repeat 0px -78px; }
.jcarousel-skin-rb .jcarousel-direction-rtl .jcarousel-prev { left: auto; right: 5px; background-position: -30px 0; }
.jcarousel-next-disabled, .jcarousel-prev-disabled { opacity: .25; filter:alpha(opacity=25); }
.hero-overlay { background: url('../images/black-trans.png') repeat 0 0; width: 100%; position: absolute; left: 0; bottom: 0; min-height: 0; }
.hero-overlay span { line-height: 72px; color: #e9e9e9; font-family: "Crimson Text", Georgia, "Times New Roman", Times, serif; font-size: 34px; display: block; font-weight: 400; margin: 0 0 0 20px; letter-spacing: 1px; }
.jcarousel-shadow .jcarousel-item a { pointer-events: none; }
/*  @end  */

/* @group homepage tabs */
.homepagetabs .jcarousel-tabs-rb .jcarousel-container { position: relative; width: 960px; margin: 0 auto; }
.homepagetabs .jcarousel-tabs-rb .jcarousel-clip-horizontal { overflow: hidden; width:  900px; border-left: 1px solid #fff; border-right: 1px solid #fff; margin: 0 40px 0 39px; }
.homepagetabs .jcarousel-tabs-rb .jcarousel-item { width:  144px; }
.homepagetabs .jcarousel-tabs-rb .jcarousel-item-placeholder { background: #fff; color: #000; }
.homepagetabs .jcarousel-tabs-rb .jcarousel-next { position: absolute; top: 60px; right: 20px; cursor: pointer; height: 30px; width: 15px; background: url('../images/btn-tabslider.png') no-repeat -20px 0; }
.homepagetabs .jcarousel-tabs-rb .jcarousel-next:hover, .homepagetabs .jcarousel-tabs-rb .jcarousel-next:active { background: url('../images/btn-tabslider.png') no-repeat -20px -40px; }
.homepagetabs .jcarousel-tabs-rb .jcarousel-prev { position: absolute; top: 60px; left: 0px; cursor: pointer; height: 30px; width: 15px; background: url('../images/btn-tabslider.png') no-repeat 0px 0; }
.homepagetabs .jcarousel-tabs-rb .jcarousel-prev:hover, .homepagetabs .jcarousel-tabs-rb .jcarousel-prev:active { background: url('../images/btn-tabslider.png') no-repeat 0px -40px; }
ba-rb-tab-product-container-div a { display: block; }
ba-rb-tab-product-container-div:hover a .ba-rb-home-overlay-div { display: block; background: #7ba2b3; }
.carousel-featured { height: 480px; background: #ccc; margin: 0 0 40px 0; }
/* @end */

/*  @end  */

/*  @group category page  */
.catalog-category-view .main-container, .catalogsearch-result-index .main-container { background: #eeede7; padding: 7px 0 21px 0; }
.catalog-category-view .col-left, .catalogsearch-result-index .col-left { width: 220px; padding: 0; background: #fff; border: none; }
.category-image { margin: 0 0 5px 0; }
.ba-cms-left-block { padding: 11px 15px 15px 15px; background: #7ba2b3; color: #fff; margin: 0; }
.ba-cms-left-block h3 { font-size: 18px; text-transform: uppercase; font-weight: 600; letter-spacing: 0px; }
.ba-cms-left-block p { font-family: "Crimson Text", Georgia, "Times New Roman", Times, serif; font-size: 15px; line-height: 16px; padding: 0; }
.ba-cms-left-block a { display: inline-block; width: 150px; min-height: 5px; background: #538093 url('../images/layered-question.png') no-repeat right center; color: white; padding: 6px 28px 5px 10px; font-size: 12px; text-transform: uppercase; line-height: 14px; font-family: proxima-nova, "Helvetica Neue", Arial, Helvetica, Geneva, sans-serif; font-weight: 600; margin: 13px 0 0 0; }
.ba-cms-left-block a:hover { text-decoration: none; }
.ba-cms-left-block a span { line-height: 13px; }
/* LAYERED NAV */
.adj-nav-navigation { padding: 15px; }
.block-layered-nav { padding: 0 !important; }
.expln-text { font-size: 12px; color: #202020; font-weight: 600; margin: 7px 0 30px 15px;  *font-size: 11px; }
.adj-nav dl { list-style-type: none; }
#adj-nav-filter-cat li:first-child { display: none; }
div.narrow-by dd li { padding: 0 0 3px; }
div.narrow-by a { line-height: 20px !important; }
#adj-nav-filter-cat li span: #adj-nav-filter-cat li span:hover {  display: block;  height: 22px;  line-height: 18px;  color: #6C6F71; }
div.narrow-by a.adj-nav-attribute, a.adj-nav-price { padding-left: 5px !important; }
div.narrow-by #adj-nav-filter-cat li a { padding-left: 0; color: #5D87A1; }
div.narrow-by a.adj-nav-attribute-selected, a.adj-nav-price-selected, #adj-nav-filter-cat li a.adj-nav-attribute-selected {  font-weight: 400 !important; padding-left: 5px !important; }
.adj-clear-all { margin: 15px 0 0 0; padding: 7px 0 0 0 !important; background: url('../images/layered-border-bottom.png') repeat-x left top; }
.adj-nav-clearall, .adj-nav-clearall2 { background: url("../images/layered-clearall.png") no-repeat scroll 0 0 transparent; display: block; float: right; height: 9px; margin: 5px 15px 0 0; width: 72px; }
.top-contain { width: 220px; margin: 0 0 13px 0; }
.adj-clear-all-top { display: block; background: url('../images/layered-border-bottom.png') repeat-x left top; width: 100%; height: 23px; }
.adj-clear-all-top div { display: block; background: url('../images/layered-border-bottom.png') repeat-x left bottom; width: 100%; height: 25px; }
.adj-clear-all-top .adj-nav-clearall { display: block; background: url('../images/layered-clearall.png') no-repeat 0 0; width: 72px; height: 9px; line-height: 23px; float: right; margin: 8px 15px 0 0; }
a.adj-nav-price { }
#narrow-by-list { padding: 0 !important; }
#narrow-by-list dt { margin: 22px 15px 0px 15px !important; text-transform: uppercase; color: #5b5e5e; font-size: 13px; }
#narrow-by-list dt:first-of-type { margin: 0px 15px 0px 15px !important; }
#narrow-by-list dd { margin: 6px 15px 7px 15px !important; }
#narrow-by-list dt:first-child { margin: 0 0 7px 0; }
#narrow-by-list dd ol { max-height: 130px; overflow-y: auto; }
#narrow-by-list ol li { padding-bottom: 0; }
#narrow-by-list dd a { color: #6c6f71; }
#narrow-by-list dd a:hover { text-decoration: none; color: #66CC33; }
/* END LAYERED NAV */

.categoryTabs { height: 225px; width: 700px; margin: 0 0 20px 0; }
.categoryTabs #tabs { width: 700px; }
.categoryTabs .content { width: 700px; padding: 20px 0; background: #fff; border: none; position: relative; height: 156px; }
.categoryTabs #tabs li.active { border: none; }
.categoryTabs .jcarousel-tabs-rb .jcarousel-container { margin: 0 auto; width: 720px; }
.categoryTabs .jcarousel-tabs-rb .jcarousel-clip-horizontal { overflow: hidden; width:  640px; border-left: 1px solid #fff; border-right: 1px solid #fff; margin: 0 40px; }
.categoryTabs .jcarousel-tabs-rb .jcarousel-next { position: absolute; top: 65px; right: 20px; cursor: pointer; height: 30px; width: 15px; background: url('../images/btn-tabslider.png') no-repeat -20px 0; }
.categoryTabs .jcarousel-tabs-rb .jcarousel-next:hover, .homepagetabs .jcarousel-tabs-rb .jcarousel-next:active { background: url('../images/btn-tabslider.png') no-repeat -20px -40px; }
.categoryTabs .jcarousel-tabs-rb .jcarousel-prev { position: absolute; top: 65px; left: 0px; cursor: pointer; height: 30px; width: 15px; background: url('../images/btn-tabslider.png') no-repeat 0px 0; }
.categoryTabs .jcarousel-tabs-rb .jcarousel-prev:hover, .homepagetabs .jcarousel-tabs-rb .jcarousel-prev:active { background: url('../images/btn-tabslider.png') no-repeat 0px -40px; }


.categoryTabsFav { height: 225px; width: 915px; margin: 0 0 20px 0; }
.categoryTabsFav #tabs { width: 915px; }
.categoryTabsFav .content { width: 930px; padding: 20px 0; background: #fff; border: none; position: relative; height: 156px; }
.categoryTabsFav #tabs li.active { border: none; }
.categoryTabsFav .jcarousel-tabs-rb .jcarousel-container { margin: 0 auto; width: 920px; }
.categoryTabsFav .jcarousel-tabs-rb .jcarousel-clip-horizontal { overflow: hidden; width:  840px; border-left: 1px solid #fff; border-right: 1px solid #fff; margin: 0 40px; }
.categoryTabsFav .jcarousel-tabs-rb .jcarousel-next { position: absolute; top: 65px; right: 20px; cursor: pointer; height: 30px; width: 15px; background: url('../images/btn-tabslider.png') no-repeat -20px 0; }
.categoryTabsFav .jcarousel-tabs-rb .jcarousel-next:hover, .homepagetabs .jcarousel-tabs-rb .jcarousel-next:active { background: url('../images/btn-tabslider.png') no-repeat -20px -40px; }
.categoryTabsFav .jcarousel-tabs-rb .jcarousel-prev { position: absolute; top: 65px; left: 0px; cursor: pointer; height: 30px; width: 15px; background: url('../images/btn-tabslider.png') no-repeat 0px 0; }
.categoryTabsFav .jcarousel-tabs-rb .jcarousel-prev:hover, .homepagetabs .jcarousel-tabs-rb .jcarousel-prev:active { background: url('../images/btn-tabslider.png') no-repeat 0px -40px; }


.toolbar { background: #a0a0a0; border: none; height: 20px; width: 680px; padding: 10px; color: #fff; text-transform: uppercase; font-size: 12px; font-weight: 600; letter-spacing: 0.3px; line-height: 20px; position: relative; }
.toolbarfav { background: #a0a0a0; border: none; height: 20px; width: 915px; padding: 10px; color: #fff; text-transform: uppercase; font-size: 12px; font-weight: 600; letter-spacing: 0.3px; line-height: 20px; position: relative; }
.pager ol li { height: 20px; width: 25px; text-align: center; padding: 0; line-height: 20px; margin: 0 5px 0 0; color: #fff; text-align: center; }
.toolbar button { height: 20px; min-width: 25px; text-align: center; padding: 0 3px; line-height: 20px; margin: 0 0 0 5px; color: #fff; text-align: center; }
.toolbar button.selected { background: #000; filter: none; }
.toolbarfav button { height: 20px; min-width: 25px; text-align: center; padding: 0 3px; line-height: 20px; margin: 0 0 0 5px; color: #fff; text-align: center; }
.toolbarfav button.selected { background: #000; filter: none; }
.pager ol li a { width: 25px; height: 100%; display: block; text-align: center; }
.pager ol li.next-outer, .pager ol li.previous-outer { padding: 0; min-width: 18px !important; width: 18px !important; height: 20px; display: block; }
.pager ol li a.next, .pager ol li a.previous { padding: 0; width: 18px; height: 20px; display: block; text-align: center; }
.pager .pages .current { background: #202020; filter: none; }
.limiter { 	float: left; width:160px; }
.ie8 .limiter { width:185px; }
.limiter label { float: left; }
.pager { border: medium none; float: left; margin: 0 auto; padding: 0; position: relative; text-align: center; width: 325px; }
.ie8 .pager { width: 315px; }
.ie7 .pager { width: 255px; padding: 0 0 0 55px; }
.toolbar-bottom { margin: 0 0 20px 0; }
.pager .pages { margin: 0 auto; }
.pager span { display: block; float: left; line-height: 23px; margin: 0 10px 0 0; }
.pager ol li a, .pager ol li a:active, .pager ol li a:visited, .pager ol li a:hover { color: #fff; text-decoration: none; }
.pager ol li.dot-dot { background: none; filter: none; width: 30px; height: 20px; margin: 0 0 0 -5px; }
.sort-by { margin: 0; padding: 0; border: none; float: right; width: 180px; text-align: right; }
.sort-by select { width: 180px; height: 20px; border: none; -moz-box-shadow: 0 0 0 #000; -webkit-box-shadow: 0 0 0 #000; box-shadow: 0 0 0 #000; font-size: 12px; text-transform: none; }
.col2-left-layout .products-grid, .col2-right-layout .products-grid { margin: 0 auto; width: 700px; }
.products-grid { border: none; padding: 0; margin: 0; }
.products-grid li.item { float: left; margin: 0 2px 2px 0; width: 232px; height: 403px; padding: 0 0 15px 0; display: block; background: #fff; position: relative; font-size: 11px; font-weight: 600; color: #a5a5a5; }
.ie7 .catalog-category-view .products-grid li.item { border-bottom: 2px solid #F3F2EB; }
.ie7 .catalog-category-view .products-grid.last li.item { border-bottom: none; }
.products-grid li.item.last, .products-grid.last li.item.last { margin: 0; }
.products-grid.last li.item { margin: 0 2px 0 0; }
.products-grid .actions { bottom: 15px; left: 15px; position: absolute; }
.products-grid .product-image { display: block; height: 215px; margin: 0 0 3px 0; width: 192px; padding: 20px; }
.products-grid .product-name { margin: 0 15px; }
.products-grid .product-name, .products-grid .product-name a, .products-grid .product-name a:visited { text-transform: uppercase; font-size: 15px; font-weight: 600; color: #202020; line-height: 14px; }
.products-grid .product-name a:hover, .products-grid .product-name a:active, .products-grid .product-image:hover+.product-name a, .products-grid .product-image:active+.product-name a { text-decoration: none; color: #607890; }
.products-grid p { margin: 0 15px; }
.set-config { font-size: 14px; font-weight: 400; color: #5f6162; }
.cat-num { line-height: 15px; }
.products-grid .price-box { margin: 0 13px; }
.top-price-wrapper, .bottom-price-wrapper { width: 100%; display: block; height: 16px; }
.top-price-wrapper .regular-price .price { font-size: 13px; color: #ee7b1d; }
.bottom-price-wrapper span { display: block; float: left; }
.price-sep { margin: 3px 5px 0 5px; background: #a5a5a5; display: block; width: 1px; height: 10px; }
.add-to-links { width: 100%; height: 15px; margin: 0 0 16px 0; }
.compare-check { line-height: 10px; float: left; }
.compare-label { font-size: 10px; color: #5d87a1; text-transform: uppercase; line-height: 17px; display: block; float: left; margin: 0; height: 17px; }
.compare-label.disabled { cursor: text; }
.grid-qty-cont { float: left; margin: 0 4px 0 0; }
.grid-qty-label { color: #a5a5a5; font-size: 11px; }
.grid-qty-input { width: 44px; }
.back-to-top .to-top, .back-to-top .to-top:hover, .back-to-top .to-top:active { float: right; height: 20px; line-height: 20px; text-decoration: none; width: 110px; padding: 0; font-size: 11px; }
.back-to-top .to-top span, .back-to-top .to-top { width: 110px; display: block; }
.back-to-top .to-top span span { background: url('../images/arrow-up.png') no-repeat 91px center; padding: 0; width: 100%; text-indent: 14px; display: block; text-align: left; }
.compare-controls { float: right; color: #a0a0a0; font-size: 11px; font-family: proxima-nova, "Helvetica Neue", Arial, Helvetica, Geneva, sans-serif; text-transform: uppercase; text-align: middle; height: 18px; letter-spacing: 1px; }
.x-out { font-size: 12px; padding: 2px 0 0 0; text-transform: none; }
.compare-controls a { color: #5d87a1; font-size: 11px; }
.compare-controls a:hover { color: #5d87a1; text-decoration: none; }
.catalog-category-view .breadcrumbs, .catalogsearch-result-index .breadcrumbs, .checkout-cart-index .breadcrumbs { float: none !important; padding: 0; margin-bottom: 5px; border: 0; color: #000; font-weight: 400; width: 100%; }
.breadcrumbs a { color: #6c6f71; font-family: proxima-nova, "Helvetica Neue", Arial, Helvetica, Geneva, sans-serif; }
.checkout-cart-index .breadcrumbs { float: none; }
.availability.out-of-stock span { color: #a5a5a5; font-size: 13px; font-weight: 600px; }
.compare-alert-wrapper { background: url("../images/compare_limit_notification-top.png") no-repeat 0 0; bottom: 45px; color: #4F4F4F; font-size: 14px; font-weight: 600; left: -128px; line-height: 16px; padding: 10px 0 0 !important; position: absolute; width: 320px; z-index: 99; }
.compare-alert-wrapper.compare-large { bottom: 10px; }
.compare-max-alert { background: url("../images/compare_limit_notification-bottom.png") no-repeat left bottom; padding: 15px 25px 40px 25px !important; width: 270px; }
#compare-row-features .comp-attr ul li { background: url("../images/product-bullet.jpg") no-repeat scroll 0px 7px transparent; list-style: none outside none; margin: 0; padding: 0 0 0 10px; }
/*  @end  */

/*  @group cart page  */
.checkout-cart-index .main-container { padding: 8px 0 60px 0; background: #eeede7; }
.checkout-cart-index .main { background: none; }
.checkout-cart-index .col-main { width: 100%; background: #fff; padding: 28px 0 40px 0; }
.checkout-cart-index .col-main .cart { display:block; float:left; clear:both; width: 940px; }
.cart .messages { padding: 0 20px 0 20px !important; background: url('../images/layered-border-bottom.png') repeat-x bottom left; display: block; width: 900px; margin: 0 0 25px 0; }
.cart .page-title { padding: 0 20px 19px 20px; margin-bottom: 19px; height: 40px; background: url('../images/layered-border-bottom.png') repeat-x bottom left; }
.cart .page-title h1 { margin: 0; }
.cart-table { background: #eeede7; padding: 2px; border-left: 1px solid #fff; margin: 0 20px 15px 20px; width: 898px; }
.cart-table .product-name { margin: 0; }
.cart-table tbody { border: none; }
.cart-table thead { background: #eeede7; height: 24px; font-size: 12px; color: #202020; line-height: 24px; border: 2px solid #eeede7; }
.cart-table th { border: none; margin: 2px; }
.cart-table tr { border: none; }
.cart-table thead tr { border-right: 2px solid #eeede7; }
.cart-table td { border-left: 2px solid #eeede7; border-right: 2px solid #eeede7; margin: 2px; background: #fff; border-spacing: 2px; border-collapse: collapse; vertical-align: top; padding: 25px 0; border-top: none; }
.cart-table td:first-child { border-right: none !important; width: 140px; padding: 0; }
.cart-table td:nth-child(2) { border-left: none; width: 318px; padding: 25px 20px; }
.cart-table td:nth-child(3) { width: 43px; }
.cart-table td:nth-child(4) { width: 71px; text-align: center !important; font-size: 15px; color: #5f6162; }
.cart-table td:nth-child(5) { width: 120px; }
.cart-table td:nth-child(6) { width: 65px; text-align: center !important; font-size: 15px; color: #5f6162; }
.cart-table td:last-child { padding: 32px 0; width: 62px; }
.cart-table .product-name a, .cart-table .product-name a:visited { color: #202020; }
.cart-table .product-name a:hover { text-decoration: none; color: #607890; }
.cart-table a { font-size: 11px; margin: 0 auto; }
.cart-table a.product-image { display: block; float: left; padding: 20px; }
.cart-table h2 a { font-size: 15px; font-weight: 600; }
.cart-price .price { font-size: 15px; }
.cart-table input.qty { width: 50px !important; border: none; text-align: center; height: 27px; color: #5f6162; margin: -6px 0 0 0; }
.btn-remove2 { background: none; text-indent: 0; font-size: 11px; height: 100%; width: 53px; overflow: visible; line-height: 11px; }
.cart .cat-num { font-size: 11px; color: #8e8e8e; }
.cart .set-config { color: #4f4f4f; }
.cart-table tfoot { border: none; }
.cart-table tfoot td, .cart-table tfoot td:first-child, .cart-table tfoot td:last-child { padding: 10px 10px 10px 0 !important; height: 20px; border-bottom: 2px solid #eeede7 !important; border-left: 2px solid #eeede7 !important; border-right: 2px solid #eeede7 !important; }
.cart-table tfoot td button.button { float: right; margin: 0 10px 0 0; }
.cart-table tfoot td button.button.btn-continue { float: left; margin: 0 0 0 10px; }
.cart-table tfoot td button.button span span { font-size: 11px; }
.cart-table tfoot td button.button.btn-continue span span { padding: 0 30px 0 0; font-size: 11px; }
.cart .totals .checkout-types { font-size: 13px; padding: 8px 0 15px 0; text-align: right; }
.cart .discount h2, .cart .shipping h2 { font-size: 19px; margin: 0; font-family: proxima-nova, "Helvetica Neue", Arial, Helvetica, Geneva, sans-serif; padding: 0; text-transform: uppercase; letter-spacing: 1px; }
.cart .cart-collaterals { padding: 0 0 0 20px; }
.cart-collaterals p { line-height: 16px; }
.cart .discount, .cart .giftcard { padding: 0; width: 250px; float: left; }
.cart .shipping { float: left; padding: 2px 41px 0 0; width: 277px; margin: 0; }
.cart .deals { float: left; width: 250px; padding: 2px 0 0 0; }
.shipping li.country { display: none; }
.shipping-form .form-list input.input-text { width: 288px; height: 25px; padding: 0; float: left; text-indent: 10px; }
.cart .discount input.input-text { width: 305px !important; height: 25px; padding: 0; float: left; text-indent: 10px; margin: 6px 0 0 0; }
.shipping-form .form-list { margin: 5px 0 0 0; }
.shipping-form .form-list li, .discount input { margin: 0; width: 277px; }
.totals { padding: 0 20px 0 0; width: 308px !important; }
.totals .totals { padding: 0; }
.cart .totals table { padding: 0; margin: 0; }
.cart .totals td { padding: 0 0 2px 0; }
.checkout-types li { display: none; }
.checkout-types li:first-child { display: block; }
.shipping-form { width: 277px; }
.shipping .shipping-form #shipping-zip-form div.buttons-set { width: 277px !important; margin: 0 !important; display: block !important; position: relative !important; padding: 0 !important; }
.shipping button, .discount button { margin: 13px 0 0 0; float:right; }
#shopping-cart-totals-table tr td { width: 162px; padding: 0 10px 0 0; font-weight: 400; color: #4f4f4f; }
#shopping-cart-totals-table tr td:last-child { width: 95px; padding: 0; text-align: right; }
#shopping-cart-totals-table tr td .price, #shopping-cart-totals-table tr td .price .price { font-family: proxima-nova, "Helvetica Neue", Arial, Helvetica, Geneva, sans-serif; text-align: right; }
.cart-collaterals button.button, .cart-collaterals button.button:hover, .cart-collaterals button.button:active { font-size: 10px; height: 28px; letter-spacing: 1px; line-height: 28px; padding: 0 8px; }
.cart .totals tfoot td { padding: 13px 16px 0 0 !important; }
.cart .totals tfoot td:last-child { padding: 13px 0 0 0 !important; }
.cart .totals tfoot th strong, .cart .totals tfoot td strong, .cart .totals tfoot td span { font-size: 18px; font-weight: 600; }
#discount-coupon-form .button.cancel-btn { margin: 13px 0 0 10px; }
.instock { color: #819f41 !important; }
/*  @end  */

/*  @group checkout page  */
.opc { width: 620px; float: left; border: none; }
.opc button.button { padding: 0 10px; }
.opc-progress-container { width: 300px; float: right; }
.checkout-onepage-index .main-container { background: #eeede7; padding: 40px 0 26px 0; }
#checkout-step-login ul { padding: 10px 0 0 0; }
.opc-wrapper .form-list label { line-height: 21px; }
.opc .radio-container { padding-right: 10px; float: left; display: block !important; height: 13px !important; width: 13px !important; text-align: left; }
#checkout-step-login .buttons-set a { float: right; line-height: 26px; margin: 0 10px 0 0; }
.checkout-onepage-index .opc { background: #fff; margin: 5px 0 0 0; }
.opc .step { border-top: none; padding: 20px 40px; position: relative; width: 540px; }
.opc li.section { border: none; border-bottom: 2px solid #EEEDE7; display: block; clear: both; width: 100%; }
.opc li.section:last-child { border-bottom: none; }
.opc .step-title { height: 40px; line-height: 40px; }
.opc .section .step-title { background: #a0a0a0 url('../images/icon-checkout-next.png') no-repeat 20px 10px; height: 40px; line-height: 40px; font-size: 14px; font-weight: 400; }
.opc .section.allow .step-title { background: #a0a0a0 url('../images/icon-checkout-complete.png') no-repeat 20px 10px; height: 40px; line-height: 40px; color: #cfcfcf; margin: 0; padding: 0; font-size: 20px; font-weight: 600; }
.opc .section.allow.active .step-title { background: #7ba2b3 url('../images/icon-checkout-active.png') no-repeat 15px 10px;  background: -moz-linear-gradient(top, #7ba2b3 0%, #66CC33 100%) url('../images/icon-checkout-active.png') no-repeat 15px 10px;  background: -webkit-gradient(linear, left top, left bottom, color-stop(0%, #7ba2b3), color-stop(100%, #66CC33)) url('../images/icon-checkout-active.png') no-repeat 15px 10px; background: -webkit-linear-gradient(top, #7ba2b3 0%, #66CC33 100%) url('../images/icon-checkout-active.png') no-repeat 15px 10px;  background: -o-linear-gradient(top, #7ba2b3 0%, #66CC33 100%) url('../images/icon-checkout-active.png') no-repeat 15px 10px; background: -ms-linear-gradient(top, #7ba2b3 0%, #66CC33 100%) url('../images/icon-checkout-active.png') no-repeat 15px 10px; background: linear-gradient(top, #7ba2b3 0%, #66CC33 100%) url('../images/icon-checkout-active.png') no-repeat 15px 10px; height: 50px; line-height: 50px; color: #fff; margin: 0; padding: 0; font-size: 20px; font-weight: 600; }
.opc .section.allow .step-title .number, .opc .section .step-title .number { color: #fff; }
.opc .section .step-title .number, .opc .section.allow .step-title .number { margin: 0 10px 0 16px !important; display: block; }
.opc .section.allow.active .step-title .number { margin: 0 20px 0 24px !important; display: block; color: #7ba2b3; font-size: 20px; font-weight: 600; line-height: 50px !important; }
.opc .section.allow.active:first-child .step-title .number { margin: 0 20px 0 26px !important; }
.opc .section .step-title .number { margin: 0 23px 0 21px !important; padding: 0; font-weight: 400; font-size: 14px; line-height: 41px !important; }
.opc .section .step-title h2, .opc .section.allow .step-title h2, .opc .section.allow .step-title .number { margin: 0; padding: 0; font-weight: 400; font-size: 14px; line-height: 40px; }
.opc .section.allow .step-title h2 { color: #cfcfcf; margin: 0 0 0 56px; }
.opc .section.allow.active .step-title h2 { margin: 0; }
.opc .section .step-title h2 { margin: 0; color: #fff; }
.opc .section.allow .step-title .number { display: none; }
.opc .section.allow.active .step-title h2 { color: #fff; font-weight: 600; font-size: 20px; line-height: 50px; }
li.fields { width: 100% !important; margin: 0 0 14px 0; }
.checkout-onepage-index .form-list .fields .field { clear: none; float: left; margin: 0; width: 250px; margin: 0 40px 0 0 !important; }
.checkout-onepage-index .form-list .fields .field:last-child { margin: 0 !important; }
.opc .field label, .opc .field-long label, li.field-right label { width: 100%; margin: 0 0 5px 0; }
li.field { width: 250px !important; float: left; margin: 0 40px 20px 0 !important; }
li.field-right { width: 250px !important; float: left; margin: 0 0 20px 0; }
li.field-long { width: 100%; clear: both; margin: 0 0 10px 0; }
li.add-field.field-long { margin-bottom: 14px; }
li.field-long input { width: 540px !important; }
#checkout-step-shipping_method #checkout-shipping-method-load { width: 250px !important; margin: 0 40px 0 0; float: left; min-height: 60px; }
#checkout-step-shipping_method #onepage-checkout-shipping-method-additional-load { width: 250px !important; margin: 0; float: left; min-height: 60px; }
#checkout-payment-method-load p.note { margin: 10px 0 0 0; }
.sp-methods ul.form-list { margin: 0; padding: 20px 0 0 0; }
.sp-methods ul.form-list li { margin: 0 0 20px 0; }
.sp-methods ul.form-list label { width: 540px; margin: 0 0 10px 0; display: block; }
.sp-methods ul.form-list li .input-box { width: 250px; }
.sp-methods ul.form-list li .input-box #ccsave_cc_type { width: 253px; }
#payment_form_ccsave .input-box { width: 100%; }
#review-buttons-container.buttons-set button.btn-checkout { float: right !important; }
.opc .buttons-set .please-wait { position: relative; top:-32px; color: #7ba2b3; font-family: "Helvetica Neue", Arial, Helvetica, Geneva, sans-serif; z-index: 500; margin-bottom: 0px; }
.checkout-onepage-index button.button span { background: none; }
.checkout-onepage-index button.button span { background: none; padding: 0 !important; }
button.btn-checkout { float: right; }
.opc-wrapper .block .block-title { border-bottom: none; margin: 0 0 5px; padding: 0 0 2px; }
.opc-wrapper .block .block-title strong span { color: #66CC33; }
.opc-block-progress .block-content, .block-progress dt.complete, .block-progress dd.complete { background: #fff; }
.opc-block-progress .block-content { padding: 0 20px 20px 20px !important; }
.opc-block-progress .block-content dt { padding: 20px 0 0 0; }
.opc-block-progress .block-content dt:first-child { padding: 10px 0 0 0; }
.opc-wrapper .opc select:focus, .opc-wrapper .opc select:active, .opc-wrapper .opc select, .opc-wrapper .opc select.valiidation-failed { text-indent: 0 !important; }
#allow-gift-options-container div div { padding: 20px 0 0 0; }
#allow-gift-options-container div.extra-options-container { padding: 0; }
.checkout-onepage-success .sub-title { border-top: none; color: #4f4f4f; font-size: 15px; padding: 0; }
.checkout-onepage-success p { color: #4f4f4f; }
.sp-methods select.month, .sp-methods select.month.validation-failed, .sp-methods select.month:active, .sp-methods select.month.validation-failed:active, .sp-methods select.month:focus, .sp-methods select.month.validation-failed:focus { width: 150px; text-indent: 0px !important; }
.sp-methods select.year, .sp-methods select.year.validation-failed, .sp-methods select.year:active, .sp-methods select.year:focus { width: 96px; text-indent: 0px !important; }
.ie7 #co-payment-form label { height: 13px; display: block; line-height: 21px; }
/*  @end  */

/*  @group account pages  */
.registered-users { margin: 0 0 10px 0; }
.account-login a { float: right; margin: 0 112px 0 0; }
.account-pages .form-list label { min-width: 130px; }
.account-pages .form-list .field { width: 550px; }
.account-pages .form-list li.wide .input-box { width: 450px; }
.account-pages .form-list li.wide .input-box input { width: 287px; }
.field.name-firstname, .field.name-lastname { width: 100%; clear: both; }
.field.name-firstname { margin: 0 0 10px 0 !important; }
.main-container.account-pages, .sales-recurring-profile-index .main-container, .sales-billing-agreement-index .main-container, .catalog-product-view .main-container, .ustorelocator-location-map .main-container, .customer-account-login .main-container, .customer-account-create .main-container, .checkout-onepage-success .main-container, .dealerproductspecs-index-index .main-container, .customer-account-logoutsuccess .main-container, .customer-account-forgotpassword .main-container/*, .catalogsearch-result-index .main-container*/ { background: #eeede7; padding: 40px 0; }
.account-pages .col-main, .sales-recurring-profile-index .col-main, .sales-billing-agreement-index .col-main { width: 670px; background: #fff; padding: 15px 20px 20px 20px; }
.account-pages .col-main1, .sales-recurring-profile-index .col-main1, .sales-billing-agreement-index .col-main1 { width: 900px; background: #fff; padding: 15px 20px 20px 20px; }
.account-pages .col-mainwide, .sales-recurring-profile-index .col-mainwide, .sales-billing-agreement-index .col-main1 { width: 950px; background: #fff; padding: 15px 20px 20px 20px; }
.account-pages .col-left, .sales-recurring-profile-index .col-left, .sales-billing-agreement-index .col-left { border: none; background: #fff; width: 200px; padding: 15px 0 0 0; }
.block { border: none; padding: 0 15px; }
.block .block-title { border-bottom: 2px solid #66CC33; margin: 0 0 5px; padding: 0 0 2px; }
.block .block-content { padding: 0 0 17px 0; }
.block .block-content li a { line-height: 22px; }
.block .block-title strong span { font-size: 15px; text-transform: uppercase; font-weight: 600; color: #5b5e5e; }
.dashboard>.col2-set { margin: 0 0 40px 0; padding: 0; }
.welcome-msg { padding: 0 0 25px 0; }
h2.sub-title { font-size: 15px; border-top: 1px dotted #000; padding: 10px 0 0 0; color: #202020; }
.welcome-msg h2.sub-title { border-top: none; font-size: 20px; }
.info-box .dash-edit { margin: 10px 0 0 0; }
.customer-account-edit .info-box { margin: 0 0 40px 0; }
.customer-account-edit .fieldset { margin: 0 0 25px 0; }
.box-title a { background: none; -moz-box-shadow: 0 0 0 #000; -webkit-box-shadow: 0 0 0 #000; box-shadow: 0 0 0 #000; border: none; float: none; text-shadow: none; padding: 0; color: #5d87a1; font-weight: 600; font-size: 12px !important; }
.box-title a:hover, .box-title a:active { background: none; -moz-box-shadow: 0 0 0 #000; -webkit-box-shadow: 0 0 0 #000; box-shadow: 0 0 0 #000; border: none; float: none; text-shadow: none; padding: 0; }
.customer-address-form .my-account input, .customer-address-form .my-account li.wide input.input-text { width: 287px; }
div.box { border: none; padding: 0; margin: 0; }
.account-pages .pager { border: medium none; float: left; left: auto; margin: 20px 0; padding: 0; position: relative; text-align: left; width: 670px; }
.account-pages .pager select { width: 100px; }
.account-pages .limiter { width: 207px !important; }
#wishlist-view-form .buttons-set button { margin: 0 10px 0 0; }
#wishlist-table tbody td { vertical-align: top; padding: 50px 5px 20px 5px; }
#wishlist-table tbody td:first-child { padding: 0 0 20px 0; }
#wishlist-table .btn-cart { text-indent: -99999px; background: url("../images/btn-sm-addtocart.png") no-repeat 0 0; height: 22px; width: 85px; margin: 10px 0 10px 0; }
.account-pages button { margin: 0 10px 0 0; }
#wishlist-table .btn-cart:hover, #wishlist-table .btn-cart:active { background: url("../images/btn-sm-addtocart.png") no-repeat 0 28px; }
#wishlist-table .product-name, #wishlist-table .price-box { margin: 5px 5px 5px 5px; }
.customer-address-index .title-buttons button { float: right; }
.wishlist-index-index .price-box { display: inline-block; }
.wishlist-index-index .price-box span { display: block; }
.wishlist-index-index .top-price-wrapper { height: auto; }
.wishlist-index-index .bottom-price-wrapper { height: auto; padding: 10px 0 0 0; }
.customer-account-forgotpassword .fieldset { margin: 0; }
.customer-account-forgotpassword .fieldset ul { padding: 10px 0 0 0; }
.newsletter-manage-index .col-left.sidebar .block-content li.current strong { white-space: nowrap; color:#66CC33; }
.customer-account-edit .info-box .headline { font-weight: 600; }
.shipping-tracking-popup { background: #EEEDE7; }
.shipping-tracking-popup button.button { float: right; }
.shipping-tracking-popup .divider { background: none; }
.tracking-table-popup, .tracking-table-popup th, .tracking-table-popup td { background: #fff !important; border: none; }
.tracking-table-popup tr { border-bottom: 2px solid #EEEDE7; }   
.tracking-table-popup tr.last { border-bottom: none; }
.tracking-table-popup th { text-align: right; padding: 10px 0 10px 0; }
.tracking-table-popup td { padding: 0 0 0 20px; }
.tracking-table-popup tr.first th, .tracking-table-popup tr.first td { padding: 10px 0 10px 20px; }
.tracking-table-popup tr.last th, .tracking-table-popup tr.last td { padding: 10px 0 10px 20px; }
/*  @end  */

/*  @group Store Finder  */
#storelocator-container { width: 940px !important; }
.ustorelocator-location-map { width: 100%; clear: both; }
.ustorelocator-location-map .input-box { min-width: 165px; display: inline-block; margin: 0 50px 0 0; }
#store_locator_form li { float: left; }
#store_locator_form li label { float: left; margin: 0 20px 0 0; line-height: 24px; }
#store_locator_form li input, #store_locator_form li select { float: left; margin: 0 40px 0 0; }
.ustorelocator-location-map .group-select button { margin: 0 10px 0 0; float: left; height: 24px; line-height: 24px; }
.ustorelocator-location-map #storelocator-results { float: left; margin: 40px 0 0 0; }
#storelocator-container { border: none !important; background: none !important; }
#storelocator-container #map { width: 672px; height: 500px; }
.sidebar-container { width: 268px; vertical-align: top; background: #fff; }
.ustorelocator-location-map #sidebar { width: 228px; height: 480px; padding: 10px 20px; }
.ustorelocator-location-map #sidebar a, .ustorelocator-location-map #sidebar a:hover { background: none; border-top: 1px solid #a0a0a0; padding: 10px 0; margin-bottom: 0; display: inline-block; }
.ustorelocator-location-map #sidebar a:first-child { border: none; }
.sidebar-address { width: 155px; float: right; color: #4f4f4f; width: 150px; max-width: 150px; min-width: 150px; }
#sidebar a img { padding: 3px 0 0 0; }
.ustorelocator-location-map .validation-advice { padding: 3px 0 0 0; }
/*  @end  */


/*  @group form  */
.selector select option { background: #fff; }
.validation-failed { background-color: #fcece9 !important; border: none !important; box-shadow: 0 1px 1px #e17563 inset !important; -moz-box-shadow: 0 1px 1px #e17563 inset !important; -webkit-box-shadow: 0 1px 1px #e17563 inset !important; }
.validation-advice { background: none !important; clear: both; color: #e3452a; font-size: 13px; line-height: 15px; margin: 3px 0 0; min-height: 13px; padding-left: 0; }
/*  @end  */

/*  @group utility menu  */
ul.links .dropdown-cart, ul.links .dropdown-wishlist { display: none; background-color: black; width: 100%; padding: 0; z-index: 999; position: relative; }
ul.links { position: relative; }
li.my-cart:hover .dropdown-cart, li.wishlist:hover .dropdown-wishlist, li.my-alerts:hover .dropdown-cart{ display: block; position: absolute; left: 0; top: 30px; }
.dropdown-cart .actions { display: none; }
.dropdown-cart .mini-products-list ol, .dropdown-wishlist .mini-products-list ol { display: block; width: 100%; padding: 0 0 15px 0; }
.dropdown-cart .mini-products-list li, .dropdown-cart .mini-products-list ol { display: block; width: 100%; }
.dropdown-cart .mini-products-list li, .dropdown-wishlist .mini-products-list li { min-height: 89px; margin: 0 0 15px 0; width: 100%; display: block; padding: 0; }
.dropdown-cart .mini-products-list li.last, .dropdown-wishlist .mini-products-list li.last, .dropdown-wishlist .mini-products-list li:last-child { min-height: 89px; margin: 0 !important; padding: 0 !important; }
.quick-access ul .product-details { margin: 0 0 0 10px; float: left; position: relative; min-height: 89px; }
.quick-access ul.links .my-cart .dropdown-cart a, .quick-access ul.links .dropdown-wishlist a { background: none; -moz-box-shadow: 0 0 0 #000; -webkit-box-shadow: 0 0 0 #000; box-shadow: 0 0 0 #000; display: block; height: 18px; margin: 0; padding: 0; text-align: left; width: auto; float: left; font-weight: 800; }
.dropdown-cart a.product-image, .dropdown-wishlist a.product-image { border: none; width: 80px; height: 89px; display: block; float: left; padding: 0 !important; margin: 0 0 0 15px !important; }
.dropdown-cart .block-title, .dropdown-wishlist .block-title { display: block; width: 100%; height: 15px; padding: 12px 0 15px 0; background: url('../images/mini-cart-border.png') repeat-x left bottom; }
.dropdown-cart .block-title a { text-transform: none; }
.dropdown-cart .block-content, .dropdown-wishlist .block-content { padding: 15px 0; display: inline-block; width: 100%; }
.dropdown-cart .block-bottom, .dropdown-wishlist .block-bottom { display: block; width: 100%; padding: 15px 0 0 0; background: url('../images/mini-cart-border.png') repeat-x left top; }
.dropdown-cart strong, .dropdown-wishlist strong { float: left; margin: 0 0 0 15px; }
.dropdown-cart strong span, .dropdown-wishlist strong span { font-size: 15px; font-weight: 600; color: #fff; text-transform: uppercase; }
.quick-access ul.links .my-cart .dropdown-cart .block-title a, .quick-access ul.links .dropdown-wishlist .block-title a { float: right; font-size: 12px; color: #7db3d4; margin: 0 15px 0 0; }
.quick-access ul.links .my-cart .dropdown-cart .block-title a:hover, .quick-access ul.links .my-cart .dropdown-cart .block-title a:active, .quick-access ul.links .dropdown-wishlist .block-title a:hover, .quick-access ul.links .dropdown-wishlist .block-title a:active { text-decoration: underline; font-size: 12px; color: #7db3d4; }
.dropdown-cart .block-content p, .dropdown-wishlist .block-content p { clear: both; }
.block-bottom .label { font-size: 20px; color: #fff; font-weight: 400; float: right; margin: 0 15px 0 0; text-align: right; }
.block-bottom .label sup { font-weight: 400; font-size: 12px; }
.block-bottom .price { font-size: 20px; color: #fff; font-weight: 400; float: right; margin: 0 15px 0 0; text-indent: 7px !important; }
.block-bottom .subtotal { margin: 0 0 15px 0; height: 35px; display: inline-block; float: right; letter-spacing: 1px; }
.block-bottom .disclaim { clear: both; font-size: 11px; font-weight: 400; font-style: italic; color: #fff; display: block; height: 11px; margin: 3px 0 0 0; float: right; width: 80%; text-align: right; padding: 0 15px 0 0; }
.dropdown-cart .product-name, .dropdown-cart .product-name a, .dropdown-cart .product-name a:active, .dropdown-cart .product-name a:hover, .dropdown-cart .set-config, .dropdown-cart .product-details strong, .dropdown-wishlist .product-name, .dropdown-wishlist .product-name a, .dropdown-wishlist .product-name a:active, .dropdown-wishlist .product-name a:hover, .dropdown-wishlist .set-config, .dropdown-wishlist .product-details strong { font-size: 13px !important; color: #e9e9e9 !important; font-weight: 400; display: block; padding: 0 !important; margin: 0 !important; text-transform: uppercase; }
.dropdown-cart .set-config, .dropdown-wishlist .set-config { text-transform: capitalize; }
.dropdown-cart .product-details strong { text-transform: none; display: block; margin: 15px 0 0 0 !important; }

.dropdown-wishlist .grid-qty-cont .grid-qty-label { color: #E9E9E9 !important; font-size: 13px !important; font-weight: 400; padding: 0 !important; text-transform: none; width: 210px; letter-spacing: 1px; }
.dropdown-cart .cat-num, .dropdown-wishlist .cat-num { font-size: 11px; color: #a5a5a5; letter-spacing: 1px; }
.dropdown-cart li.item .product-details .price, .dropdown-wishlist li.item .product-details .price { position: absolute; top: 0; right: 0; font-size: 13px; color: #e9e9e9; letter-spacing: 1px; }
.dropdown-wishlist button.btn-cart, .dropdown-wishlist button.btn-cart:active, .dropdown-wishlist button.btn-cart:hover { height: 26px; line-height: 26px; font-size: 11px; padding: 0 5px; float: left; box-shadow: 0 0 0 #000; -moz-box-shadow: 0 0 0 #000; -webkit-box-shadow: 0 0 0 #000; letter-spacing: 1px; }
.dropdown-wishlist button.btn-cart span { line-height: 26px; font-size: 10px; }
.dropdown-wishlist button.btn-cart span span { line-height: 26px; font-size: 10px; }
.add-container { position: absolute; bottom: 0; left: 100; width: 180px; }
.quick-access .block-content p.empty { margin: 0 0 0 15px; color: #fff; font-size: 12px; }
.mini-pricing { float: right; padding: 0 15px 0 0; font-size: 13px; color: #fff; }
.dropdown-wishlist .grid-qty-input { width: 40px; text-align: center; height: 26px; line-height: 26px; margin: 0 1px 0 2px; }
/*  @end  */

/*  @group Messages  */
.ie7 .col-main .cart .messages, .ie8 .col-main .cart .messages { padding: 0 0 25px 0 !important; width: 940px !important; }
.messages li { margin: 0 0 25px 0; }
.error-msg, .success-msg, .note-msg, .notice-msg { border: none; font-size: 16px !important; font-weight: 400 !important; min-height: 24px !important; padding: 8px 8px 8px 40px !important; line-height: 21px; border-radius: 5px 5px 5px 5px; -moz-border-radius: 5px 5px 5px 5px; -webkit-border-radius: 5px 5px 5px 5px; }
.success-msg { background-position: 10px 10px !important; background-repeat: no-repeat !important; background-color: #8dbd5a; background-image: url("../images/icon-success-message.png"); color: #fff; font-family: "Crimson Text", Georgia, "Times New Roman", Times, serif; font-size: 16px !important; }
.error-msg { background-position: 10px 10px !important; background-repeat: no-repeat !important; background-color: #e3452a; background-image: url("../images/icon-error-message.png"); color: #fff; font-family: "Crimson Text", Georgia, "Times New Roman", Times, serif; font-size: 16px !important; }
.note-msg { background-position: 10px 10px !important; background-repeat: no-repeat !important; background-color: #a23f6b; background-image: url("../images/icon-noresults-message.png"); color: #fff; font-family: "Crimson Text", Georgia, "Times New Roman", Times, serif; font-size: 16px !important; }
.notice-msg { background-position: 10px 10px !important; background-repeat: no-repeat !important; background-color: #e9ba00; background-image: url("../images/icon-alert-message.png"); color: #fff; font-family: "Crimson Text", Georgia, "Times New Roman", Times, serif; font-size: 16px !important; }
/*  @end  */

/*  @group our brands cms page  */
.cms-our-brands .std { padding: 45px 39px !important; }
.cms-our-brands p { font-size: 14px !important; line-height: 20px !important; color: #4f4f4f !important; }
.brands-header { text-align: center; }
.brands-header h1 { text-align: center; font-size: 25px !important; line-height: 30px !important; font-weight: 600; letter-spacing: 1px; padding: 0 !important; margin: 0 !important; color: #202020; width: 100%; clear: both; }
.brands-header p { text-align: center; width: 100%; clear: both; }
.brands-header .rules { width: 100%; border-top: 3px double #dcdad0; border-bottom: 3px double #dcdad0; display: inline-block; margin: 8px 0 0 0; }
.brands-header img { float: left; padding: 10px 0; }
.brands-container .brands .copy p { width: 100%; }
.brands article { text-align: left; background: url('../images/layered-border-bottom.png') repeat-x bottom left; padding: 0 0 1px 0; display: inline-block; margin: 0; }
.ie7 .brands article { background: url('../images/layered-border-bottom.png') repeat-x bottom left; padding: 5px 0 5px 0; }
.brands article:last-child { background: none;	 border-bottom: 3px double #dcdad0; padding: 0 0 5px 0; }
.ie7 .brands article:last-child { background: none; border-bottom: 3px double #dcdad0; margin: 0 0 30px 0; padding: 0 0 5px 0; }
.brands .odd .copy { float: left; display:block; width: 505px; height:auto; }
.brands .even .copy { float: left; width: 505px; display:block; height:auto; }
.brands .odd img { float: left; display:block; margin: 0; }
.brands .even img { float: right; display:block; margin: 0; }
#williams .copy { height:240px; }
.brands h2 { font-size: 18px !important; line-height: 18px !important; margin: 24px 0 4px 0 !important; padding: 0 !important; }
.brands .copy .backtotop { text-transform: uppercase; color: #5d87a1; font-size: 12px; background: url('../images/brandPage/arrow-top.png') no-repeat right 5px; padding: 0 14px 0 0; font-weight: 600; white-space: nowrap; display:inline-block; height:14px; }
.brands .copy .backtotop a, .brands .copy .backtotop a:hover, .brands .copy .backtotop a:visited { text-transform: uppercase; color: #5d87a1; font-size: 12px; padding: 0; font-weight: 600; text-decoration: none; white-space: nowrap; display:inline-block; float:left; height:14px; line-height:20px; }
.brands-footer p { text-align: center; width: 100%; margin: 0 0 10px 0; }
/*  @end  */

/*  @group REED ALL ABOUT IT PAGE  */
.cms-page-view.cms-read-all-about-it .std { padding: 0; width: 940px; }
.cms-read-all-about-it .tabs-column { width: 190px; float: left; padding: 38px 17px 0 17px; }
.cms-read-all-about-it .tabs-column h3 { width: 190px !important; margin: 0 0 11px 0 !important; padding: 0 0 4px 0 !important; border-bottom: 2px solid #7ba2b3 !important; font-size: 15px !important; color: #4f4f4f !important; display: block !important; clear: both !important; }
.cms-read-all-about-it .tabs-column ul { margin: 0 0 39px 0; display: block; clear: both; }
.cms-read-all-about-it .tabs-column li { width: 190px; background: url('../images/layered-border-bottom.png') repeat-x left bottom; padding: 7px 0 7px 0; font-size: 13px; font-weight: 600; line-height: 16px; }
.cms-read-all-about-it .tabs-column li.active a { background: url("../images/reedAboutPage/active-arrow.jpg") no-repeat right center; color: #202020; cursor: default; display: block; height: 100%; position: relative; text-decoration: none; width: 209px; z-index: 9; }
.cms-read-all-about-it .tabs-column li.active a span { width: 190px; display: block; }
.cms-read-all-about-it .tabs-column li:first-child { padding: 0 0 7px 0; }
.cms-read-all-about-it .tabs-column li:last-child { padding: 7px 0 0 0; background: none; }
.cms-read-all-about-it .content { width: 642px; padding: 0 36px 80px 36px; float: right; border-top: none; border-left: 2px solid #f1f0e9; clear: none; height: 100%; }
.cms-read-all-about-it h2 { font-size: 20px; clear: both; width: 100%; text-align: center; margin-top: 0 !important; margin: 0 0 10px 0 !important; }
.cms-read-all-about-it h4 { font-size: 18px; color: #202020; text-transform: uppercase; font-weight: 600; padding: 25px 0 7px 0; clear: both; }
.cms-read-all-about-it p { width: 100%; display:block; float:left; clear:none; font-size: 14px !important; line-height: 20px !important; }
.cms-read-all-about-it p .ital { color: #202020; font-style: italic; }
#the-toast { margin: 35px 0 0 0; }
.cms-read-all-about-it .img-contain { text-align: center; margin: 0 !important; }
.cms-read-all-about-it .toast-list { width: 622px; }
.cms-read-all-about-it .toast-list li { float: left; width: 412px; font-size: 14px; line-height: 20px; }
.cms-read-all-about-it .toast-list li.toast { width: 210px; font-weight: 600; font-style: italic; }
.cms-read-all-about-it .toast-list li span { font-style: italic; font-weight: 600; }
.cms-read-all-about-it .quote { font-style: italic; margin: 0 0 18px 0 !important; }
.cms-read-all-about-it .credit { font-size: 12px; font-weight: 600; }
#holiday-table-tips { margin: 40px 0 0 0; }
#holiday-table-tips h2 { margin: 21px 0 10px 0 !important; }
#holiday-table-tips .buffet { width: 100%; text-align: center; height: 341px; margin: 0 0 52px 0; display: block; clear: both; position: relative; padding: 50px 0 0 0; }
#flatware { margin: 44px 0 0 0; }
#flatware h2 { margin: 21px 0 10px 0 !important; }
span.terms { text-transform: uppercase; font-weight: 800; }
#give-it-a-shot { margin: 40px 0 0 0; }
#give-it-a-shot h2 { margin: 21px 0 10px 0 !important; }
.related-container { clear: both; display: none; padding: 22px 0 0 0; }
.related-container.active-tab { display:block; }
.related-item { margin: 0 0 38px 0; display: inline-block; }
.related-item img { margin: 0 0 13px 0; }
.related-item img { margin: 0 0 13px 0; }
.cms-read-all-about-it .related-item .related-name { width: 100%; text-align: center; font-size: 13px !important; font-weight: 600; color: #202020 !important; text-transform: uppercase; margin-bottom: 0 !important; margin: 0; line-height: 13px !important; }
.cms-read-all-about-it .related-item .related-sub { width: 100%; text-align: center; font-size: 12px !important; font-weight: 600; color: #4f4f4f !important; margin-bottom: 0 !important; margin: 0; line-height: 15px !important; }

.cms-index-noroute .std, .cms-no-route .std { background: none !important; text-align: center; padding: 42px 20px 8px 20px !important; }
.cms-index-noroute .std div, .cms-no-route .std div { width: 900px; text-align: center; }
.cms-index-noroute .std h3, .cms-no-route .std h3 { text-align: center; font-size: 20px !important; line-height: 26px !important; font-weight: 400; width: 100%; margin-bottom: 29px !important; }
.cms-index-noroute .std li, .cms-no-route .std li { text-align: center !important; font-size: 13px; line-height: 20px; padding-left: 0 !important; padding-bottom: 0 !important; width: 900px !important; }
.catalogsearch-result-index .col-left { padding: 10px 0 0 0; }
#carousel-play, #carousel-pause { display: none; }

/* @group OUR BRANDS FIXES */
section.brands { display:block; float:left; width:860px; }
section.brands article { display:block; float:left; clear:both; padding-bottom:2px; width:860px !important; margin:0px !important; padding-top:5px !important; }
section.brands article img { display:block; float:left; }
section.brands-footer { display:block; float:left; width:860px; padding-top:30px !important; }
/* @end */

.shipping-method-messages { padding-bottom:14px; font-family: proxima-nova, "Helvetica Neue", Arial, Helvetica, Geneva, sans-serif; color:#4f4f4f; font-size:13px; font-weight:bold; text-transform:uppercase; }

/* @override 
	http://dealer.rb.dev/skin/frontend/blueacorn/blueacorn_rb/css/styles_ba_ec.css
	http://rb.dev/skin/frontend/blueacorn/blueacorn_rb/css/styles_ba_ec.css */

/* @group PRODUCT PAGE */

/* @group GENERAL */
.catalog-product-view, .review-product-list, .review-product-view { font-family: proxima-nova, "Helvetica Neue", Arial, Helvetica, Geneva, sans-serif; }
.catalog-product-view .main-container, .review-product-list .main-container, .review-product-view .main-container { padding:20px 0 0; background: #eeede7; }
.review-product-list .main-container, .review-product-view .main-container { padding:11px 0 0 !important; }
.catalog-product-view .col-main, .review-product-list .col-main, .review-product-view .col-main { padding: 0 0 41px 0; display:block; float:left; }
/* @end */

	
/* @group BREADCRUMBS */
.breadcrumbs { display:block; float:left; padding:1px 0 0; border:0; color:#000; font-weight:400; margin:10px 0 0 0; font-size:12px; width:100%; }
.catalog-product-view .breadcrumbs { display:block; float:left; margin:0px 0 -20px 0; clear:none; position:relative; }
.catalog-product-view .breadcrumbs { display:block; position:relative; top:-6px; }
.review-product-list .breadcrumbs { margin-bottom:16px; }
.breadcrumbs a, .breadcrumbs span { color: #6c6f71; }
/* @end */
	
/* @group TABS */
.product-view { display:block; float:left; }
.product-essential { display:block; float:left; clear:both; width:940px; height:auto; }
.product-essential .content { border:0px !important; }
.product-essential #tabs { display:block; float:right; clear:both; border:0px; width:auto; }
.product-essential #tabs li { display:block; float:left; border-bottom:0px !important; margin-left:1px !important; height:30px !important; line-height:31px !important; }
.product-essential #tabs li a { font-size:11px; height:31px; padding:0 12px; line-height:31px; width:auto; }
.product-essential #tabs li.active { border:0px; border-right:1px solid #cfcfcf; }
.related-tabs #tabsRel { display:block; float:right; clear:both; border:0px; width:auto; height:30px; }
.related-tabs #tabsRel li { display:block; float:left; border-bottom:0px !important; margin-left:1px !important; height:30px !important; line-height:31px !important; }
.related-tabs #tabsRel li a { font-size:11px; height:31px; padding:0 12px; line-height:31px; width:auto; }
.related-tabs #tabsRel li.active { border:0px; border-right:1px solid #cfcfcf; }
.product-view { width:940px; display:block; float:left; height:auto; clear:both; }
#contentDetail, #contentPersonalize, #contentLinks, #contentRelA, #contentRelB, #contentRelC { width:940px; padding:0; margin:0; background:#fff; border:0px; position:relative; display:block; float:left; border-top:0px; }
#contentDetail .inner-detail, #contentPersonalize .inner-Personalize, #contentLinks .inner-contentlinks { padding: 35px 20px; display:block; float:left; clear:both; width:900px; border:0px  }
.related-tabs .content { display:block; float:left; clear:both; width:auto; height:auto; }
/* @end */
	
/* @group PRODUCT */
.product-essentials { display:block; float:left; clear:both; background:none; }
.catalog-product-view .content, .review-product-list .content { width:860px; padding:20px 40px 60px; background:#fff; border:0px; border-top:1px solid #cfcfcf; position:relative; display:block; float:left; clear:both; top:1px; }
.product-view .product-shop { display:block; float:right; width:518px !important; }
.product-view .product-shop .grey-item { font-size:20px; color:#8e8e8e; font-weight:400; text-transform:capitalize; letter-spacing:1px; }
.product-view .product-shop h1 { color:#202020; font-size:40px; font-weight:300; text-transform:uppercase; line-height:42px; margin-top:-6px; letter-spacing:1px; }
.product-view .short-description .std { font-size:20px; color:#4f4f4f; font-weight:400; line-height:20px; padding-bottom:5px; letter-spacing:1px; }
.product-view .product-shop .top-price-wrapper { padding-top:4px; font-weight:normal; letter-spacing:1px; }
.product-view .compare-controls { padding:0px 6px 0 0; color:#5D87A1; font-weight:600; font-size:11px; top:20px; }
.compare-controls { position:relative; }
.compare-controls .spinner { display:block; position:absolute; left:-20px; top:0px; }
/* @end */	
	
/* @group INPUTS */
.product-shop input.qty { display:block; float:left; width:56px !important; height:30px; line-height:30px !important; padding:0px; border:0px; box-shadow:none; -webkit-box-shadow:none; -moz-box-shadow:none; text-indent:8px; background: url(../images/product-view-qty-bg.png) left top no-repeat; }
.product-shop input.qty:focus { background-position:left bottom; }
/* @end */
	
/* @group ADD-TO-CART */
.product-shop .add-to-cart { display:block; float:left; }
.product-shop .add-to-box { width:538px; }
.product-shop .add-to-cart label { line-height:30px; font-weight:400; font-size:13px; color:#8e8e8e; }
.product-shop .per-button { margin-left:7px; font-weight:600; }
.product-shop .per-button:hover { text-decoration:none; }
.product-shop .add-to-links { display:block; float:left; padding-top:6px; width:192px; padding:7px 0 0 0px !important; margin:0px; }
.product-shop .add-to-links li { display:block; float:left; }
.product-shop .add-to-links li a { color:#5D87A1; text-transform:uppercase; font-size:12px; font-weight:600; }
.product-shop .add-to-links li a:hover, .product-shop .add-to-links a:active { text-decoration:none; }
.product-shop .add-to-compare { width:84px; float:left; padding:0 0 0 3px; }
.product-shop .add-to-compare .compare-link { font-size:12px; font-weight:600; padding-top:1px; display:block; float:left; padding:1px 0 0 0 !important; position:relative; }
.product-shop .add-to-links .prod-compare { float:left; }
.product-shop .add-to-links li img { display:inline-block; top:1px; position:relative; }
.product-shop .add-to-links .separator { display:inline; float:left; padding-top:1px; padding-left:8px; padding-right:6px; margin:0px; }
.add-to-box a.per-button, .add-to-box .btn-cart { display:block; float:left; width:119px; padding:0px; }
.add-to-compare { padding:0px !important; width:98px !important; position:relative; }
.product-shop .add-to-compare .checker { margin-right:4px; }
.compare-label { display:block; position:relative !important; }
.compare-label .spinner { position:absolute !important; left: 55px; z-index:1005; width:16px; height:16px; }
.product-shop .add-to-compare .spinner { left:64px; }
/* @end */ 	
	
/* @group PRICE BOX */
.product-shop .price-box { padding:10px 0 25px; color:#8e8e8e; font-size:13px; }
.product-shop .price-box .top-price-wrapper span.price { color:#000000; font-size:20px; }
.product-shop .price-box .bottom-price-wrapper { line-height:26px; font-size:13px; letter-spacing:1px; }
.product-shop .price-box .bottom-price-wrapper span { font-size:13px; font-weight:400; }
.product-shop .price-box .price-sep { margin:8px 5px 0; }
/* @end */
	
/* @group AVAILABILTY */
.product-shop .availability { padding:17px 0 12px; letter-spacing:1px; }
.product-shop .availability img { padding-left:1px; vertical-align:middle; position:relative; top:-2px; }
.product-shop .availability.in-stock { color:#819F41; }
.product-shop .availability.out-of-stock span { color:#E3452A !important; }
/* @end */
	
/* @group DESCRIPTION */
.product-shop .box-additional { padding:13px 0 15px; }
.product-shop .box-collateral { margin:0px; padding-bottom:33px; }
.product-shop .box-description { padding-bottom:15px; }
.product-shop .box-collateral .std { padding-top:12px; font-size:13px; line-height:18px; letter-spacing:0.2px; border:0px !important; background: url(../images/rb_dot.png) left top repeat-x; }
.product-shop .box-collateral .std ul { padding-top:10px; margin:0; }
.product-shop .box-collateral .std ul li { margin:0; padding:0 0 0 10px; list-style:none; background: url(../images/product-bullet.jpg) left center no-repeat; }
/* @end */			
	
/* @group RATINGS */
.product-shop .ratings, .product-shop .no-rating { padding:16px 0 15px; background: url(../images/rb_dot.png) left top repeat-x; }
.product-shop .ratings a, .product-shop no-rating a { font-size:12px; color:#5D87A1; text-transform:uppercase; font-weight:600; letter-spacing:1px; }
.product-shop .no-rating a { text-decoration:none; letter-spacing:1px; }
.product-shop .ratings a:first-child { padding-left:20px; }
.catalog-product-view .ratings, .review-product-list .ratings { margin-bottom:0px; margin-top:0px; }
.ratings strong { float:left; margin:1px 3px 0 0; }
.ratings .rating-links { margin:0; }
.ratings .rating-links .separator { margin:0 6px 0 4px; }
.rating-box { width: 99px; height: 15px; font-size: 0; line-height: 0; background:url(../images/bkg_rating.png) 0 0 repeat-x; text-indent:-999em; overflow:hidden; }
.rating-box .rating { float:left; height: 14px; background:url(../images/bkg_rating.png) 0 100% repeat-x; }
.ratings .rating-box { float:left; margin-right: 3px; }
.ratings-table th, .ratings-table td { font-size:11px; line-height:1.15; padding:3px 0; }
.ratings-table th { font-weight: bold; padding-right: 8px; }
/* @end */
	
/* @group SOCIAL MEDIA */
.product-shop .addthis_toolbox { float:left; padding-right:10px; }
.product-shop .addthis_button { line-height:28px; }
.add_this_box { display:block; float:left; width:520px; height:38px; padding:7px 0 0; background: url(../images/rb_dot.png) left top repeat-x; }
/* @end */	
	
/* @group IMAGE */
.product-view .product-img-box { display:block; float:left; width:335px; }
.product-view .product-img-box .product-image { border:none; margin: 20px; }
.product-view .product-img-box .more-views ul { background:transparent; background:#F3F2EB; margin:20px 0 0; padding-top:10px; padding-bottom:5px; display:block; float:left; width:335px; }
.product-view .product-img-box .more-views ul li { padding:0px 10px 10px 0; width:55px; height:65px; background:none !important; margin:0px; }
.product-view .product-img-box .more-views ul li:first-child, .product-view .product-img-box .more-views ul li:nth-child(5n+1) { padding-left:10px; }
.product-img-box a#zoom { display: block; width: 310px; height: 340px; position:relative; }
/* @end */
	
/* @group BUTTONS */
button.btn-cart, #s7_add_to_cart { background: #5B5E5E; background: -moz-linear-gradient(top, #ee891d 0%, #ee7a1d 100%); background: -webkit-gradient(linear, left top, left bottom, color-stop(0%, #ee891d), color-stop(100%, #ee7a1d)); background: -webkit-linear-gradient(top, #ee891d 0%, #ee7a1d 100%); background: -o-linear-gradient(top, #ee891d 0%, #ee7a1d 100%); background: -ms-linear-gradient(top, #ee891d 0%, #ee7a1d 100%); filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#ee891d', endColorstr='#ee7a1d', GradientType=0 ); background: linear-gradient(top, #ee891d 0%, #ee7a1d 100%); top: 0; font-family: proxima-nova, "Helvetica Neue", Arial, Helvetica, Geneva, sans-serif; box-shadow: 0 1px 1px 0 #cacaca; -wekit-box-shadow: 0 1px 1px 0 #cacaca; -moz-box-shadow: 0 1px 1px 0 #cacaca; font-weight:600; letter-spacing:1px; }
button.btn-cart:hover, button.btn-cart:active, #s7_add_to_cart:active, #s7_add_to_cart:visited, #s7_add_to_cart:hover, .product-shop .add-to-cart button.button.btn-cart:active { background: #5B5E5E; background: -moz-linear-gradient(top, #ee7a1d 0%, #ee891d 100%); background: -webkit-gradient(linear, left top, left bottom, color-stop(0%, #ee7a1d), color-stop(100%, #ee891d)); background: -webkit-linear-gradient(top, #ee7a1d 0%, #ee891d 100%); background: -o-linear-gradient(top, #ee7a1d 0%, #ee891d 100%); background: -ms-linear-gradient(top, #ee7a1d 0%, #ee891d 100%); filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#ee7a1d', endColorstr='#ee891d', GradientType=0 ); background: linear-gradient(top, #ee7a1d 0%, #ee891d 100%); top: 0; font-family: proxima-nova, "Helvetica Neue", Arial, Helvetica, Geneva, sans-serif; box-shadow: 0 1px 1px 0 #cacaca; -wekit-box-shadow: 0 1px 1px 0 #cacaca; -moz-box-shadow: 0 1px 1px 0 #cacaca; font-weight:600; }
.per-button, .personalize-blink, .personalize-form-bottom input { border: none; border-radius: 0; box-shadow: none; height: 30px; color: #fff !important; background: #6b6e6e; background: -moz-linear-gradient(top, #6b6e6e 0%, #5b5e5e 100%); background: -webkit-gradient(linear, left top, left bottom, color-stop(0%, #6b6e6e), color-stop(100%, #5b5e5e)); background: -webkit-linear-gradient(top, #6b6e6e 0%, #5b5e5e 100%); background: -o-linear-gradient(top, #6b6e6e 0%, #5b5e5e 100%); background: -ms-linear-gradient(top, #6b6e6e 0%, #5b5e5e 100%); filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#6b6e6e', endColorstr='#5b5e5e', GradientType=0 ); background: linear-gradient(top, #6b6e6e 0%, #5b5e5e 100%); float:left; font-weight: 400; line-height: 30px; text-shadow: 0px 1px 1px #202020; text-transform: uppercase; text-align: center; padding: 0 15px; font-family: proxima-nova, "Helvetica Neue", Arial, Helvetica, Geneva, sans-serif; box-shadow: 0 1px 1px 0 #cacaca; -wekit-box-shadow: 0 1px 1px 0 #cacaca; -moz-box-shadow: 0 1px 1px 0 #cacaca; width:119px; padding:0px; font-weight:600 !important; font-family: proxima-nova, "Helvetica Neue", Arial, Helvetica, Geneva, sans-serif; letter-spacing:1px; }
.per-button:hover, .per-button:active, .per-button.button:active, .personalize-blink:hover, .personalize-blink:active, .personalize-blink:visited, .personalize-form-bottom input:hover, .personalize-form-bottom input:visited, .personalize-form-bottom input:active { background: #5b5e5e; background: -moz-linear-gradient(top, #5b5e5e 0%, #6b6e6e 100%); background: -webkit-gradient(linear, left top, left bottom, color-stop(0%, #5b5e5e), color-stop(100%, #6b6e6e)); background: -webkit-linear-gradient(top, #5b5e5e 0%, #6b6e6e 100%); background: -o-linear-gradient(top, #5b5e5e 0%, #6b6e6e 100%); background: -ms-linear-gradient(top, #5b5e5e 0%, #6b6e6e 100%); filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#5b5e5e', endColorstr='#6b6e6e', GradientType=0 ); background: linear-gradient(top, #5b5e5e 0%, #6b6e6e 100%); top: 0; font-family: proxima-nova, "Helvetica Neue", Arial, Helvetica, Geneva, sans-serif; box-shadow: 0 1px 1px 0 #cacaca; -wekit-box-shadow: 0 1px 1px 0 #cacaca; -moz-box-shadow: 0 1px 1px 0 #cacaca; }
.per-button { font-weight:600 !important; }
.product-shop button.btn-cart { margin-left:7px; margin-right:9px; }
#ba-add-to-cart-button { padding:0 10px; }
/* @end */				

/* @group RELATED PRODUCTS & UPSELLS */
.product-view .baRelatedProducts { display:block; float:left; width:940px; height:auto; clear:both; background:none !important; padding-top:30px; }
.product-view .baRelatedProducts .box-related { display:block; float:left; clear:both; margin:0px; padding:0px; }
.baRelatedProducts .add-to-links { font-size:11px; font-weight:600; display:block; float:left; width:202px; padding-top:9px; margin-bottom:15px; height:18px; }
.baRelatedProducts .add-to-links label { padding:10px 0 0; position:relative !important; }
#related-tabs-title, .box-up-sell .box-title h2 { display:block; float:left; color:#9b9c9b; font-size:22px; font-family: "Crimson Text", Georgia, "Times New Roman", Times, serif; font-weight:400; }
.box-up-sell { display:block; float:left; }
.box-up-sell .box-title h2 { display:block; float:left; clear:both; padding-top:28px; padding-bottom:4px; text-transform:none; margin:0px; position:relative; width:940px; }
.baRelatedProducts .content { padding:0px 3px; width:934px; border-top:0px; display:block; float:left; clear:both; margin:0px; top:0px; }
.baRelatedProducts .order-input { display:block; float:left; height:20px; padding-left:9px; min-width:120px; overflow:shown; }
.baRelatedProducts .order-input .checker { margin:0px; }
.baRelatedProducts .order-input input { display:block; float:left; margin:0px; padding:0px; }
.baRelatedProducts .rel-add-to { color:#EE7B1D; font-weight:600; font-size:11px !important; display:inline-block; float:left; clear:none; min-width:100px; overflow:shown; text-align:left; text-indent:3px; letter-spacing:1px; }
.ie .baRelatedProducts .rel-add-to { letter-spacing:0px; }
.product-view .related-atc { display:block; float:left; width:940px; height:56px; background-color:#fff; border-top:3px solid #EEEDE7; }
.related-atc .add-to-cart { display:block; float:right; clear:none; padding:13px 27px 0 0; }
.baRelatedProducts #related-tabs-title { display:block; float:left; margin-left:2px; height:30px; line-height:20px; }
.baRelatedProducts .related-tabs { display:block; float:right; height:30px !important; min-height:30px !important; max-height:30px !important; }
.box-up-sell .products-grid { margin:0 auto; width:934px; padding:0 3px; background:#fff; display:block; float:left; }
/* @group COMMONS */
.baRelatedProducts .product-details, .box-up-sell .product-details { display:block; float:left; padding:2px 15px 10px !important; width:202px; }
.baRelatedProducts .add-to-cart { display:block; float:left; }
.baRelatedProducts .add-to-cart label { color:#A5A5A5; font-size:11px; line-height:23px; font-weight:600; }
.baRelatedProducts .bottom-price-wrapper, .baRelatedProducts .top-price-wrapper, .box-up-sell .bottom-price-wrapper, .box-up-sell .top-price-wrapper, .baRelatedProducts .price-box, .box-up-sell .price-box { display:block; float:left; clear:none; width:202px !important; padding:0px !important; margin:0px; border:0px; font-size:10px; font-weight:600 !important; letter-spacing:1px; }
.baRelatedProducts .item, .box-up-sell .item { border-left:2px solid #F3F2EB; display:block; float:left !important; width:232px !important; clear:none; padding:0px !important; margin:0px !important; height:auto !important; min-height:354px; }
.baRelatedProducts .item:first-child, .box-up-sell .item:first-child { border-left:0px; }
.baRelatedProducts .product-image, .box-up-sell .product-image { margin:0px; padding:0px; display:block; float:left; width:192px; height:215px; padding: 20px; }
.baRelatedProducts .product-details .price-box, .box-up-sell .product-details .price-box { padding-top:1px; line-height:21px; font-size:11px; font-weight:600; color:#8E8E8E; margin:0px; }
.baRelatedProducts .product-name, .box-up-sell .product-name, .baRelatedProducts .product-name a, .box-up-sell .product-name a { margin:0; padding:0; font-weight:600; line-height:16px; font-size:15px; text-transform:uppercase; color:#202020; letter-spacing:1px; margin: 0px !important; }
.baRelatedProducts .product-name a:hover, .box-up-sell .product-name a:hover { color:#5D87A1; text-decoration:none; }
.baRelatedProducts h4, .box-up-sell h4 { font-weight:400; line-height:16px; font-size:14px; color:#5F6162; letter-spacing:0px; }
.baRelatedProducts h4.subtitle-attr, .box-up-sell h4.subtitle-attr { }
.baRelatedProducts h4.related-sku, .box-up-sell h4.related-sku { line-height:14px; padding-bottom:3px; }
.baRelatedProducts input.qty { display:block; float:left; text-indent:5px; width:45px !important; height:22px !important; line-height:22px !important; box-shadow:none; -webkit-box-shadow:none; -moz-box-shadow:none; background: url(../images/product-view-collateral-qty-bg.png) left top no-repeat !important; padding:0px !important; font-size:10px; border:0px !important; }
.baRelatedProducts input.qty:focus { background-position:left bottom !important; }
.baRelatedProducts .grey-item, .box-up-sell .grey-item { font-size:12px; text-transform:capitalize; color:#8e8e8e; }
.baRelatedProducts .add-to-links label { display:block; float:left; clear:none; padding:0px; letter-spacing:1px; }
.baRelatedProducts .top-price-wrapper, .box-up-sell .top-price-wrapper { font-size:12px; font-weight:normal; color:#8d8d8d; }
.baRelatedProducts .top-price-wrapper .price { font-size:13px; }
.item .item-info .product-image:hover+.product-details .product-name a, .item .item-info .product-image:active+.product-details .product-name a, .item .product-image:hover+.product-details .product-name a, .item .product-image:active:hover+.product-details .product-name a { text-decoration: none; color: #607890; }
/* @end */	
		
/* @group UPDATE CART MESSAGES */
.ba-cart-update-message { position:relative; z-index:500; top:-40px; left:748px; width:176px; padding:8px 8px 8px 30px; background: #8dbd5a url("../images/icon-success-message.png") 10px 8px no-repeat; text-align:center; color:#fff; font-family: proxima-nova, "Helvetica Neue", Arial, Helvetica, Geneva, sans-serif; font-size: 13px !important; height:20px; font-weight:600; text-transform:uppercase; }
.ba-cart-update-message .bottom-arrow { display:block; width:16px; height:8px; z-index:501; position:relative; background: url(../images/product-page-cart-update-arrow.png) left top no-repeat; top:7px !important; left:70px; }
.ba-cart-update-error { position:relative; z-index:500; top:-38px; left:735px; width:185px; padding:8px 8px 8px 30px; background: #E3452A url("../images/icon-error-message.png") 10px 8px no-repeat; text-align:left; color:#fff; font-family: proxima-nova, "Helvetica Neue", Arial, Helvetica, Geneva, sans-serif; font-size: 13px !important; height:19px; text-indent:9px; line-height:19px; font-weight:600; text-transform:uppercase; display:block; }
.ba-cart-update-error .bottom-arrow { display:block; width:16px; height:8px; z-index:501; position:relative; background: url(../images/product-page-cart-error-arrow.png) left top no-repeat; top:7px !important; left:70px; }
.ie7 .ba-cart-update-message, .ie7 .ba-cart-update-error { font-size:12px !important; }
.ie7 .ba-cart-update-message .bottom-arrow, .ie7 .ba-cart-update-error .bottom-arrow { top:9px !important; left:-10px !important; }
.ba-cart-update-wait { position:relative; z-index:1000 !important; top:10px; left:740px; height:32px; width:32px; }
/* @end */	
		
/* @end */

/* @group PERSONALIZER */
.inner-Personalize { padding:30px 20px 16px !important; width:900px !important; display:block; float:left; }
.personalize-header { display:block; float:left; width:900px; position:relative; min-height:57px; }
.personalize-header h2 { display:block; float:left; margin-bottom:32px; letter-spacing:1px; }
.personalize-header p { display:block; float:left; clear:both; width:580px; font-size:13px; line-height:18px; padding-bottom:36px; }
.personalize-blink { display:block; width:70px; position:absolute; z-index:1; left:830px; margin-top:5px; }
.personalize-blink span { padding-left:18px; background: url(../images/back-arrows.png) left center no-repeat; }
.personalize-blink:hover { text-decoration:none !important; }
.personalize-top { display:block; float:left; width:900px; height:180px; position:relative; padding-bottom:24px; }
.personalize-orientation { display:block; float:left; width:293px; height:158px; padding-bottom:22px; margin-right:44px; background: url(../images/orientation-arrow.png) right center no-repeat; }
.personalize-orientation h3 { font-size:15px !important; font-weight:600; color:#202020; line-height:14px; }
#s7_orientation_selector { display:block; float:left; width:293px; padding-top:14px; }
#s7_orientation_selector li { display:block; float:left; width:98px; padding:0 37px 0 0; }
#s7_orientation_selector li input { display:block; float:left; clear:both; margin-right:5px; height:22px; width:21px; }
#s7_orientation_selector li label { display:block; float:left; font-size:13px; color:#5f6162; height:22px; line-height:22px; width:67px; }
.orientation-image-box { display:block; float:left; clear:both; margin-bottom:14px; cursor:pointer; }
.orientation-portrait .orientation-image-box { padding:0 9px; width:80px !important; height:100px !important; }
.orientation-landscape .orientation-image-box { padding:9px 0; height:80px !important; width:100px !important; }
.personalize-side { display:block; float:left; width:560px; }
.personalize-side h3 { font-size:15px !important; font-weight:600; color:#202020; line-height:14px; }
#s7_side_selector { display:block; float:left; width:560px; padding-top:9px; }
.s7_selector { display:block; float:left; width:266px; height:131px; border:2px solid #EEEDE7; cursor:pointer; }
.s7_selector.active { border:2px solid #5b5e5e; }
.s7_selector:nth-child(odd) { margin-right:20px; }
.s7_side_img_box { display:block; float:left; width:126px; height:131px; background:#fff; }
.s7_side_box_right { display:block; float:left; width:120px; height:111px; padding:10px; background:#EEEDE7; }
.s7_side_box_right h4 { font-size:13px; line-height:15px; text-transform:uppercase; }
.s7_side_box_right p { padding-top:4px; line-height:15px; }
.s7_side_box_right span { font-weight:600; text-transform:uppercase; }
.s7_selector.active .s7_side_arrow { display:block; float:left; width:23px; height:11px; background: url(../images/personalize-arrow.png) left top no-repeat; margin-left:122px; margin-top:2px; }
.s7_unfinished { display:block; float:left; width:120px; height:110px; position:relative; }
.personalize-add-marker { display:block; position:absolute; width:20px; height:20px; background: url(../images/personalize-add-marker.png); top:100px; left:109px; }
.s7_finished { display:block; float:left; width:120px; height:110px; position:relative; }
.personalize-check { display:block; position:absolute; width:23px; height:22px; background: url(../images/personalize-done-check.png) left top no-repeat; top:96px; left:105px; }
.personalize-break { display:block; float:left; clear:both; width:940px; height:1px; background: url(../images/personalize-dots.png) left top repeat; position:absolute; left:-20px; top:180px; margin-top:2px; }
.personalize-left { display:block; float:left; width:320px; padding-right:40px; }
#s7_image { display:block; float:left; width:320px; height:352px; padding-bottom:20px; }
.personalize-tips { display:block; float:left; clear:both; top:-14px; position:relative; }
.personalize-tips ul { list-style-type:none; font-size:12px; width:304px; line-height:17px; }
.personalize-tips ul li { background: url("../images/personalize-bullet.png") 1px 6px no-repeat; padding-left:9px; line-height:17px; }
.personalize-tips h3 { color:#292929; text-transform:uppercase; }
.personalize-tips p { font-size: 12px; margin: 0px 0 10px 0; display:block; float:left; clear:both; width:304px; }
.personalize-tips p:last-child { margin-bottom:0px; }
.personalize-form { display:block; float:left; width:540px; }
.personalize-form h3 { text-transform:uppercase; padding-bottom:2px; letter-spacing:1px; }
.personalize-form h3 label { letter-spacing:1px; }
.personalize-form-left { display:block; float:left; width:394px; padding-right:20px; }
.personalize-form-top { display:block; float:left; width:374px; min-height:372px; }
.s7_fieldset_custom, .s7_fieldset_monogram { padding-top:16px; }
.s7_fieldset_message_type { padding-bottom:3px; }
.personalize-form div.selector { width:270px; line-height:23px; height:23px; padding:0px; border-left:1px solid #dfdfdf; text-indent:8px; }
.personalize-form div.selector span { width:270px; padding:0px; line-height:23px; height:23px; }
.personalize-create-own { display:block; float:left; width:374px; }
.personalize-create-own li { display:block; float:left; width:394px; height:24px; line-height:24px; padding-bottom:6px; clear:both; }
.personalize-create-own li label { display:block; float:left; width:40px; line-height:24px; font-size:12px; font-weight:600; letter-spacing:1px; }
.personalize-create-own li input { display:block; float:left; width:229px; height:24px; background: url(../images/s7-custom-bg.png) left top no-repeat; box-shadow:none; -moz-box-shadow:none; -webkit-box-shadow:none; text-indent:8px; padding:0px; line-height:24px; }
.personalize-create-own li span { font-size:11px; display:inline-block; text-indent:8px; font-weight:600; line-height:24px; width:125px; letter-spacing:1px; }
.personalize-create-own li span strong { font-weight:600; font-size:11px; line-height:24px; }
.personalize-mono { display:block; float:left; width:374px; }
.personalize-mono li { display:block; float:left; width:374px; height:24px; line-height:24px; padding-bottom:6px; clear:both; }
.personalize-mono li label { display:block; float:left; width:130px; line-height:24px; font-size:12px; font-weight:600; letter-spacing:1px; }
.personalize-mono li input { display:block; float:left; height:24px; line-height:24px; font-size:12px; font-weight:normal; width:51px; padding:0px; border:0px; box-shadow:none; -webkit-box-shadow:none; -moz-box-shadow:none; background: url(../images/s7-intials-bg.png) left top no-repeat; text-indent:8px; }
.personalize-form-bottom { display:block; float:left; width:374px; }
.personalize-preview { width:144px !important; margin-right:10px; }
.personalize-clear { width:75px !important; margin-right:10px; }
.personalize-next, .personalize-previous { width:125px !important; background-color: #8eb2c0 !important; background-image: -webkit-gradient(linear, left top, left bottom, from(rgb(142, 178, 192)), to(rgb(131, 166, 180))) !important; background-image: -webkit-linear-gradient(top, rgb(142, 178, 192), rgb(131, 166, 180)) !important; background-image: -moz-linear-gradient(top, rgb(142, 178, 192), rgb(131, 166, 180)) !important; background-image: -o-linear-gradient(top, rgb(142, 178, 192), rgb(131, 166, 180)) !important; background-image: -ms-linear-gradient(top, rgb(142, 178, 192), rgb(131, 166, 180)) !important; background-image: linear-gradient(top, rgb(142, 178, 192), rgb(131, 166, 180)) !important; filter: progid:DXImageTransform.Microsoft.gradient(startColorStr='#8eb2c0', EndColorStr='#83a6b4') !important;
}
.personalize-next:hover, personalize-previous:hover { background-color: #83a6b4 !important; background-image: -webkit-gradient(linear, left top, left bottom, from(rgb(131, 166, 180)), to(rgb(142, 178, 192))) !important; background-image: -webkit-linear-gradient(top, rgb(131, 166, 180), rgb(142, 178, 192)) !important; background-image: -moz-linear-gradient(top, rgb(131, 166, 180), rgb(142, 178, 192)) !important; background-image: -o-linear-gradient(top, rgb(131, 166, 180), rgb(142, 178, 192)) !important; background-image: -ms-linear-gradient(top, rgb(131, 166, 180), rgb(142, 178, 192)) !important; background-image: linear-gradient(top, rgb(131, 166, 180), rgb(142, 178, 192)) !important; filter: progid:DXImageTransform.Microsoft.gradient(startColorStr='#83a6b4', EndColorStr='#8eb2c0') !important;
}
.personalize-pricing { display:block; float:left; width:122px; border:2px solid #eeede7; min-height:396px; }
.personalize-pricing li { border-bottom:2px solid #eeede7; text-align:right; padding:25px 11px 30px 0; line-height:18px; letter-spacing:1px; }
.pItem-Cost { display:block; float:left; clear:both; width:111px; min-height:31px; }
.pItem-Eng { display:block; float:left; clear:both; width:111px; min-height:73px; }
.pItem-Cost span, .pItem-Eng span { font-weight:600; }
.pItem-Total { border-bottom:0px !important; padding-bottom:4px !important; font-size:18px; line-height:25px !important; font-weight:600; display:block; float:left; width:111px; min-height:132px; }
#s7_add_to_cart { width:114px; margin:72px 0 0 4px; padding:0; }
.personalize-form h2 { font-size:15px; letter-spacing:1px; }
.personalize-form h3, .personalize-tips strong, .personalize-tips h3 { letter-spacing:1px; }
/* @end */		
/* @end */	
/* @group NEWSLETTER FORM */
.form-subscribe { display:block; float:left; }
.email-input-box { display:block; float:left; clear:none; width:178px; }
.email-input-box input { padding:0px; width:178px !important; height:24px !important; line-height:24px !important; text-indent:9px; font-size:11px; background: url(../images/footer-newsletter-bg.png) left top no-repeat; }
.email-input-box input.validation-failed { background: url(../images/footer-newsletter-bg.png) left bottom no-repeat !important; border:0px; box-shadow:none !important; -moz-box-shadow:none !important; -webkit-box-shadow:none !important; border:0px !important; }
.form-subscribe .button { display:block; float:left !important; }
/* @end */

/* @group SEARCH */
#search { border:0px !important; box-shadow:none; -moz-box-shadow:none; -webkit-box-shadow:none; line-height:25px; padding:0px; text-indent:10px; font-size:11px; }
.footer-search { display:block; width:auto; float:right; }
.footer-search-box { display:block; float:left; width:164px; height:25px; }
.footer-search-box .input-text { display:block; float:left; padding:0px; width:164px; height:25px; line-height:25px; margin:0px; font-size:11px; font-family: proxima-nova, "Helvetica Neue", Arial, Helvetica, Geneva, sans-serif; color:#a0a0a0 !important; text-indent:9px; border:0px !important; background: url(../images/search-bg.png) left top no-repeat; box-shadow:none !important; -webkit-box-shadow:none !important; -moz-box-shadow:none !important; }
.footer-search .button { display:block; float:left; width:25px !important; height:25px; background: url(../images/btn-search.png) left top no-repeat !important; filter:none !important; padding:0px !important; top:0px !important; border:0px !important; box-shadow:none !important; -webkit-box-shadow:none !important; -moz-box-shadow:none !important; }
.dealeraccess { margin-right:0px; margin-top:36px; }
/* @end */		

/* @group INPUT FIELD FIXES */
.category-view .grid-qty-input { padding:0px; text-indent:9px; margin:0px; text-align:left; font-size:12px; height:22px; width:45px; box-shadow:none; -webkit-box-shadow:none; -moz-box-shadow:none; border:0px; background: url(../images/category-view-qty.png) left top no-repeat; border:0px; line-height:22px; margin:0 0 0 4px !important; }
.category-view .grid-qty-input.validation-failed { background: url(../images/category-view-qty.png) left bottom no-repeat; box-shadow:none; -webkit-box-shadow:none; -moz-box-shadow:none; border:0px; }
.cart-table .input-text.qty { padding:0px !important; margin-top:-4px !important; box-shadow:none; -webkit-box-shadow:none; -moz-box-shadow:none; background: url(../images/cart-qty-input.png) left top no-repeat !important; width:51px !important; height:24px; line-height:24px; text-align:center !important; border:0px !Important; text-indent:0px !important; line-height:26px; border-radius:0px; -moz-border-radius:0px; -webkit-border-radius:0px; }
.cart-table .input-text.qty.validation { background: url(../images/cart-qty-input.png) left bottom no-repeat; box-shadow:none; -webkit-box-shadow:none; -moz-box-shadow:none; border:0px; }
.shipping-form .form-list input.input-text { width:277px; padding:0px; line-height:25px; height:25px; box-shadow:none; -webkit-box-shadow:none; -moz-box-shadow:none; background: url(../images/cart-long-input-3.png) left top no-repeat; border:0px !important; text-indent:8px; }
.cart .discount input.input-text { width:250px !important; padding:0px; line-height:25px; height:25px; box-shadow:none; -webkit-box-shadow:none; -moz-box-shadow:none; background: url(../images/cart-long-input-4.png) left top no-repeat !important; border:0px !important; text-indent:8px; border-radius:0px; -webkit-border-radius:0px; -moz-border-radius:0px; }
.shipping-form .form-list input.input-text.validation-failed { box-shadow:none !important; -webkit-box-shadow:none !important; -moz-box-shadow:none !important; background: url(../images/cart-long-input.png) left bottom no-repeat !important; ; border:0px !important; }
.cart .discount input.input-text.validation-failed { box-shadow:none !important; -webkit-box-shadow:none !important; -moz-box-shadow:none !important; background: url(../images/cart-long-input2.png) left bottom no-repeat !important; ; border:0px !important; }
.opc-wrapper input[type="date"], .opc-wrapper input[type="datetime"], .opc-wrapper input[type="datetime-local"], .opc-wrapper input[type="email"], .opc-wrapper input[type="month"], .opc-wrapper input[type="number"], .opc-wrapper input[type="password"], .opc-wrapper input[type="search"], .opc-wrapper input[type="tel"], .opc-wrapper input[type="text"], .opc-wrapper input[type="time"], .opc-wrapper input[type="url"], .opc-wrapper input[type="week"], input.qty, .opc-wrapper input.input-text, .account-login input.input-text, .account-create input.input-text, .my-account input.input-text { box-shadow:none !important; -webkit-box-shadow:none !important; -moz-box-shadow:none !important; padding:0px; text-indent:8px; height:24px; line-height:24px; background: url(../images/input-long.png) left top no-repeat; border-right:1px solid #e0e0e0 !important; }
.opc-wrapper input[type="date"].validation-failed, .opc-wrapper input[type="datetime"].validation-failed, .opc-wrapper input[type="datetime-local"].validation-failed, .opc-wrapper input[type="email"].validation-failed, .opc-wrapper input[type="month"].validation-failed, .opc-wrapper input[type="number"].validation-failed, .opc-wrapper input[type="password"].validation-failed, .opc-wrapper input[type="search"].validation-failed, .opc-wrapper input[type="tel"].validation-failed, .opc-wrapper input[type="text"].validation-failed, .opc-wrapper input[type="time"].validation-failed, .opc-wrapper input[type="url"].validation-failed, .opc-wrapper input[type="week"].validation-failed, input.qty.validation-failed, .opc-wrapper input.input-text.validation-failed, .account-login input.input-text.validation-failed, .account-create input.input-text.validation-failed, .my-account input.input-text.validation-failed { background: url(../images/input-long.png) left bottom no-repeat !important; box-shadow:none !important; -moz-box-shadow:none !important; -webkit-box-shadow:none !important; border:0px !Important; border-right:1px solid #f3cdc7 !important; }
.opc-wrapper select:focus, .opc-wrapper select:active, .opc-wrapper select, .opc-wrapper select.validation-failed { display:block !important; float:left !important; width:250px; height:25px; box-shadow:none !important; -webkit-box-shadow:none !important; -moz-box-shadow:none !important; background-image: url(../images/checkout-select.png); line-height:25px !important; background-position:left top !important; text-indent:9px !important; }
.opc-wrapper select.validation-failed { background-position:left bottom !important; }
.is_webkit .opc-wrapper select:focus, .is_webkit .opc-wrapper select:active, .is_webkit .opc-wrapper select, .is_webkit .opc-wrapper select.validation-failed { display:block !important; float:left !important; width:250px; height:25px; box-shadow:none !important; -webkit-box-shadow:none !important; -moz-box-shadow:none !important; background-image: url(../images/webkit-checkout-select.png); line-height:25px !important; background-position:left top !important; text-indent:9px !important; padding: 0 30px 0 0; }
.is_webkit .opc-wrapper select.validation-failed { background-position:left bottom !important; }
.is_webkit .year { margin-top: 10px; }
/* @end */	

/* @group SELECTION FIXES */
::-moz-selection { background: #202020 !important; color:#fff !important; text-shadow: none !important; -webkit-text-shadow: none !important; -moz-text-shadow: none !important; }
::selection { background: #202020 !important; color:#fff !important; text-shadow: none !important; -webkit-text-shadow: none !important; -moz-text-shadow: none !important; }
/* @end */	

/* @group CATEGORY PAGE FIXES */
.category-products .compare-label { line-height:18px; font-weight:700 !important; }
.category-products .add-to-links { display:block; float:left; height:18px; width:202px; }
#narrow-by-list ol li { padding-bottom:6px; }
#narrow-by-list ol li a, #narrow-by-list ol li { font-size:12px !important; font-weight:600 !important; line-height:17px !important; }
.category-products .bottom-price-wrapper { font-size:10px; font-weight:600; letter-spacing:0.5px; }
.category-products .top-price-wrapper { font-size:11px; line-height:24px; }
.category-products .top-price-wrapper .price { font-size:13px; }
.category-products .item .out-of-stock { font-weight:600 !important; }
.ie .category-products .products-grid { top:0px; }
/* @end */

/* @group FOOTER FIXES */
footer section h3, footer section ul li, footer section ul li a, footer section li a:hover, .form-subscribe label { font-size:13px; font-weight:600; }
footer seciont ul li a { font-weight: 600; }
.copyright span, .copyright, .copyright a, .copyright a:hover, .copyright a:active, .copyright a:visited { font-size:10px; font-weight:600; letter-spacing:1px; }
/* @end */

/* @group QUICK ACCESS FIXES */
.quick-access ul.links > li > a, .quick-access ul.links li.first a { line-height:30px; }
.quick-access ul.links > li > a { font-weight: 600; }
.quick-access ul.links > li.last a { display:block; float:left; background-color: #eb872b; background: url('../images/btn-utility-checkout.png') no-repeat 0 0; width:70px; height:21px; margin-right:5px; box-shadow: 0 1px 1px 0 #555757; -wekit-box-shadow: 0 1px 1px 0 #555757; -moz-box-shadow: 0 1px 1px 0 #555757; padding:0px; text-indent: -99999px; }
.quick-access ul.links > li.last a:hover, .quick-access ul.links > li.last a:active { background: url('../images/btn-utility-checkout.png') no-repeat 0 -21px; }
/* @end */

/* @group TABS FIX */
#tabs li a, #tabsRel li a { font-size:11px; letter-spacing:1px; font-weight:600; }
#tabsRel, .categoryTabs #tabs { display:block; float:right; width:auto; }
#tabsRel li, .categoryTabs #tabs li { display:block; float:left; margin-left:1px; }
#tabsRel li.active, .categoryTabs #tabs li.active { border-right:1px solid #cfcfcf; }
#tabsRel li:last-child, .catalog-product-view #tabs li:last-child, .categoryTabs #tabs li:last-child, .review-product-list #tabs li:last-child { border:0px !important; }
/* @end */

/* @group BUTTON FIXES */
button.button.btn-cart, #s7_add_to_cart { text-shadow: -1px 1px 2px #d26810; -moz-text-shadow: -1px 1px 2px #d26810; -webkit-text-shadow: -1px 1px 1px #d26810; }
.personalize-next, .personalize-previous { text-shadow: -1px 1px 2px #394b59 !important; -moz-text-shadow: -1px 1px 2px #394b59 !important; -webkit-text-shadow: -1px 1px 1px #394b59 !important; }
/* @end */

/* @group MENU FIXES */
#nav li.parent { margin:0px !important; display:block; float:left !important; }
#nav li.parent>a { letter-spacing:1px; padding:0px !important; margin:0 8px 0 8px; font-weight:normal; font-weight:600; font-size:12px !important; *letter-spacing:0px; }
.ie7 #nav li.parent>a, .ie8 #nav li.parent>a, .ie #nav li.parent>a, .ie9 #nav li.parent>a { letter-spacing:0px; }
#nav li.parent:first-child>a { margin-left:0px; }
#nav li.parent.nav-6>a { margin-right:0px; margin-left:8px; }
#nav li.parent.nav-7 { display:block; float:right !important; }
#nav li.parent.nav-7>a { margin-right:0px !important; margin-left:8px; }
#nav li.parent.nav-8 { display:block; float:right !important; }
#nav li.parent.nav-8>a { margin-left:0px; }
/* @end */

/* @group OPC FIXES */
.opc .step { display:block; float:left; }
.opc .step .input-box { display:block; float:left; width:auto; }
.checkout-onepage-index p.required { display:block; float:left; clear:both; padding-bottom:10px; }
.checkout-onepage-index .control p.required { display:block; float:left; clear:both; padding-top:10px; padding-bottom: 0; }
p.required, label.required em { color:#e3452a !important; font-family: proxima-nova, "Helvetica Neue", Arial, Helvetica, Geneva, sans-serif !important; }
/* @end */

/* @group ADD TO COMPARE MODAL */
.magento_n, .magento_ne, .magento_e, .magento_se, .magento_s, .magento_sw, .magento_w, .magento_nw, .know_n, .know_ne, .know_e, .know_se, .know_s, .know_sw, .know_w, .know_nw { display:none; }
.dialog { border:0px; }
.dialog .magento_content, .dialog .know_content { background: #fff; padding:30px 20px 35px; }
.dialog thead td, .dialog tbody td, .dialog tfoot td, .dialog tbody th { border:0px; vertical-align:top; }
.dialog .data-table { border-top:2px solid #EEEDE7; width:auto !important; display:block; float:left; clear:none; }
.dialog tbody td, .dialog tbody th { border-right:2px solid #F3F2EB; border-bottom:2px solid #F3F2EB; }
.dialog tbody td.last { border-rightp:2px solid #EEEDE7; }
.dialog tbody th { padding:10px 8px 10px 8px !important; font-size:12px; font-family: proxima-nova, "Helvetica Neue", Arial, Helvetica, Geneva, sans-serif; font-weight:600 !important; background:#f3f2eb !important; }
.dialog .product-image { display:block; float:left; clear:both; padding: 20px; }
.dialog .product-info { display:block; float:left; clear:both; padding:6px 6px 6px 6px; }
.dialog .total-4 .product-info { padding:4px 15px 10px; width:172px; }
.dialog .total-5 .product-info { padding:4px 10px 10px; width:140px; }
.dialog .low .product-info { padding:4px 15px 10px; width:202px; }
.dialog h3.product-name { font-size:14px; font-weight:600; text-transform:uppercase; padding-bottom:2px; display:block; float:left; }
.dialog h3.product-name a, .dialog h3.product-name a:active, .dialog h3.product-name a:visited { color:#202020; }
.dialog h3.product-name a:hover, .dialog .product-image:hover + .product-info h3.product-name a { color:#607890; text-decoration:none; }
.dialog h5 { display:block; clear:both; font-size:12px; text-transform:capitalize; color:#8e8e8e; font-weight:400; }
.dialog h4.set-config { font-size:13px; font-weight:400; padding-bottom:6px; display:block; float:left; clear:both; }
.dialog .top-price-wrapper { font-size:11px; font-weight:400; display:block; float:left; clear:both !important; }
.dialog .top-price-wrapper .price { font-size:12px; font-weight:600; }
.dialog .bottom-price-wrapper { display:block; float:left; font-size:10px; line-height:14px; font-weight:600; color:#A5A5A5; height:auto; padding:4px 0; clear:both; }
.dialog .bottom-price-wrapper span { display:block; float:left; clear:both; }
.dialog .low .bottom-price-wrapper span { clear:none; }
.dialog .bottom-price-wrapper span.price-sep { display:none; }
.dialog .low .bottom-price-wrapper span.price-sep { display:block; }
.dialog .grid-qty-cont { margin-top:8px; }
.dialog .btn-cart { margin-top:8px; border: none; border-radius: 0; box-shadow: 0 1px 1px 0 #cacaca; -wekit-box-shadow: 0 1px 1px 0 #cacaca; -moz-box-shadow: 0 1px 1px 0 #cacaca; height: 22px; line-height:22px; color: #fff !important; background: #ee891d; background: -moz-linear-gradient(top, #ee891d 0%, #ee7a1d 100%); background: -webkit-gradient(linear, left top, left bottom, color-stop(0%, #ee891d), color-stop(100%, #ee7a1d)); background: -webkit-linear-gradient(top, #ee891d 0%, #ee7a1d 100%); background: -o-linear-gradient(top, #ee891d 0%, #ee7a1d 100%); background: -ms-linear-gradient(top, #ee891d 0%, #ee7a1d 100%); filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#ee891d', endColorstr='#ee7a1d', GradientType=0 );
background: linear-gradient(top, #ee891d 0%, #ee7a1d 100%); float:left; font-weight: 400; line-height: 22px; text-shadow: 0px 1px 1px #bb5606; text-transform: uppercase; text-align: center; padding: 0; font-family: proxima-nova, "Helvetica Neue", Arial, Helvetica, Geneva, sans-serif; font-size: 11px !important; width: 85px; }
.dialog tr.even { background:none; }
.dialog td.comp-attr { padding:6px !important; font-size:12px; line-height:18px; }
.dialog .total-4 td.comp-attr { padding:4px 15px 10px !important; }
.dialog .total-5 td.comp-attr { padding:4px 10px 10px !important; }
.dialog .low td.comp-attr { padding:4px 15px 10px !important; }
.dialog td.data { padding:6px !important; }
.dialog p.out-of-stock { display:block; float:left; padding-top:8px !important; }
.dialog p.out-of-stock span { font-size:12px; }
.dialog .price-box { display:block; float:left; clear:both; }
.dialog .comp-remove { padding:6px !important; line-height:28px; background: #F3F2EB; }
.dialog .total-4 .comp-remove { padding:4px 15px 4px !important; }
.dialog .total-5 .comp-remove { padding:4px 10px 4px !important; }
.dialog .low .comp-remove { padding:4px 15px 4px !important; }
.dialog .data-table tbody td { max-width:232px !important; }
.dialog h1 { margin-bottom:34px; }
.dialog .buttons-set { display:block; float:right; clear:none; margin-top:0px !important; }
.dialog .please-wait { display:block; float:left; color:#5D87A1; line-height:34px; }
.dialog .add-to-box { display:block; float:left; clear:both; }
.dialog div.know_content { padding:30px 40px 35px; background:#fff; }
.know_content h2 { font-size:25px; height:25px; padding-top:14px; padding-bottom:4px; margin-bottom:0px; }
.know_content h3 { font-size:15px; text-transform:uppercase; height:15px; padding-bottom:10px; color:#202020; }
.know_content p { padding-bottom:16px; font-size:14px; line-height:20px; }
.know_content p.last { padding-bottom:0px; }
.know_content p strong { color:#202020; }
.know_content a { font-weight:bold; }
.know_content a:hover { text-decoration:none; }
.know-close-button { position:absolute; left:581px; top:16px; zindex:100100; width:100px; text-align:right; }
.dialog { border:0px !important; }
/* @end */

/* @group CMS PAGE VIEW */
.cms-page-view .main-container, .contacts-index-index .main-container, .cms-no-route .main-container { background:#f3f2eb; }
.cms-page-view .std, .contacts-index-index .std, .cms-no-route .std { float:left; display:block; background:#fff; padding:29px 20px 35px 20px; width:auto; height:auto; margin-top:14px; margin-bottom:41px !important; clear:both; width:900px; }
.cms-no-route .std { width:900px; }
.cms-page-view .std h1, .contacts-index-index .std h1, .cms-no-route .std h1 { font-size:40px; text-transform:uppercase; line-height:40px; margin-bottom:29px; width:100%; clear:both; }
.cms-page-view .std h2, .contacts-index-index .std h2, .cms-no-route .std h2 { font-size:20px; color:#202020; margin-top:37px; display:block; float:left; clear:both; width:100%; }
.cms-page-view .std h3, .contacts-index-index .std h3, .cms-no-route .std h3 { font-size:15px; text-transform:uppercase; color:#202020; display:block; float:left; clear:both; margin-bottom:14px; width:100%; }
.cms-page-view .std p, .contacts-index-index .std p, .cms-no-route .std p { font-size:13px; color:#4f4f4f; line-height:18px; margin-bottom:15px; display:block; float:left; clear:both; width:100%; }
.cms-page-view .std ol, .contacts-index-index .std ol, .cms-no-route .std ul { display:block; float:left; clear:both; margin-bottom:15px; width:100%; }
.cms-no-route .std ul { margin-bottom:0px; }
.cms-page-view .std ol li, .contacts-index-index .std ol li, .cms-no-route .std ul li { clear:both !important; width:800px; text-align:left; float:left; padding-left:20px; position:relative; padding-bottom:6px; }
.cms-page-view .std ol li ol { padding-top:15px; }
.cms-page-view .std ol li ol li { padding-left:30px; }
.cms-page-view .std ol li p, .contacts-index-index .std ol li p, .cms-no-route .std ul li p { display:block; clear:both; float:left; }
.cms-page-view .std ol li p:last-child, .contacts-index-index .std ol li p:last-child, .cms-no-route ul li:last-child p { padding-bottom:0px; margin-bottom:0px; }
.cms-page-view .std ol li span:first-child, .contacts-index-index .std ol li span:first-child { left:0px; display:block; position:absolute; color:#202020; }
.cms-page-view .std table { clear:both; margin-left:25px; margin-bottom:8px; }
.cms-page-view .std table td { padding:0 10px; line-height:18px; }
.cms-page-view .std small:last-child { clear:both; display:inline-block; float:left; font-size:8px; }
/* @end */

/* @group STORE LOCATOR */
.ustorelocator-location-map .main-container { padding-top:34px; }
.ustorelocator-location-map .main-container h1 { margin-bottom:33px; }
#sidebar a { cursor:pointer; margin-bottom:5px; background-color:#fff; display:block; }
#sidebar a:hover { background-color:#eee; }
#storelocator-container { width:610px; font-family:Arial, sans-serif; font-size:11px; border:1px solid black; background:white; }
#sidebar { overflow: auto; height: 380px; padding:10px; font-size: 11px; color: #000; background:#eeede7; }
#map { overflow: hidden; width:410px; height:400px; }
.ustorelocator-location-map #storelocator-results { margin-top:18px; }
#sidebar a { display:block; float:left; width:225px; }
#sidebar a:hover { text-decoration:none; }
.sidebar-address { display:block; float:left; }
.sidebar-address h3 { display:block; float:left; clear:both; width:195px; font-family: proxima-nova, "Helvetica Neue", Arial, Helvetica, Geneva, sans-serif; color:#202020; padding-bottom:6px; font-size:15px; line-height:17px; }
.sidebar-address p { display:block; float:left; clear:both; width:195px; font-size:13px; font-family: proxima-nova, "Helvetica Neue", Arial, Helvetica, Geneva, sans-serif; line-height:16px; color:#4f4f4f; }
.map-store-title { clear:both; font-family: proxima-nova, "Helvetica Neue", Arial, Helvetica, Geneva, sans-serif; color:#202020; padding-bottom:6px; font-size:15px; line-height:17px; padding-right:12px; }
.map-popup p { font-family: proxima-nova, "Helvetica Neue", Arial, Helvetica, Geneva, sans-serif; font-size:13px; line-height:17px; color:#4f4f4f; }
.map-popup h5 { padding-bottom:8px; font-family: proxima-nova, "Helvetica Neue", Arial, Helvetica, Geneva, sans-serif; color:#4f4f4f; font-weight:600; font-size:13px; line-height:17px; }
#store_locator_form li label { margin:0 13px 0 0; }
a.active { background-color:#e0dfda !important; }
.ustorelocator-location-map .group-select .input-text { box-shadow:none !important; -webkit-box-shadow:none !important; -moz-box-shadow:none !important; padding:0px; text-indent:8px; height:24px; line-height:24px; background: url(../images/input-long.png) left top no-repeat; border-right:1px solid #e0e0e0 !important; }
.ustorelocator-location-map .group-select .input-text.validation-failed { background: url(../images/input-long.png) left bottom no-repeat !important; box-shadow:none !important; -moz-box-shadow:none !important; -webkit-box-shadow:none !important; border:0px !Important; border-right:1px solid #f3cdc7 !important; }
/* @end */

/* @group REVIEW FORM */
.box-reviews { display:block; float:left; clear:both; width:900px; float:right; padding:35px 20px; background:#fff; }
.box-reviews h2 { display:block; float:left; clear:both; margin-top:14px; }
.box-reviews h3 { font-size:20px; color:#4f4f4f; font-weight:400; line-height:20px; padding-bottom:22px; display:block; float:left; clear:both; }
.box-reviews .box-content { display:block; float:left; clear:both; width:900px; }
.box-reviews h3 .name-line-one, .product-review h3 .name-line-one { font-size:18px; text-transform:uppercase; display:block; clear:both; color:#202020; padding:4px 0; font-weight:600; }
.box-reviews h3 .name-line-two, .product-review h3 .name-line-two { font-size:18px; text-transfrom:none; display:block; clear:both; color:#5f6162; font-weight:400; }
.review-summary-table .value { text-align:center; }
.review-summary-table th { background: #fff; border-color:#f3f2eb; padding:5px 8px; font-size:12px; color:#000; font-wieght:600; text-align:left; line-height:20px; }
.review-summary-table tr.even td { background:#FFF; }
.review-summary-table td.label, .review-summary-table tr.even td.label { background:#F3F2EB; border-color:#F3F2EB; font-size:12px; font-weight:600; color:#000; text-align:left; vertical-align:middle; min-height:20px; padding:5px; }
.review-summary-table td { border-color:#F3F2EB; }
.box-reviews .form-list li { display:block; float:left; clear:both; margin:0px; padding-bottom:25px; }
.box-reviews .form-list li.wide-review { width:100%; }
.box-reviews p.required { display:block; float:left; clear:both; }
.review-form-table { display:block; float:left; }
.review-form-table h4 { display:block; float:left; clear:both; }
.review-form-table .input-box { display:block; float:left; clear:both; }
.ratings-table, dl.box-content dd .review-summary-table { border:1px solid #F3F2EB; }
.ratings-table th, dl.box-content dd .review-summary-table th { background:#F3F2EB; padding:5px; line-height:20px; min-height:20px; font-size:12px; color:#000; font-weight:600; border-bottom:1px solid #F3F2EB; vertical-align:middle; }
.ratings-table td, dl.box-content dd .review-summary-table td { border-bottom:1px solid #F3F2EB; padding:5px; }
.ratings-table tr.last td, .ratings-table tr.last th, dl.box-content dd .review-summary-table tr.last th, dl.box-content dd .review-summary-table tr.last td { border-bottom:0px; }
.box-reviews .form-list label { display:block; float:left; margin-right:0px; min-width:200px; }
.box-reviews .pager { display:block; float:left; clear:both; width:880px; left:0px; height:20px; background:#a0a0a0; padding:10px; text-align:center; }
.box-reviews .pager .amount { color:#fff; font-size:11px; text-transform:uppercase; line-height:20px; font-weight:600; }
.box-reviews .pager .limiter { display:block; float:right; width:158px; text-align:left; clear:none; }
.box-reviews .pager .limiter .input-box { display:block; float:left; top:-4px; position:relative; }
.box-reviews .pager .limiter select { width:60px; clear:none; }
.box-reviews .pager .limiter .selector, .box-reviews .pager .limiter .selector.hover { width:60px; background-position: -486px -154px; clear:none; }
.box-reviews .pager .limiter .selector span, .box-reviews .pager .limiter .selector.hover span { width:30px; }
.box-reviews .limiter label, .box-reviews .limiter p { color:#fff; font-size:11px; text-transform:uppercase; line-height:20px; font-weight:600; padding-right:6px; }
.box-reviews .limiter p { padding:0px; display:inline-block; }
.box-reviews .pager .pages { display:inline-block; }
.box-reviews .pager .pages span { color:#fff; font-size:11px; text-transform:uppercase; font-weight:600; }
.box-reviews dl { display:block; float:left; clear:both; padding:0; }
.box-reviews dl dt { display:block; float:left; clear:both; padding-bottom:8px; padding-top:15px; }
.box-reviews dl dt a, .box-reviews dl dt a:active, .box-reviews dl dt a:visited { display:inline-block; float:left; font-size:15px; font-weight:600; text-transform:uppercase; padding-bottom:8px; color:#202020; width:auto; padding-right:5px; }
.box-reviews dl dt a:hover { text-decoration:none; }
.box-reviews p.date { display:inline-block; float:left; clear:none; }
.box-reviews dl dd { display:block; float:left; clear:both; padding-bottom:15px; background: url(../images/rb_dot.png) left bottom repeat-x; width:100%; }
.box-reviews dl dt { width:100%; }
.box-reviews dl dd.last { background:none; }
.box-reviews dl table.data-table { width:auto; margin-bottom:22px; }
.box-reviews dl dd p { display:block; float:left; clear:both; padding-bottom:16px; }
.box-reviews dl dd p:last-child { padding-bottom:0px; }
.review-list-item { display:block; float:left; clear:none; width:100%; padding-bottom:18px; }
.review-list-item li { display:block; float:left; clear:none; padding-right:25px; }
#rating-selectors { display:block; float:left; clear:none; width:900px; padding-bottom:18px; }
#rating-selectors li { display:block; float:left; clear:none; padding-right:25px; padding-bottom:0px; }
#rating-selectors li label { width:auto !important; min-width:100px !important; }
#product-reviews-list { display:block; float:left; clear:both; width:900px; }
#review-form .input-text, #review_field { width:318px; padding: 2px 3px 2px 3px; }
#review-form .input-text:focus { background:#fff; }
#review-form .buttons-set { width: 504px; }
#review-form .buttons-set button.button { float: right; }
.box-reviews h1 { font-size:40px; text-transform:uppercase; line-height:40px; margin-bottom:29px; float:left; }
.box-reviews p.back-link { clear:none; float:right; }
.mini-stars { display:block; float:left; width:69px; height:10px; text-indent:-9999px; background: url(../images/review-mini-stars.png) left top no-repeat; }
.mini-star-2 { background-position:left -10px; }
.mini-star-3 { background-position:left -20px; }
.mini-star-4 { background-position:left -30px; }
.mini-star-5 { background-position:left -40px; }
.review-buttons-set { display:block; float:right; width:518px; }
.review-count-link { display:block; float:left; padding-bottom:15px; }
.product-review { width:860px; padding:29px 20px 35px; background:#fff; }
.product-review .product-img-box { display:block; float:left; clear:none; }
.product-review .details { display:block; float:left; width:720px; }
.product-review .details p { padding-bottom:14px; }
.product-review .review-buttons-set { float:right; width:auto; }
.product-review .review-buttons-set p { margin-right:0px; }
/* @group RATING STARS */
.rating-cancel, .star-rating { display:block; float:left; width:16px; height:14px; text-indent:-9999px; cursor:pointer; background: transparent; overflow:hidden; }
.star-rating, .star-rating a { background: url(../images/review-stars.png) no-repeat 0 0px; margin-right:2px !important; height:14px !important; }
.rating-cancel, .rating-cancel a { background: url(../images/stars/delete.gif) no-repeat 0 -14px; display:none !important; }
.star-rating a { display:block; width:16px; height:100%; background-position:0 0px; border:0px; }
.star-rating-on a { background-position:0 -14px !important; }
.star-rating-hover a { background-position:0 -14px; }
.star-rating-readonly a { cursor:default !important; }
.star-rating { background:transparent !important; overflow:hidden !important; }
/* @end */

/* @end */

/* @group CARE AND USE */
.inner-contentlinks { padding:29px 20px 22px !important; }
.inner-contentlinks ul { display:block; float:left; padding-top:15px; }
/* @end */

/* @group MISC FIXES */
textarea { padding-left:8px; line-height:20px; }
textarea:focus { outline:0; box-shadow:none; -webkit-box-shadow:none; -moz-box-shadow:none; border:none; background:none; box-shadow: inset 0px 1px 1px #858585; -moz-box-shadow: inset 0px 1px 1px #858585; -webkit-box-shadow: inset 0px 1px 1px #858585; }
.overlay_magento { cursor:pointer !important; }
.product-options { display:none !important; }
/* @end */

/* @group LAYERED NAV PERSONALIZABLE FIX */
#narrow-by-list #personalize li div ol li a { height:16px !important; display:block; line-height:16px !important; font-size:13px !important; font-weight:bold !important; letter-spacing:1px; color:#5B5E5E; font-size:12px !important; font-weight:600 !important; line-height:17px !important; text-transform: none; letter-spacing: 0px; }
#narrow-by-list #personalize li div ol li a:hover, #narrow-by-list #personalize li div ol li a:active { text-decoration:none; }
.personalizer-attribute .jspContainer { height: 24px !important; width:175px !important; }
.personalizer-attribute .jspPane { width:175px !important; }
.personalizer-attribute .attr-val-featured { width:150px !important; }
.personalizer-attribute .attr-val-featured a { width:150px !important; }
.personalizer-attribute ol { width:190px !important; }
/* HIDE FROM CRYSTAL CATEGORY & SUBCATEGORIES*/
.categorypath-crystal #personalize, .categorypath-crystal .personalizer-attribute, .categorypath-crystal-crystal-stemware #personalize, .categorypath-crystal-crystal-stemware .personalizer-attribute, .categorypath-crystal-crystal-barware-accessories #personalize, .categorypath-crystal-crystal-barware-accessories .personalizer-attribute, .categorypath-crystal-crystal-bowls-vases #personalize, .categorypath-crystal-crystal-bowls-vases .personalizer-attribute, .categorypath-crystal-crystal-candlesticks-votives #personalize, .categorypath-crystal-crystal-candlesticks-votives .personalizer-attribute, .categorypath-crystal-crystal-serveware-accessories #personalize, .categorypath-crystal-crystal-serveware-accessories .personalizer-attribute, .categorypath-crystal-crystal-specialties #personalize, .categorypath-crystal-crystal-specialties .personalizer-attribute { display: none !important; }
.personalizer-attribute .attr-val-featured .adj-nav-attribute, .hidden-personalize-option { display: none; }
/* @end */

/* @group MAGICZOOMER */
.MagicZoom img { border:0 !important; padding:0 !important; margin:0 !important; }
.MagicZoomBigImageCont { border:2px solid #F3F2EB; position:absolute !important; }
.MagicZoomHeader { font-size:8pt !important; line-height:normal !important; color:#fff; background:#666; text-align:center !important; display:none !important; }
.MagicZoomPup { cursor:none; border-radius:100%%; -moz-border-radius:100%; -webkit-border-radius:100%;
border:1px solid #dfdfdf; background-color: rgba(255,255,255,0.5); background-image: url('../images/zoom-cursor.gif'); background-position:center center; background-position-x: center; background-position-y: center; background-repeat: no-repeat; }
.MagicZoomLoading { border:1px solid #ccc; background:#fff url(../images/loader.gif) no-repeat 2px 50%; padding:4px 4px 4px 24px !important; margin:0; text-decoration:none; text-align:left; font-size:8pt; font-family:sans-serif; color:#444; }
.MagicZoomPlus { cursor:url(css/graphics/zoomin.cur), pointer; outline:0 !important; }
.MagicZoomPlus img { border:0 !important; padding:0 !important; margin:0 !important; }
.MagicZoomPlus span { display:none !important; }
.MagicHotspots { display:none; visibility:hidden; }
.MagicHotspots a { border:1px solid #ccc; }
.MagicHotspots a:hover { border:1px solid red; }
.MagicThumb, .MagicThumb:hover { cursor:url(css/graphics/zoomin.cur), pointer; outline:0 !important; }
.MagicThumb-expanded-thumbnail { cursor:default; }
.MagicThumb span { display:none !important; }
.MagicThumb img { border:0; outline:0; }
.MagicThumb-expanded { cursor:url(css/graphics/zoomout.cur), pointer; background:transparent; border:1px solid #ccc; outline:0; padding:0; }
.MagicThumb-caption { color:#333; font:normal 10pt Verdana, Helvetica; background:#ccc; text-align:left; padding:8px; border:0 !important; outline:0 !important; }
.MagicThumb-buttons { background:transparent url(css/graphics/buttons1.png) no-repeat 0 0; height:24px; display:block; }
.MagicThumb-buttons a { width:24px; height:24px; margin:0px 1px !important; overflow:hidden; }
.MagicThumb-loader { font:normal 12pt sans-serif; border:1px solid #000; background:#fff url(css/graphics/loader.gif) no-repeat 2px 50%; padding:2px 2px 2px 22px; margin:0; text-decoration:none; text-align:left; }
.MagicThumb-external-caption { display:none; }
.MagicZoom:hover .MagicZoomBigImageCont { top:-35px !important; left:346px !important; }
.ie7 .MagicZoom:hover .MagicZoomBigImageCont { left:346px !important; }
/* @end */

/* @group FIX MSRP SPACER */
.baRelatedProducts .bottom-price-wrapper .price-sep { width:1px; height:6px; margin-top:6px; border-bottom:1px solid #dcdcdc; background: #a4a4a4 !important; }
.category-products .bottom-price-wrapper .price-sep { width:1px; height:6px; margin-top:5px; border-bottom:1px solid #dcdcdc; background: #a4a4a4 !important; }
/* @end */

/* @group CART PAGE FIXES */
.checkout-cart-index .col-main { padding-top:29px; padding-bottom:35px; }
.checkout-cart-index .btn-checkout { margin-top:6px; font-weight:600; }
.cart-table td:last-child { padding-top:30px; }
.cart-table td:nth-child(3) { padding-top:26px; }
.cart-table { margin-right:0px; width:auto; }
.cart-table tfoot tr { border-top:2px solid #EEEDE7 !important; }
.cart .page-title h1, .cart .set-config, .cart .cat-num { letter-spacing:1px; }
.cart-table th { padding-bottom:1px; padding-top:1px; }
.cart-table .product-name a, .cart-table .product-name a:visited { letter-spacing:1px; color:#292929 !important; }
.cart .btn-continue, .cart .btn-update { letter-spacing:1px; font-weight:600 !important; }
.cart .btn-update { padding:0px 9px; margin-right:6px !important; }
.cart .btn-continue { padding:0px 0px !important; width:auto !important; }
.cart .btn-continue span span { width:auto !important; padding:0 4px 0 40px !important; margin:0 10px 0 0 !important; }
#shopping-cart-totals-table tr td, #shopping-cart-totals-table tr th { padding-right:15px; letter-spacing:1px; color:#5f6162; }
#shopping-cart-totals-table tr td:last-child { letter-spacing:0px; }
#shopping-cart-totals-table tfoot tr:last-child td { color:#000; }
.cart .form-list label { font-size:13px; }
.cart .discount h2, .cart .shipping h2 { font-weight:600; }
.cart .shipping { padding-right:50px; }
.cart .discount button, .cart .shipping button, .cart .discount button:hover, .cart .shipping button:hover { font-size:11px; line-height:30px; font-weight:600 !important; }
.empty-cart { padding:0 20px; }
.cart-table { width:900px !important; border:1px solid #EEEDE7 !important; }
.cart-table tbody { width:898px !important; ; }
.cart-table td { border-bottom:2px solid #EEEDE7; }
.cart-table td:first-child { padding:0px !important; width:140px !important; }
.cart-table td:nth-child(2) { width:321px !important; }
.cart-table td:nth-child(4) { width:63px !important; padding-left:5px; padding-right:5px; }
.cart-table td:nth-child(5) { width:148px !important; }
.cart-table td:nth-child(6) { width:58px !important; padding-left:5px; padding-right:5px; }
.cart-table td:last-child { width:53px !important; border-right:0px; *border-right:1px; }
.ie .cart-table td:last-child { width:53px !important; border-right:1px; }
.cart-table tfoot td, .cart-table tfoot td:first-child, .cart-table tfoot td:last-child { border-bottom:0px !important; }
.cart-table { border-bottom:2px solid #EEEDE7 !important; }
.cart-table tfoot { border:0px !important; }
/* @end */ 

.addthis_default_style { width:300px !important; }
.sp-methods { display:block; float:left; width:230px; padding-right:10px; clear:both; }
.sp-methods dt { display:block; float:left; clear:both; width:100%; }
.sp-methods dd { display:block; float:left; clear:both; width:100%; padding-bottom:14px; }
.sp-methods dd ul { display:block; float:left; padding-left:10px; }
.sp-methods dd ul li { display:block; float:left; width:100%; clear:both; }
.sp-methods dd ul li input { display:block; float:left; margin-right:5px; }
.sp-methods dd ul li label { display:block; float:left; line-height:18px; }
#checkout-onepage-index .sp-methods dd ul li label { clear:none !important; }
.sp-methods dd ul li label .price { display:block; float:left; line-height:18px; }
#quickadd-sku { -webkit-box-shadow:none; box-shadow:none; -moz-box-shadow:none; background: url(../images/cart-long-input.png) left top no-repeat; width:180px !important; height:25px; border-right:1px solid #dfdfdf; line-height:25px; }
.wishlist-index-share #form-validate .wide .input-box { display:block; float:left; clear:both; width:670px !important; height:auto; }
.wishlist-index-share #form-validate .wide .input-box textarea { display:block; float:left; width:670px; height:120px; resize:none; }
/* @group AUTOCOMPLETE */
.search-autocomplete { width:186px !important; }
.search-autocomplete ul { border:1px solid #dfdfdf !important; bordr-top:0px !important; padding-left:0px; width:184px; background-color:#a0a0a0 !important; color:#fff; }
.search-autocomplete ul li { padding:4px 6px 4px 10px !important; border-bottom:1px solid #dfdfdf !important; font-size:12px !important; text-align:left; cursor:pointer; }
.search-autocomplete ul li:hover, .search-autocomplete ul li:focus { background:#202020 !important; }
.search-autocomplete ul li.last { border-bottom:0px !important; }
.search-autocomplete ul li .amount { display:none; }
/* @end */

/* @group PAGER */
.pager { text-align:center !important; height:22px !important; }
.pager .pages { display:inline-block; }
.pager .pages span { height:25px; line-height:25px; }
.pager .limiter { width:135px !important; }
.pager .limiter label { display:none; }
.pager .amount { height:25px; line-height:25px; }
.pager .limiter p { text-align:left; height:25px; line-height:25px; float:left; }
.pager select { display:block; float:left; width:62px !important; height:25px !important; }
.pager .selector { display:block; float:left; width:55px !important; margin-right:8px !important; margin-left:0px !important; }
.pager .selector span { display:block; float:left; width:30px !important; }
/* @end */

/* @group CPSIA LOGIN */
#cpsia-login { display:none; }
#cpsia { cursor:pointer; }
.magento_content label { font-weight: 600; color: #4f4f4f; font-size: 12px; float: left; margin: 0 10px 0 0; min-width: 110px; line-height: 23px; display:block; float:left; clear:both; }
.magento_content .input-box { display:block; float:left; clear:both; }
.magento_content .input-box input { width:289px; padding:0px; line-height:25px; height:25px; box-shadow:none; -webkit-box-shadow:none; -moz-box-shadow:none; background: url(../images/cart-long-input.png) left top no-repeat; border:0px !important; text-indent:8px; }
.magento_content .magento_buttons { display:block; float:left; width:100%; height:auto; padding:10px 0 0; }
.magento_content input.button.ok_button { height: 30px; color: #fff; background: #7ba2b3;  background: -moz-linear-gradient(top, #7ba2b3 0%, #66CC33 100%); background: -webkit-gradient(linear, left top, left bottom, color-stop(0%, #7ba2b3), color-stop(100%, #66CC33)); background: -webkit-linear-gradient(top, #7ba2b3 0%, #66CC33 100%); background: -o-linear-gradient(top, #7ba2b3 0%, #66CC33 100%);  background: -ms-linear-gradient(top, #7ba2b3 0%, #66CC33 100%); filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#7ba2b3', endColorstr='#66CC33', GradientType=0 );
background: linear-gradient(top, #7ba2b3 0%, #66CC33 100%); text-shadow: 0px 1px 0px #394b59; font-weight: 400; text-align: left; padding: 0; font-family: proxima-nova, "Helvetica Neue", Arial, Helvetica, Geneva, sans-serif; font-size: 12px; box-shadow: 0 1px 1px 0 #cacaca; -wekit-box-shadow: 0 1px 1px 0 #cacaca; -moz-box-shadow: 0 1px 1px 0 #cacaca; border: none; border-radius: 0; float:left; font-weight: 400; line-height: 30px; text-shadow: 0px 1px 1px #202020; text-transform: uppercase; text-align: center; padding: 0 15px; font-family: proxima-nova, "Helvetica Neue", Arial, Helvetica, Geneva, sans-serif; }
.magento_content input.button.ok_button:hover { background: #7ba2b3;  background: -moz-linear-gradient(top, #66CC33 0%, #7ba2b3 100%); background: -webkit-gradient(linear, left top, left bottom, color-stop(0%, #66CC33), color-stop(100%, #7ba2b3)); background: -webkit-linear-gradient(top, #66CC33 0%, #7ba2b3 100%); background: -o-linear-gradient(top, #66CC33 0%, #7ba2b3 100%);  background: -ms-linear-gradient(top, #66CC33 0%, #7ba2b3 100%); filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#66CC33', endColorstr='#7ba2b3', GradientType=0 );
background: linear-gradient(top, #66CC33 0%, #7ba2b3 100%); box-shadow: 0 1px 1px 0 #cacaca; -wekit-box-shadow: 0 1px 1px 0 #cacaca; -moz-box-shadow: 0 1px 1px 0 #cacaca; }
.magento_content input.button.cancel_button { border: none; border-radius: 0; -moz-box-shadow: none; -webkit-box-shadow: none; box-shadow: none; height: 30px; color: #fff !important; background: #6b6e6e;  background: -moz-linear-gradient(top, #6b6e6e 0%, #5b5e5e 100%); background: -webkit-gradient(linear, left top, left bottom, color-stop(0%, #6b6e6e), color-stop(100%, #5b5e5e)); background: -webkit-linear-gradient(top, #6b6e6e 0%, #5b5e5e 100%); background: -o-linear-gradient(top, #6b6e6e 0%, #5b5e5e 100%);  background: -ms-linear-gradient(top, #6b6e6e 0%, #5b5e5e 100%); filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#6b6e6e', endColorstr='#5b5e5e', GradientType=0 );
background: linear-gradient(top, #6b6e6e 0%, #5b5e5e 100%); float:right; font-weight: 400; line-height: 30px; text-shadow: 0px 1px 1px #202020; text-transform: uppercase; text-align: center; padding: 0 15px; font-family: proxima-nova, "Helvetica Neue", Arial, Helvetica, Geneva, sans-serif; box-shadow: 0 1px 1px 0 #cacaca; -wekit-box-shadow: 0 1px 1px 0 #cacaca; -moz-box-shadow: 0 1px 1px 0 #cacaca; }
.magento_content input.button.cancel_button:hover { background: #5b5e5e;  background: -moz-linear-gradient(top, #5b5e5e 0%, #6b6e6e 100%); background: -webkit-gradient(linear, left top, left bottom, color-stop(0%, #5b5e5e), color-stop(100%, #6b6e6e)); background: -webkit-linear-gradient(top, #5b5e5e 0%, #6b6e6e 100%); background: -o-linear-gradient(top, #5b5e5e 0%, #6b6e6e 100%);  background: -ms-linear-gradient(top, #5b5e5e 0%, #6b6e6e 100%); filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#5b5e5e', endColorstr='#6b6e6e', GradientType=0 );
background: linear-gradient(top, #5b5e5e 0%, #6b6e6e 100%); font-family: proxima-nova, "Helvetica Neue", Arial, Helvetica, Geneva, sans-serif; border: none !important; box-shadow: 0 1px 1px 0 #cacaca; -wekit-box-shadow: 0 1px 1px 0 #cacaca; -moz-box-shadow: 0 1px 1px 0 #cacaca; }
.cms-terms-conditions .magento_content { padding:30px 20px; }
.cms-terms-conditions .magento_content p { display:block; float:left; width:100%; padding-bottom:14px; }
.cpsia-error { color:#e64821; }
/* @end */

.checkout-onepage-index .checkout-link { display:none !important; }
.ie7 .quick-access>.links { width:420px; }
.ie7 .checkout-onepage-index .quick-access>.links { width:380px; }
.ie7 .quick-access>.loggedin { width:510px; }
.ie7 .checkout-onepage-index .quick-access>.loggedin { width:440px; }

/* @group SHIPPING METHOD FIXES */
.sp-methods .method-title { display:block; float:left; clear:both; }
.sp-methods label .price { display:block; float:left; clear:both; }
/* @end */

/* @group AS SEEN IN */
.cms-as-seen-in .std { display:block; float:left; clear:both; width:860px; padding:40px 40px 42px; }
.asi h1 { text-align:center; color:#202020; font-size:25px !important; line-height:25px !important; letter-spacing:1px; }
#as-seen-in li { display:block; float:left; width:420px; height:168px; padding-right:19px; padding-bottom:18px; }
#as-seen-in li.even { padding-right:0px; }
#as-seen-in li .asi-item { display:block; float:left; width:418px; height:168px; border:1px solid #d7d6cb; }
#as-seen-in li .image-box { display:block; float:left; padding:12px 15px 0 12px; }
#as-seen-in li .info-box { display:block; float:left; width:160px !important; height:auto; padding:19px 12px 0 0; }
.ie7 #as-seen-in li .info-box { width:167px; padding-right:5px; }
#as-seen-in li .info-box h2 { display:block; float:left; clear:both; margin:0px; font-size:15px; line-height:18px; color:#000; padding-bottom:1px; width:100%; }
#as-seen-in li .info-box h3 { display:block; float:left; clear:both; margin:0px; font-size:13px; text-transform:none; font-weight:normal; line-height:18px; color:#4f4f4f; padding-bottom:8px; width:100%; }
#as-seen-in li .info-box h4 { display:block; float:left; clear:both; margin:0px; font-size:13px; font-weight:600 !important; line-height:18px; padding-bottom:1px; width:100%; }
.ie #as-seen-in li .info-box h4 a, .ie #as-seen-in li .info-box span { font-weight:normal !important; }
#as-seen-in li .info-box h5 { display:block; float:left; clear:both; margin:0px; font-size:11px; font-weight:normal; letter-spacing:1px; color:#4f4f4f; padding-bottom:17px; width:100%; }
#as-seen-in li .info-box span { display:block; float:left; clear:both; font-size:13px; line-height:18px; font-weight:600; width:100%; }
.page_navigation { display:block; width:280px; height:20px; clear:both; margin:0 auto; text-align:center; clear:both; }
.page_link { display:block; float:left; width:25px; height:20px; margin-left:10px; }
.page_navigation .next_link, .page_navigation .previous_link { float:left; width:25px; height:20px; margin-left:10px; text-indent:-9999px; }
.page_navigation .next_link { background: url(../images/cms-pager-arrows.png) right top no-repeat; }
.page_navigation .previous_link { background: url(../images/cms-pager-arrows.png) left top no-repeat; }
.page_navigation .next_link:hover { background-position:right bottom }
.page_navigation .previous_link:hover { background-position:left bottom }
.page_link { color:#fff !important; line-height:20px; font-size:12px; text-shadow: 0px 1px 1px #202020; -webkit-text-shadow: 0px 1px 1px #202020; -moz-text-shadow: 0px 1px 1px #202020; background-color: #7e8181; background-image: -webkit-gradient(linear, left top, left bottom, from(rgb(126, 129, 129)), to(rgb(110, 113, 113))); background-image: -webkit-linear-gradient(top, rgb(126, 129, 129), rgb(110, 113, 113)); background-image: -moz-linear-gradient(top, rgb(126, 129, 129), rgb(110, 113, 113)); background-image: -o-linear-gradient(top, rgb(126, 129, 129), rgb(110, 113, 113)); background-image: -ms-linear-gradient(top, rgb(126, 129, 129), rgb(110, 113, 113)); background-image: linear-gradient(top, rgb(126, 129, 129), rgb(110, 113, 113)); filter: progid:DXImageTransform.Microsoft.gradient(startColorStr='#7e8181', EndColorStr='#6e7171'); }
.page_link:hover { text-decoration:none; color:#fff !important; line-height:20px; font-size:12px; text-shadow: 0px 1px 1px #202020; -webkit-text-shadow: 0px 1px 1px #202020; -moz-text-shadow: 0px 1px 1px #202020; background-color: #6e7171; background-image: -webkit-gradient(linear, left top, left bottom, from(rgb(110, 113, 113)), to(rgb(126, 129, 129))); background-image: -webkit-linear-gradient(top, rgb(110, 113, 113), rgb(126, 129, 129)); background-image: -moz-linear-gradient(top, rgb(110, 113, 113), rgb(126, 129, 129)); background-image: -o-linear-gradient(top, rgb(110, 113, 113), rgb(126, 129, 129)); background-image: -ms-linear-gradient(top, rgb(110, 113, 113), rgb(126, 129, 129)); background-image: linear-gradient(top, rgb(110, 113, 113), rgb(126, 129, 129)); filter: progid:DXImageTransform.Microsoft.gradient(startColorStr='#6e7171', EndColorStr='#7e8181'); }
.no_more { display:none; }
/* @group LIGHTBOX2 */
#lightbox { position: absolute; left: 0; width: 100%; z-index: 6000; text-align: center; line-height: 0; }
#lightbox img { width: auto; height: auto; }
#lightbox a img { border: none; }
#outerImageContainer { position: relative; background-color: #fff; width: 250px; height: 250px; margin: 0 auto; }
#imageContainer { padding: 22px 32px 64px; background:#fff; }
.cms-as-seen-in #loading { position: absolute; top: 40%; left: 0%; height: 25%; width: 100%; text-align: center; line-height: 0; }
.cms-as-seen-in #hoverNav { position: absolute; top: 0; left: 0; height: 100%; width: 100%; z-index: 10; }
#imageContainer>#hoverNav { left: 0; }
.cms-as-seen-in #hoverNav a { outline: none; }
.cms-as-seen-in #prevLink { left: 0; float: left; display:block; width:21px; height:44px !important; background: url(../images/as-seen-in/modal/prevlabel.png) left top no-repeat; margin-top:108px; }
.cms-as-seen-in #nextLink { right: 0; float: right; display:block; width:21px; height:44px !important; background: url(../images/as-seen-in/modal/nextlabel.png) right top no-repeat; margin-top:108px; }
.cms-as-seen-in #prevLink:hover, .cms-as-seen-in #nextLink:hover { background-position:left bottom; }
.cms-as-seen-in #imageDataContainer { font: 10px Verdana, Helvetica, sans-serif; margin: 0 auto; line-height: 1.4em; width: 100%; display:block; }
.cms-as-seen-in #imageData { padding:0 10px; color: #666; }
.cms-as-seen-in #imageData #imageDetails { float: left; text-align: left; width:100%; position:relative; top:-31px; text-align:center; z-index:1000000000; }
.cms-as-seen-in #imageData #numberDisplay { display: block; clear: left; padding-bottom: 1.0em; display:none; }
.cms-as-seen-in #imageData #bottomNavClose { display:block; float:right; width:16px; height:16px; position:absolute; right:16px; z-index:9999; }
.cms-as-seen-in #imageData #caption { display:block; float:left; clear:both; width:100%; text-align:center; font-size:13px; font-weight:600; font-family: proxima-nova, "Helvetica Neue", Arial, Helvetica, Geneva, sans-serif; line-height:18px; }
.cms-as-seen-in #imageData #itemId { display:block; float:left; clear:both; width:100%; text-align:center; color:#4f4f4f; font-size:11px; font-family: proxima-nova, "Helvetica Neue", Arial, Helvetica, Geneva, sans-serif; letter-spacing:1px; }
.cms-as-seen-in #overlay { position: absolute; top: 0; left: 0; z-index: 5999; width: 100%; height: 500px; background-color: #000; }
.cms-as-seen-in #bottomNav { position:absolute; display:block; top:6px; width:470px; height:16px; }
.ie7 .cms-as-seen-in #bottomNav { width:0px !important; }
/* @end */
	
/* @end */

/* @group ADJNAV FIX */
.adj-nav-progress img { display:block; position:absolute; width:111px; height:120px; left:294px !important; top:100px; }
/* @end */

/* @group MY ACCOUNT FIXES */
.my-wishlist .btn-cart { background: url("../images/btn-sm-addtocart.png") left top no-repeat !important; width:85px !important; height:22px !important; filter: progid:DXImageTransform.Microsoft.gradient(enabled=false) !important; }
.my-wishlist .btn-cart:hover { background-position:left bottom !important; }
.addresses-list { display:block; float:left; clear:both; width:100%; }
.addresses-list ol li.item { padding-bottom:14px; }
dl.order-info { display:block; float:left; width:100%; clear:both; margin-bottom:10px; }
.order-page .col2-set { clear:both; }
.order-info ul li { padding-left:10px; }
.my-wishlist fieldset { display:block; float:left; clear:both; width:680px; }
.my-wishlist fieldset table { width:680px; }
.my-wishlist p { display:block; float:left; clear:both; }
.my-wishlist textarea { width:321px; height:80px; resize:none; }
.ie .my-wishlist textarea { width:300px; background: url(../images/texarea-bg.png) left top no-repeat; border-right:1px solid #E0E0E0; }
.ie textarea#email_address, .ie textarea#message { background: url(../images/texarea-bg.png) left top no-repeat; border-right:1px solid #E0E0E0; }
#checkout-review-submit textarea { background: url(../images/texarea-bg.png) left top no-repeat; border-right:1px solid #E0E0E0; resize:none; }
.wishlist-share label em { padding-right:5px; }
/* @end */

/* @group FIX THUMBNAILS */
.more-views ul li a { padding:4px; display:block; background:#fff; }
.product-collateral h2 { letter-spacing:1px; }
/* @end */

/* @group SCENE 7 FONTS */
.s7_font_image { padding-top:11px; }
/* @end */

/* @group RELATED ITEMS & UPSELLS FIX */
.box-related .block-content { display:block; float:left; width:938px; }
.box-related .block-content.additional-related { border-top:2px solid #F3F2EB; }
.box-related .block-content.additional-related .item.row-count-1.last, .box-related .block-content.additional-related .item.row-count-2.last, .box-related .block-content.additional-related .item.row-count-3.last { border-right:2px solid #F3F2EB; }
.box-up-sell .products-grid { border-top:2px solid #F3F2EB; }
.box-up-sell .products-grid.first { border-top:0px; }
.box-up-sell .item.row-count-1.last, .box-up-sell .item.row-count-2.last, .box-up-sell .item.row-count-3.last, .box-related .item.row-count-1.last, .box-related .item.row-count-2.last, .box-related .item.row-count-3.last { border-right:2px solid #F3F2EB; }

/* @end */

/* @group CMS PAGE MESSAGE REVIEW */
.cms-page-view .messages { display:block; float:left; min-height:40px; height:40px; margin-top:9px; }
/* @end */

/* @group BOTTOM PRICE WRAPPER FIX */
.bottom-price-wrapper span { }
.ie .bottom-price-wrapper span { letter-spacing:0px; }
/* @end */

/* @group REED ALL ABOUT IT FIXES */
.cms-reed-all-about-it .related-name, .cms-reed-all-about-it .related-sub { width:196px !important; text-align:center !important; }
.cms-reed-all-about-it .tabs-column ul { display:block; float:left; width:100%; height:auto; }
.cms-reed-all-about-it .tabs-column li { display:block; float:left; width:100%; height:auto; }
/* @end */

/* @group CHECKOUT PLACE ORDER AJAX FIX */
.opc .buttons-set .please-wait { top: 0px; }
#checkout-step-review .buttons-set .please-wait { top:-5px; }
#checkout-step-review .btn-remove { width:16px; height:16px; display:block; float:left; }
/* @end */

/* @group MY ORDERS TABLE FIXES */
#my-orders-table .cart-price { display: block; float: left; }
/* @end */

/* @group OUR BRANDS FIXES */
.cms-our-brands .std { width:862px; }
/* @end */

/* @group CART SHIPPING RATE FIX */
.shipping-rate-name { display: block; float: left; clear:both; }
#checkout-shipping-method-load .sp-methods label .price { display:block; float:left; clear:both; }
/* @end */

/* @group COPY FIXES */
.cms-faqs .std h1 { text-transform:none !important; }
/* @end */

/* @group IE MESSAGES */
.ie .messages { display:block; float:left; width:100%; margin-top:10px !important; margin-bottom:10px !important; clear:both !important; }
.ie .messages a { color:#fff !important; }
.ie .messages a:hover { color:#fff !important; }
.ie .messages>li { display:block; float:left; width:100%; min-height:none !important; margin-left:0px !important; padding:0px 0px 0px 0px; line-height:20px !important; margin-top:0px !important; margin-bottom:0px !important; background-position-x: 10px !important; background-position-y:10px !important; background-repeat: no-repeat !important; border-radius:5px !important; -webkit-border-radius:5px !important; -moz-border-radius:5px !important; padding-top:10px !important; padding-bottom:10px !important; }
.ie .messages>li>ul { display:block; float:left; padding:0px !important; margin:0px !important; }
.ie .messages>li>ul>li { display:block; float:left; padding:0px !important; margin:0px !important; line-height:20px !important; font-family: "Crimson Text", Georgia, "Times New Roman", Times, serif !important; font-size:16px !important; font-style:normal !important; font-weight: 600 !important; }
.ie .messages span { display:block; float:left; padding:0px !important; margin:0px !important; line-height:20px !important; font-family: "Crimson Text", Georgia, "Times New Roman", Times, serif !important; font-size:16px !important; font-style:normal !important; font-weight: 600 !important; }
.ie .success-msg { background-color:#8dbd5a !important; background-image: url('../images/icon-success-message.png') !important; font-family: "Crimson Text", Georgia, "Times New Roman", Times, serif !important; font-size:16px !important; line-height:20px !important; font-weight: 600 !important; }
.ie .error-msg { background-color:#e3452a !important; background-image: url('../images/icon-error-message.png') !important; font-family: "Crimson Text", Georgia, "Times New Roman", Times, serif !important; font-size:16px !important; line-height:20px !important; font-weight: 600 !important; }
.ie .note-msg { background-color:#A23F6B !important; background-image: url('../images/icon-noresults-message.png') !important; font-family: "Crimson Text", Georgia, "Times New Roman", Times, serif !important; font-size:16px !important; line-height:20px !important; font-weight: 600 !important; }
.ie p.note-msg { background-color:#A23F6B !important; background-image: url('../images/icon-noresults-message.png') !important; line-height:25px !important; padding-top:10px !important; padding-bottom:10px !important; height:20px !important; font-family: "Crimson Text", Georgia, "Times New Roman", Times, serif !important; font-size:16px !important; line-height:20px !important; font-weight:600 !important; font-style:normal !important; margin-top:10px !important; margin-bottom:10px !important; }
.ie .notice-msg { background-color:#E9BA00 !important; background-image: url(../images/icon-noresults-message.png) !important; font-family: "Crimson Text", Georgia, "Times New Roman", Times, serif !important; font-size:16px !important; line-height:20px !important; font-weight: 600 !important; }
.ie .catalog-category-view .messages { margin-top:0px !important; width:700px !important; }
.ie .catalog-category-view .messages>li { width:650px !important; }
.checkout-cart-index .messages { width:900px !important; padding:0 20px !important; }
.ie .checkout-cart-index .messages { width:900px !important; margin-top:0px !important; margin-bottom:10px !important; padding-left:20px !important; padding-right:20px !important; }
.ie .checkout-cart-index .cart .messages { width:900px !important; padding-left:20px !important; padding-right:20px !important; }
.checkout-cart-index .messages>li { width:850px !important; }
.ie .customer-account-create .messages { width:460px !important; }
.ie .customer-account-create .messages>li { width:414px !important; }
.ie .wishlist-index-index .messages>li>ul>li { width:630px !important; }
.ie .wishlist-index-index .data-table { width:679px !important; }
.ie .checkout-cart-index .cart .table { clear:both !important; }
.ie .shopping-cart-fieldset { display:block; float:left; clear:both; }
/* @end */

.ie .customer-account-create .col-2 label { width:132px !important; }
/* @group REVIEWS FIXES */
#nickname_field, #summary_field { display:block; float:left; height:24px !important; line-height:24px !important; background: url('../images/cart-long-input2.png') left top no-repeat !important; box-shadow:0 0 0 #fff; -webkit-box-shadow:0 0 0 #fff; -moz-box-shadow:0 0 0 #fff; width:305px !important; }
#nickname_field.validation-failed, #summary_field.validation-failed { box-shadow:0 0 0 #fff !important; -webkit-box-shadow:0 0 0 #fff !important; -moz-box-shadow:0 0 0 #fff !important; background-position:left -24px !important; }
#review_field { width:304px !important; resize:none; background: url('../images/texarea-bg.png') left top no-repeat; border-right:1px solid #E0E0E0 !important; }
#review_field.validation-failed { box-shadow:0 0 0 #fff !important; -webkit-box-shadow:0 0 0 #fff !important; -moz-box-shadow:0 0 0 #fff !important; }
.ie #nickname_field, .ie #summary_field { height:22px !important; }
/* @end */

/* @group PRODUCT SPEC FIXEs */
.ba-queue-list-element { display:block; float:left; clear:both; width:100%; }
.ba-queue-list-element div { display:block; float:left; clear:both; width:100%; }
.ba-queue-remove-product { display:block; float:left; height:18px !important; background-position:left center !important; background-image: url("../images/delete.jpg"); background-repeat: no-repeat; filter:none !important; }
.ba-queue-list-element div span { display:block; float:right; clear:none; width:165px !important; }
.ie #ba-indv-text-input-container input { background-image: url("../images/cart-long-input.png"); background-position:left top; border-right:1px solid #DFDFDF; }
/* @end */

/* @group CATEGORY TABS FIX */
.ie .category-view ul#tabs { display:block; float:right; clear:both; }
.ie .category-view .categoryTabs { display:block; float:left; clear:both !important; background:none !important; }
.ie7 .category-view .jcarousel-tabs-rb { display:block; float:left; clear:both !important; margin-top:30px !important; }
.ie .my-account input.input-text { display:block; float:left; }
.ie .my-account .checkbox { display:block; float:left; width:24px !important; }
.ie .my-account .btn-blue span span { text-align:center !important; }
/* @end */

.opc-wrapper .year { display:block; margin-top:0px }
/* @group GIFT MESSAGES */
.ie .gift-item input.input-text { display:block; float:left; width:250px !important; height:22px !important; line-height:22px !important; background: url('../images/checkout-select.png') left top no-repeat; }
.ie .gift-item input.input-text.validation-failed { background-position:left -24px !important; }
.ie .gift-item .giftmessage-area { display:block; float:left; width:250px !important; resize:none; background: url('../images/texarea-bg.png') left top no-repeat !important; border-right:1px solid #E0E0E0; }
/* @end */

/* @group REED ALL ABOUT IT FIXES */
.informal { display:block; float:left; padding-right:100px !important; width:269px !important; }
.formal { display:block; float:left; padding:0px !important; width:249px; }
.formal p, .informal p { display:block; float:left; clear:both; width:100% !important; text-align:center; }
/* @end */

/* @group CART FIXES */
#checkout-step-login .col-2 .form-list { display:block; float:left; width:200px !important; }
#checkout-step-login .col-2 .form-list li { width:200px !important; display:block; float:left; clear:both; }
#checkout-step-login .radio-container { display:block; float:left; height:22px !important; }
#checkout-step-login .col-2 label { display:block; float:left; clear:none; }
/* @end */

/* @group CART FIXES */
#paypal_direct_expiration_yr { margin-top:11px; }
/* @end */

/* @group STORE FINDER FIX */
#advice-validate-zip-address { width:265px; line-height:18px; }
/* @end */

/* @group PERSONALIZE FORM FIX */
.personalize-form-error { display:block; float:left; font-size:12px; padding-top:7px; font-family: proxima-nova, "Helvetica Neue", Arial, Helvetica, Geneva, sans-serif; color:#e3452a; width:362px; }
/* @end */

#opc-review tfoot tr td:first-child { font-weight:bold; }
.wishlist-index-index .buttons-set { display:block; float:left; }

.in-stock-items { font-weight:600; color:#819f41; letter-spacing:1px; }
.backorder-items { font-weight:600; color:#e3452a; letter-spacing:1px; }
#checkout-review-table-wrapper .product-name, #checkout-review-table-wrapper .cart-price .price { font-size:13px; }

.ie .catalog-category-view .pager { width:290px; }

/* @group MY REVIEWS FIXES */
.customer-account-index #my_recent_reviews .item { display:block; float:left; clear:both; padding-bottom:11px; width:100%; }
.customer-account-index #my_recent_reviews .item .details { display:block; float:left; clear:none !important; padding-left:10px; }
.customer-account-index #my_recent_reviews .item .number { display:block; float:left; clear:none; }
.review-customer-view .product-review { padding:0px; width:680px; }
.review-customer-view .product-img-box { display:block; float:left; clear:both; width:232px !important; height:auto !important; }
.review-customer-view .product-image { display:block; float:left; clear:both; width:192px !important; height:215px !important; padding:20px !important; }
.review-customer-view .details { display:block; float:left; width:428px; margin-left:20px; }
.review-customer-view .review-summary-table { margin-bottom:11px; }
.review-customer-view .product-img-box .rating-box { margin-bottom:11px !important; }
.review-customer-view h2.product-name { font-weight:400; letter-spacing:1px !important; }
.review-customer-index h2.product-name { letter-spacing:1px; font-weight:400; font-size:14px !important; }
.review-customer-index .data-table { margin-bottom:20px; }
/* @end */

/* @group NEW CART FIXES */
.checkout-cart-index .form-list .selector span { width:245px; }
.checkout-cart-index .form-list select { width:277px; height:24px; }
.ie .shipping-form .form-list input.input-text { width:276px; }
/* @end */

@media screen and (-webkit-min-device-pixel-ratio:0) {
#nav li.parent>a { font-size:11px; font-weight:600; }
#tabs li a, #tabsRel li a { font-weight:700; }
.quick-access ul.links li.last a { font-weight:700; }
.cart-table td:last-child { border-right:2px solid #EEEDE7; }
}
.product-essential #tabs { position:relative; z-index:1 !important; }
#narrow-by-list dd ol { max-height: 240px; width: 190px; }
 @media screen and (max-device-width: 480px) {
.category-view .grid-qty-input { height:21px; }
.product-shop input.qty { height:29px; }
.baRelatedProducts input.qty { height:21px !important; }
.cart-table .input-text.qty, .opc-wrapper input[type="date"], .opc-wrapper input[type="datetime"], .opc-wrapper input[type="datetime-local"], .opc-wrapper input[type="email"], .opc-wrapper input[type="month"], .opc-wrapper input[type="number"], .opc-wrapper input[type="password"], .opc-wrapper input[type="search"], .opc-wrapper input[type="tel"], .opc-wrapper input[type="text"], .opc-wrapper input[type="time"], .opc-wrapper input[type="url"], .opc-wrapper input[type="week"], input.qty, .opc-wrapper input.input-text, .account-login input.input-text, .account-create input.input-text, .my-account input.input-text { height:23px; }
.cart .discount input.input-text, .shipping-form .form-list input.input-text { height:24px; }
.is_webkit .opc-wrapper select:focus, .is_webkit .opc-wrapper select:active, .is_webkit .opc-wrapper select, .is_webkit .opc-wrapper select.validation-failed { height:24px; }
}

button, button, button.slvzr-focus { border:0px !important; }

ul.links .dropdown-cart, ul.links .dropdown-wishlist {z-index: 2000;}
.ie div.quick-access{z-index: 1000;}

.sort-by div.selector select option{font-family: proxima-nova,"Helvetica Neue",Helvetica,Arial,sans-serif; padding: 2px 2px; border: 1px solid #a0a0a0; border-top: 0;}

.products-grid .availability.out-of-stock {margin: 0; }


.jcarousel-skin-rb .jcarousel-clip a { text-decoration: none; }
#nav ul li.last, #nav ul li.last a { padding: 2px 0 0 0 !important; }


.quick-access .block-content p.empty { margin: 0 0 0 15px; color: #fff; font-size: 12px; }
/* @group Menu */
#nav li.parent.nav-1>a { margin-right:10px; }
#nav li.parent.nav-2>a { margin:  0 10px !important; }
#nav li.parent.nav-3>a { margin:  0 10px !important; }
#nav li.parent.nav-4>a { margin:  0 10px !important; }
#nav li.parent.nav-5>a { margin:  0 10px !important; }
#nav li.parent.nav-6>a { margin:  0 10px !important; }
#nav li.parent.nav-7>a { margin-right:0px !important; margin-left:10px; }
#nav li.parent.nav-8>a { margin:  0 10px !important; }
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
</style>
<script type="text/javascript" src="http://use.typekit.net/mwb2rov.js"></script>
<script type="text/javascript">try{Typekit.load();}catch(e){}</script>
<div class="footer-container" style="margin-top:2% !important;">
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
    <th scope="col"> <a href="http://www.facebook.com/AmericanStandardPlumbing" target="_blank"><img src="../../../EzComm/EzSales/Sales/Library/Styles/facebook.png" /></a>&nbsp;</th>
    <th scope="col">&nbsp;<a target="_blank" href="https://twitter.com/intent/follow?original_referer=http%3A%2F%2Fwww.americanstandard-us.com%2F&region=follow_link&screen_name=AmercanStandard&source=followbutton&variant=2.0"><img src="../../../EzComm/EzSales/Sales/Library/Styles/twitter.png" /></a>&nbsp;</th>
    <th scope="col">&nbsp;<a target="_blank" href="http://www.youtube.com/user/AmericanStandard01" /><img src="../../../EzComm/EzSales/Sales/Library/Styles/youtube.png" /></a></th>
  </tr>
</table>

</li>
<li>
<img src="../../../EzComm/EzSales/Sales/Library/Styles/bsb_version_revised_0004_Vector-Smart-Object.png" height="62" width="265" />
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
	<a href="http://www.americanstandard.com/terms-conditions/" target="_blank">Terms &amp; Conditions</a>
	<span class="sep">|</span>
	<a href="http://www.americanstandard.com/security-privacy-policy/" target="_blank">Security &amp; Privacy Policy</a>
</div>
<div>

<table width="100%" bgcolor="#a0a0a0" style="margin-left:100px;">
  <tr>
    <th scope="col"><img src="../../../EzComm/EzSales/Sales/Library/Styles/clientelefooter.png" alt="clientele" /></th>
    
  </tr>
  <!--<tr><th style="text-align:center;">Powered by <a href="http://www.answerthink.com/solutions/suite.jsp" style="color:#FFF !important;" target="_blank">Answerthink</a></th></tr>-->
</table>
<table style="width:100%;">
<tr><th style="text-align:center; color:#FFF !important;">Powered by <a href="http://www.answerthink.com/solutions/suite.jsp" style="color:#FFF !important;" target="_blank">Answerthink</a></th></tr>
</table>

</div>

</footer>


<SCRIPT type="text/javascript" charset="utf-8" src="../AST_Login/contentnamesearch.js"></SCRIPT>
<SCRIPT type="text/javascript" charset="utf-8" src="../AST_Login/split_button.js"></SCRIPT>
<SCRIPT type="text/javascript" charset="utf-8" src="../AST_Login/userstatus.js"></SCRIPT>
<SCRIPT type="text/javascript" charset="utf-8" src="../AST_Login/safe-ajax.js"></SCRIPT>
<SCRIPT type="text/javascript">
    


</SCRIPT>
</BODY></HTML>

	
	
