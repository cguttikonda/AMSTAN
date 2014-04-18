<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@include file="../../../Includes/Lib/ezAddButtonDir.jsp" %>
<%
    	String type        = request.getParameter("type");
    	String prdCode     = request.getParameter("prdCode");
    	String vendCatalog = request.getParameter("vendCatalog");
    	String matId       = request.getParameter("matId");
    	String dirName     = request.getParameter("dirName");
    	String attachFile  = request.getParameter("filename");
%>


<html>
<head>
<title> </title>
<script>
var parentObj="";
var docObj="";

var prdCode="<%=prdCode%>";
var vendCatalog="<%=vendCatalog%>";
var matId="<%=matId%>";
var type="<%=type%>";
var dirName="<%=dirName%>";
var attachFile="<%=attachFile%>";

if(!document.all)
{
  parentObj = opener.document.myForm
  docObj = opener.document
}
else
{
  parentObj = parent.opener.myForm
  docObj = parent.opener.document
}
function Initialize()
{
	try
	{
		req=new ActiveXObject("Msxml2.XMLHTTP");
	}
	catch(e)
	{
		try
		{
			req=new ActiveXObject("Microsoft.XMLHTTP");
		}
		catch(oc)
		{
			req=null;
		}
	} 
	if(!req&&typeof XMLHttpRequest!="undefined")
	{
		req=new XMLHttpRequest();
	}
 }
function SendQuery(type,attach,dir)
{
	Initialize();
	var url=location.protocol+"//<%=request.getServerName()%>/CRI/EzCommerce/EzSales/Sales2/JSPs/Uploads/ezSaveMaterialDocs.jsp?type="+type+"&attachFile="+attach+"&prdCode="+prdCode+"&vendCatalog="+vendCatalog+"&matId="+matId+"&dirName="+dir; 
        
	if(req!=null)
	{
		req.onreadystatechange = Process;
		req.open("GET", url, true);
		req.send(null);

	}
}
function Process()
{

	if (req.readyState == 4)
	{
	   if (req.status == 200)
	   {
			
	   }
	}
}	
function funClose()
{
	var attachfile = document.myForm.n1.value;
	var dirName    = document.myForm.dirName.value;
	/*
	var index=document.myForm.index.value;
	docObj.myForm.n1.value =document.myForm.n1.value;
	docObj.myForm.dirName.value =document.myForm.dirName.value;
	
	if(docObj.getElementById("textn1"+index)!=null)
	{
	   docObj.myForm.n2[index].value=document.myForm.n1.value;
	}
	*/
	SendQuery(type,attachfile,dirName);
	 
	parentObj.submit();
	parent.window.close();  
}
</script>
</head>
<form name=myForm>
<input type="hidden" name="prdCode">
<input type="hidden" name="vendCatalog">
<input type="hidden" name="matId">
<body scroll=no>
<%
	String index=request.getParameter("index");
	
%>
<br>
<TABLE width="90%" align=left>
<tr><td class="blankcell"><b>Files Attached.</b></Td></Tr>
<tr><td class="blankcell"><hr></Td></Tr>
<tr><td class="blankcell">The following file has been attached: </Td></Tr>
<tr><td class="blankcell"><%=attachFile%></Td></Tr>
<tr><td class="blankcell"><hr></Td></Tr>
<tr><td class="blankcell">Click on the 'Done' button</Td></Tr>
<tr><td class="blankcell"><input type="button" name="Done" value="Done" onclick="funClose()"></Td></Tr>
<tr><td class="blankcell"><hr></Td></Tr>
</table>
<input type="hidden" name="n1" value="<%=attachFile%>" >
<input type="hidden" name="dirName" value="<%=dirName%>" >
<input type="hidden" name="index" value='<%=session.getValue("INDEX")%>' >
</form>
<Div id="MenuSol"></Div>
</body>
</html>
