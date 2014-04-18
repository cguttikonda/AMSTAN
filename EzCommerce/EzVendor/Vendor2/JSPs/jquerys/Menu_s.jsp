<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<jsp:useBean id="UManager" class="ezc.client.EzUserAdminManager" scope="session" />
<%@ include file="../../Library/Globals/ezBannerErrPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ include file="../../../Includes/JSPs/Misc/iLoginBanner.jsp" %>
<%@ page import="javax.xml.parsers.*,org.w3c.dom.*,javax.xml.transform.*,javax.xml.transform.dom.DOMSource,java.io.FileOutputStream,javax.xml.transform.stream.StreamResult" %>

<html>
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
</script>

<script type="text/javascript">
function callFun(clickedOn)

	{if(clickedOn=='L')
		{
			top.location.href='../Misc/ezLogout.jsp'
		} 
	}

ddaccordion.init({
	headerclass: "headerbar",
	contentclass: "submenu", 
	revealtype: "mouseover", 
	mouseoverdelay: 200,
	collapseprev: true, 
	defaultexpanded: [0],
	onemustopen: true, 
	animatedefault: false,
	persiststate: true, 
	toggleclass: ["", "selected"], 
	togglehtml: ["", "", ""], 
	animatespeed: "normal",
	oninit:function(headers, expandedindices){ 
	},
	onopenclose:function(header, index, state, isuseractivated){
	}
})

</script>

<style type="text/css">

.urbangreymenu{
width: 190px; 
}

.urbangreymenu .headerbar{
font: bold 13px Verdana;
color: white;
background: #5F6444  url(arrowstop.gif) no-repeat 8px 6px;
margin-bottom: 0; 
text-transform: uppercase;
padding: 7px 0 7px 31px; 
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
margin-bottom: 0; 
}

.urbangreymenu ul li{
padding-bottom: 2px;
}

.urbangreymenu ul li a{
font: normal 12px Arial;
color: black;
background: #DFE3CD;
display: block;
padding: 5px 0;
line-height: 17px;
padding-left: 8px; 
text-decoration: none;
}

.urbangreymenu ul li a:visited{
color: black;
}

.urbangreymenu ul li a:hover{ 
color: white;
background: #b0b883;
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