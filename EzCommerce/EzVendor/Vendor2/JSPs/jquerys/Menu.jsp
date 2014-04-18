<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<jsp:useBean id="UManager" class="ezc.client.EzUserAdminManager" scope="session" />
<%@ include file="../../Library/Globals/ezBannerErrPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ include file="../../../Includes/JSPs/Misc/iLoginBanner.jsp" %>
<%@ page import="javax.xml.parsers.*,org.w3c.dom.*,javax.xml.transform.*,javax.xml.transform.dom.DOMSource,java.io.FileOutputStream,javax.xml.transform.stream.StreamResult" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml2/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>

<script type="text/javascript" src="ddaccordion.js">
<%
	String XMLsupportid="";
	try
		{
			DocumentBuilderFactory docFactory = javax.xml.parsers.DocumentBuilderFactory.newInstance();
			DocumentBuilder docBuilder = docFactory.newDocumentBuilder();

			String fileName = "ezLoginBanner.jsp";
			String filePath=request.getRealPath(fileName);
			filePath=filePath.substring(0,filePath.indexOf(fileName));
			String filePath1 = filePath+"\\..\\..\\..\\..\\EzCommon\\XMLs\\ezData.xml";
			java.io.File fileObj = new java.io.File(filePath1);
			if(!fileObj.exists())
			{
				filePath1 = filePath+"\\EzCommerce\\EzCommon\\XMLs\\ezData.xml";
			}

			Element element=null;
			Node node=null;
			Document doc = docBuilder.parse("file:"+filePath1);
			Element root = doc.getDocumentElement();

			NodeList list = root.getElementsByTagName("EzVendor");
			node=list.item(0);
			XMLsupportid = ((Element)node).getElementsByTagName("support").item(0).getFirstChild().getNodeValue();
			if(XMLsupportid == null || "null".equals(XMLsupportid))
				XMLsupportid = "";
			
			
			
		}
	catch(Exception e){}




%>

/***********************************************
* Accordion Content script- (c) Dynamic Drive DHTML code library (www.dynamicdrive.com)
* Visit http://www.dynamicDrive.com for hundreds of DHTML scripts
* This notice must stay intact for legal use
***********************************************/

</script>

<script type="text/javascript">
function callFun(clickedOn)

	{if(clickedOn=='L')
		{
			top.location.href='../Misc/ezLogout.jsp'
		} 
	}

ddaccordion.init({
	headerclass: "headerbar", //Shared CSS class name of headers group
	contentclass: "submenu", //Shared CSS class name of contents group
	revealtype: "mouseover", //Reveal content when user clicks or onmouseover the header? Valid value: "click", "clickgo", or "mouseover"
	mouseoverdelay: 200, //if revealtype="mouseover", set delay in milliseconds before header expands onMouseover
	collapseprev: true, //Collapse previous content (so only one open at any time)? true/false
	defaultexpanded: [0], //index of content(s) open by default [index1, index2, etc] [] denotes no content
	onemustopen: true, //Specify whether at least one header should be open always (so never all headers closed)
	animatedefault: false, //Should contents open by default be animated into view?
	persiststate: true, //persist state of opened contents within browser session?
	toggleclass: ["", "selected"], //Two CSS classes to be applied to the header when it's collapsed and expanded, respectively ["class1", "class2"]
	togglehtml: ["", "", ""], //Additional HTML added to the header when it's collapsed and expanded, respectively  ["position", "html1", "html2"] (see docs)
	animatespeed: "normal", //speed of animation: integer in milliseconds (ie: 200), or keywords "fast", "normal", or "slow"
	oninit:function(headers, expandedindices){ //custom code to run when headers have initalized
		//do nothing
	},
	onopenclose:function(header, index, state, isuseractivated){ //custom code to run whenever a header is opened or closed
		//do nothing
	}
})

</script>

<style type="text/css">

.urbangreymenu{
width: 190px; /*width of menu*/
}

.urbangreymenu .headerbar{
font: bold 13px Verdana;
color: white;
background: #606060 url(arrowstop.gif) no-repeat 8px 6px; /*last 2 values are the x and y coordinates of bullet image*/
margin-bottom: 0; /*bottom spacing between header and rest of content*/
text-transform: uppercase;
padding: 7px 0 7px 31px; /*31px is left indentation of header text*/
}

.urbangreymenu .headerbar a{
text-decoration: none;
color: white;
display: block;
}

.urbangreymenu ul{
list-style-type: none;
margin: 0;
padding: 0;
margin-bottom: 0; /*bottom spacing between each UL and rest of content*/
}

.urbangreymenu ul li{
padding-bottom: 2px; /*bottom spacing between menu items*/
}

.urbangreymenu ul li a{
font: normal 12px Arial;
color: black;
background: #E9E9E9;
display: block;
padding: 5px 0;
line-height: 17px;
padding-left: 8px; /*link text is indented 8px*/
text-decoration: none;
}

.urbangreymenu ul li a:visited{
color: black;
}

.urbangreymenu ul li a:hover{ /*hover state CSS*/
color: white;
background: black;
}

</style>

<body>

<div class="urbangreymenu">


<h3 class="headerbar">RFQ</a></h3>
<ul class="submenu">
<li><a href="../RFQ/ezListRFQs.jsp?type=New" target="right">New</a></li>
<li><a href="../RFQ/ezListRFQs.jsp?type=All" target="right">All</a></li>
<li><a href="../RFQ/ezListRFQs.jsp?type=List" target="right">View Quotations</a></li>
</ul>

<h3 class="headerbar">Purchase Orders</a></h3>
<ul class="submenu">
<li><a href="../RFQ/ezListRFQs.jsp?type=New"target="right" >To Be Acknowledged</a></li>
<li><a href="../RFQ/ezListRFQs.jsp?type=New"target="right" >Acknowledged</a></li>
<li><a href="../RFQ/ezListRFQs.jsp?type=All"target="right">Closed</a></li>
<li><a href="../RFQ/ezListRFQs.jsp?type=List"target="right">All</a></li>
<li><a href="../RFQ/ezListRFQs.jsp?type=List"target="right">ontracts</a></li>
</ul>
<h3 class="headerbar">Schd Agreements</a></h3>
<ul class="submenu">
<li><a href="../RFQ/ezListRFQs.jsp?type=New"target="right" >Open</a></li>
<li><a href="../RFQ/ezListRFQs.jsp?type=All"target="right">Closed</a></li>
<li><a href="../RFQ/ezListRFQs.jsp?type=List"target="right">All</a></li>
</ul>
<h3 class="headerbar">Shipments</a></h3>
<ul class="submenu">
<li><a href="../RFQ/ezListRFQs.jsp?type=New"target="right" >Add</a></li>
<li><a href="../RFQ/ezListRFQs.jsp?type=All"target="right">View</a></li>

</ul>
<h3 class="headerbar">Invoices</a></h3>
<ul class="submenu">
<li><a href="../RFQ/ezListRFQs.jsp?type=New"target="right" >Open</a></li>
<li><a href="../RFQ/ezListRFQs.jsp?type=All"target="right">Closed</a></li>
<li><a href="../RFQ/ezListRFQs.jsp?type=List"target="right">All</a></li>
</ul>

<h3 class="headerbar">Self Services</a></h3>
<ul class="submenu">
<li><a href="../RFQ/ezListRFQs.jsp?type=New"target="right" >DNs To Be Invoiced</a></li>
<li><a href="../RFQ/ezListRFQs.jsp?type=All"target="right">Outstanding Balance</a></li>
<li><a href="../RFQ/ezListRFQs.jsp?type=List"target="right">A/C Statement</a></li>
<li><a href="../RFQ/ezListRFQs.jsp?type=New"target="right" >Bank Details</a></li>
<li><a href="../RFQ/ezListRFQs.jsp?type=All"target="right">Rejected Materials</a></li>
<li><a href="../RFQ/ezListRFQs.jsp?type=List"target="right">To Be Delivered</a></li>
<li><a href="../RFQ/ezListRFQs.jsp?type=New"target="right" >Display Consignment Stocks</a></li>
<li><a href="../RFQ/ezListRFQs.jsp?type=All"target="right">Vendor Profile</a></li>
<li><a href="../RFQ/ezListRFQs.jsp?type=List"target="right">Change Address</a></li>
<li><a href="../RFQ/ezListRFQs.jsp?type=List"target="right">Change Password</a></li>
</ul>

<h3 class="headerbar">Options</a></h3>
<ul class="submenu">
<li><a href="../RFQ/ezListRFQs.jsp?type=New"target="right" >Search</a></li>
<li><a href="../RFQ/ezListRFQs.jsp?type=List"target="right">Plant Info</a></li>
<li><a href="../RFQ/ezListRFQs.jsp?type=New"target="right" >FAQ's</a></li>
<li><a href="../RFQ/ezListRFQs.jsp?type=All"target="right">Contact Info</a></li>
</ul>

<h3 class="headerbar"><a  href='../Inbox/ezListPersMsgs.jsp' target="display">mails</a></h3>

<h3 class="headerbar">Support</h3>

</div>

</body>

</html>