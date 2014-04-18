<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>

<html>
<head><title>Attachments</title>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
<script>

var parentObj="";
var docObj="";
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


flag=false
headers = new Array()

function setData(code,description)
{
	this.code = code
	this.description = description
}

//headers[0] = new setData("LOU","Letter Of Undertaking")

headers[0] = new setData("LOU","Document1")

var count=0;
function funClose()
{
   fileName="";
   parentObj.fileName.value=document.myForm.n1.value
   window.close()
}

function setDefaults()
{
   flag=false
   fileValue=parentObj.fileName.value
   document.myForm.n1.value=fileValue
   flag=true;
}

function changeValues(cd)
{
  	 if(cd=='LOU')
  	 {
  	 	parentObj.serverLou.value='¥'
  	 }
}

var attach;
function funAttach(i)
{
    attach=window.open("../Materials/ezAttachFile.jsp?index="+i,"UserWindow1","width=350,height=250,left=150,top=100,resizable=no,scrollbars=no,toolbar=no,menubar=no");
}


function removeFile(x,cod)
{
   document.myForm.n1.value="";
   showAttachments()
   changeValues(cod)
}

function showAttachments()
{

  	if(document.myForm.n1.value=="")
   	{
     	   document.getElementById("remove").style.visibility="hidden"
   	   	   document.getElementById("attach").style.visibility="visible"
  	}
   	else
   	{

   	   document.getElementById("attach").style.visibility="hidden"
   	   document.getElementById("remove").style.visibility="visible"
   	}


}

function funUnLoad()
{
	if(attach!=null && attach.open)
	{
	   attach.close();
	}
}

</script>
</head>

<body onLoad="setDefaults();showAttachments()" topBorder=0 onUnLoad="funUnLoad()">
<form name="myForm"  method="post">

<table width="100%" align=center>
<tr><td><b>Attach Files</b></td></Tr>
<tr><td class="blankcell"><hr></td></Tr>
<tr><td class="blankcell">1.Click on 'Attach File' button to attach a Document.</td></Tr>
</table>
<table width="80%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>
<script>

for(var i=0;i<headers.length;i++)
{

	document.write("<tr>")
	document.write("<th colspan=3 align='left'>"+headers[i].description+"</th>")
	document.write("</tr><tr>")
	document.write("<td align='left'><input type=text class='tx' size='25'  name='n1'>");
	document.write("</td>")
	document.write("<td align=center>");
	document.write("<div style='postion:absolute' id=attach>");
	document.write("<a href=JavaScript:funAttach('"+i+"')><img src='../../Images/Buttons/<%=ButtonDir%>/attachfile.gif' style='cursor:hand' border=none ");
	document.write("</div><div id=remove style='postion:absolute;visibility:hidden'>");
	document.write("<a href=JavaScript:removeFile('"+i+"','"+headers[i].code+"')><img src='../../Images/Buttons/<%=ButtonDir%>/remove.gif' style='cursor:hand' border=none ></a>");
	document.write("</div></td></tr>")
}
</script>
</table>
	<table width="100%" align=center>
	<tr><td class="blankcell"><hr></td></Tr>
	<tr><td class="blankcell">2.Click on 'Done' button after attaching all Files.</td></Tr>
	<tr><td class="blankcell"><a href="JavaScript:window.close()"><img src="../../Images/Buttons/<%=ButtonDir%>/done.gif" style="cursor:hand" border=none onClick="funClose()"><img src="../../Images/Buttons/<%=ButtonDir%>/cancel.gif" style="cursor:hand" border=none ></a></td></Tr>
	<tr><td class="blankcell"><hr></td></Tr>
	</table>

</form>
<Div id="MenuSol"></Div>
</body>
</html>
