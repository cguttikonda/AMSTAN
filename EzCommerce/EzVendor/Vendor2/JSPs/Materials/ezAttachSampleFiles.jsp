<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>

<html>
<head><title>Upload File</title>
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


var count=0;

function funClose()
{
   fileName="";
   fileCount=0;
   for(var i=0;i<document.myForm.n1.length;i++)
   {
       fieldValue=document.myForm.n1[i].value;
       if(fieldValue=="")
       {
       	  fieldValue="-";
       	  count++;
       }
       else
       {
	 fileCount++;
       }
       fileName = fileName+fieldValue+"^"

   }

   if(count!=document.myForm.n1.length)
   {
   	fileName = fileName.substring(0,fileName.length-1)
   }
   else
   {
   	fileName ="";
   }

   parentObj.fileName.value=fileName
   parentObj.files.value=fileCount
   window.close()
}

function setDefaults()
{

   fileValue=parentObj.fileName.value
   if(fileValue!="")
   {
   	var files = fileValue.split("^")
   	for(var j=0;j<files.length;j++)
   	{
   	    if(files[j]!="-")
    	{
	   	  document.myForm.n1[j].value=files[j]
	    }
   	}

   }
   showAttachments()	
}

var attach;
function funAttach(i)
{
    attach=window.open("../Materials/ezAttachFile.jsp?index="+i,"UserWindow1","width=450,height=250,left=150,top=100,resizable=yes,scrollbars=yes,toolbar=no,menubar=no");
}

function funUnLoad()
{
	if(attach!=null && attach.open)
	{
	  attach.close();
	}
}


function removeFile(x)
{

   document.myForm.n1[x].value="";
   showAttachments();

}


function showAttachments()
{
   for(var i=0;i<document.myForm.n1.length;i++)
   {
   	if(document.myForm.n1[i].value=="")
   	{
   	   document.getElementById("remove"+i).style.visibility="hidden"
   	   document.getElementById("attach"+i).style.visibility="visible"
  	}
   	else
   	{
   	   document.getElementById("attach"+i).style.visibility="hidden"
   	   document.getElementById("remove"+i).style.visibility="visible"
   	}

   }

}

</script>
</head>

<body onLoad="showAttachments();setDefaults()" onUnLoad="funUnLoad()">
<form name="myForm" method="post">
<table width="100%" align=center>
<tr><td><b>Attach Files</b></td></Tr>
<tr><td class="blankcell"><hr></td></Tr>
<tr><td class="blankcell">1.Click on 'Attach File' button to attach a Document.</td></Tr>
</table>

<table width="80%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>

<tr>
<th colspan=3 align="left">Process Flow Diagram</th>
</tr>
<tr>
<td align="left"><input type=text size="25" class="tx"  value="" name="n1" ></td>
<td align=center><div style="postion:absolute" id="attach0"><img src="../../Images/Buttons/<%=ButtonDir%>/attachfile.gif" style="cursor:hand" border=none onclick="funAttach(0)"></div><div id="remove0" style="postion:absolute;visibility:hidden"><img src="../../Images/Buttons/<%=ButtonDir%>/remove.gif" style="cursor:hand" border=none onclick="removeFile(0)"></div></td>
</tr>

<tr>
<th colspan=3 align="left">Reaction Mechanism (Synthetic Mechanism)</th>
</tr>
<tr>
<td align="left"><input type=text size="25" class="tx"  value="" name="n1" ></td>
<td align=center><div style="postion:absolute" id="attach1"><img src="../../Images/Buttons/<%=ButtonDir%>/attachfile.gif" style="cursor:hand" border=none onclick="funAttach(1)" ></div><div id="remove1" style="postion:absolute;visibility:hidden"><img src="../../Images/Buttons/<%=ButtonDir%>/remove.gif" style="cursor:hand" border=none onclick="removeFile(1)"></div></td>
</tr>

<tr>
<th colspan=3 align="left">Specification</th>
</tr>
<tr>
<td align="left"><input type=text size="25" class="tx"  value="" name="n1" ></td>
<td align=center><div style="postion:absolute" id="attach2"><img src="../../Images/Buttons/<%=ButtonDir%>/attachfile.gif" style="cursor:hand" border=none onclick="funAttach(2)" ></div><div id="remove2" style="postion:absolute;visibility:hidden"><img src="../../Images/Buttons/<%=ButtonDir%>/remove.gif" style="cursor:hand" border=none onclick="removeFile(2)"></div></td>
</tr>

<tr>
<th colspan=3 align="left">Brief Description of Process</th>
</tr>
<tr>
<td align="left"><input type=text size="25" class="tx"  value="" name="n1" ></td>
<td align=center><div style="postion:absolute" id="attach3"><img src="../../Images/Buttons/<%=ButtonDir%>/attachfile.gif" style="cursor:hand" border=none onclick="funAttach(3)" ></div><div id="remove3" style="postion:absolute;visibility:hidden"><img src="../../Images/Buttons/<%=ButtonDir%>/remove.gif" style="cursor:hand" border=none onclick="removeFile(3)"></div></td>
</tr>

<tr>
<th colspan=3 align="left">Method Of Analysis</th>
</tr>
<tr>
<td align="left"><input type=text size="25" class="tx"  value="" name="n1" ></td>
<td align=center><div style="postion:absolute" id="attach4"><img src="../../Images/Buttons/<%=ButtonDir%>/attachfile.gif" style="cursor:hand" border=none onclick="funAttach(4)" ></div><div id="remove4" style="postion:absolute;visibility:hidden"><img src="../../Images/Buttons/<%=ButtonDir%>/remove.gif" style="cursor:hand" border=none onclick="removeFile(4)"></div></td>
</tr>

<tr>
<th colspan=3 align="left">Material Safety Data Sheet</th>
</tr>
<tr>
<td align="left"><input type=text size="25" class="tx"  value="" name="n1" ></td>
<td align=center><div style="postion:absolute" id="attach5"><img src="../../Images/Buttons/<%=ButtonDir%>/attachfile.gif" style="cursor:hand" border=none onclick="funAttach(5)" ></div><div id="remove5" style="postion:absolute;visibility:hidden"><img src="../../Images/Buttons/<%=ButtonDir%>/remove.gif" style="cursor:hand" border=none onclick="removeFile(5)"></div></td>
</tr>

<tr>
<th colspan=3 align="left">Stability Data</th>
</tr>
<tr>
<td align="left"><input type=text size="25" class="tx"  value="" name="n1" ></td>
<td align=center><div style="postion:absolute" id="attach6"><img src="../../Images/Buttons/<%=ButtonDir%>/attachfile.gif" style="cursor:hand" border=none onclick="funAttach(6)" ></div><div id="remove6" style="postion:absolute;visibility:hidden"><img src="../../Images/Buttons/<%=ButtonDir%>/remove.gif" style="cursor:hand" border=none onclick="removeFile(6)"></div></td>
</tr>
</table><br>
<table width="80%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>
<tr>
<th colspan=3 align="left">DC Document</th>
</tr>
<tr>
<td align="left"><input type=text size="25" class="tx"  value="" name="n1" ></td>
<td align="center"><div style="postion:absolute" id="attach7"><img src="../../Images/Buttons/<%=ButtonDir%>/attachfile.gif" style="cursor:hand" border=none onclick="funAttach(7)" ></div><div id="remove7" style="postion:absolute;visibility:hidden"><img src="../../Images/Buttons/<%=ButtonDir%>/remove.gif" style="cursor:hand" border=none onclick="removeFile(7)"></div></td>
</tr>

<tr>
<th colspan=3 align="left">LR Document</th>
</tr>
<tr>
<td align="left"><input type=text size="25" class="tx"  value="" name="n1" ></td>
<td align="center"><div style="postion:absolute" id="attach8"><img src="../../Images/Buttons/<%=ButtonDir%>/attachfile.gif" style="cursor:hand" border=none onclick="funAttach(8)" ></div><div id="remove8" style="postion:absolute;visibility:hidden"><img src="../../Images/Buttons/<%=ButtonDir%>/remove.gif" style="cursor:hand" border=none onclick="removeFile(8)"></div></td>
</tr>

<tr>
<th colspan=3 align="left">Packing Document</th>
</tr>
<tr>
<td align="left"><input type=text size="25" class="tx"  value="" name="n1" ></td>
<td align="center"><div style="postion:absolute" id="attach9"><img src="../../Images/Buttons/<%=ButtonDir%>/attachfile.gif" style="cursor:hand" border=none onclick="funAttach(9)" ></div><div id="remove9" style="postion:absolute;visibility:hidden"><img src="../../Images/Buttons/<%=ButtonDir%>/remove.gif" style="cursor:hand" border=none onclick="removeFile(9)"></div></td>
</tr>

<tr>
<th colspan=3 align="left">Invoice (Excise) Document</th>
</tr>
<tr>
<td align="left"><input type=text size="25" class="tx"  value="" name="n1" ></td>
<td align="center"><div style="postion:absolute" id="attach10"><img src="../../Images/Buttons/<%=ButtonDir%>/attachfile.gif" style="cursor:hand" border=none onclick="funAttach(10)" ></div><div id="remove10" style="postion:absolute;visibility:hidden"><img src="../../Images/Buttons/<%=ButtonDir%>/remove.gif" style="cursor:hand" border=none onclick="removeFile(10)"></div></td>
</tr>

<tr>
<th colspan=3 align="left">Impurity Profile</th>
</tr>
<tr>
<td align="left"><input type=text size="25" class="tx"  value="" name="n1" ></td>
<td align="center"><div style="postion:absolute" id="attach11"><img src="../../Images/Buttons/<%=ButtonDir%>/attachfile.gif" style="cursor:hand" border=none onclick="funAttach(11)" ></div><div id="remove11" style="postion:absolute;visibility:hidden"><img src="../../Images/Buttons/<%=ButtonDir%>/remove.gif" style="cursor:hand" border=none onclick="removeFile(11)"></div></td>
</tr>

<tr>
<th colspan=3 align="left">Solvent - List</th>
</tr>
<tr>
<td align="left"><input type=text size="25" class="tx"  value="" name="n1" ></td>
<td align="center"><div style="postion:absolute" id="attach12"><img src="../../Images/Buttons/<%=ButtonDir%>/attachfile.gif" style="cursor:hand" border=none onclick="funAttach(12)" ></div><div id="remove12" style="postion:absolute;visibility:hidden"><img src="../../Images/Buttons/<%=ButtonDir%>/remove.gif" style="cursor:hand" border=none onclick="removeFile(12)"></div></td>
</tr>

<tr>
<th colspan=3 align="left">Chromotogram</th>
</tr>
<tr>
<td align="left"><input type=text size="25" class="tx"  value="" name="n1" ></td>
<td align="center"><div style="postion:absolute" id="attach13"><img src="../../Images/Buttons/<%=ButtonDir%>/attachfile.gif" style="cursor:hand" border=none onclick="funAttach(13)" ></div><div id="remove13" style="postion:absolute;visibility:hidden"><img src="../../Images/Buttons/<%=ButtonDir%>/remove.gif" style="cursor:hand" border=none onclick="removeFile(13)"></div></td>
</tr>



</table>
<br>

<table width="80%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>
<tr>
<th colspan=2 align="left">COA Documents</th>
</tr>
<tr>
<td align="left"><input type=text size="25" class="tx"  value="" name="n1" ></td>
<td align=center><div style="postion:absolute" id="attach14"><img src="../../Images/Buttons/<%=ButtonDir%>/attachfile.gif" style="cursor:hand" border=none onclick="funAttach(14)" ></div><div id="remove14" style="postion:absolute;visibility:hidden"><img src="../../Images/Buttons/<%=ButtonDir%>/remove.gif" style="cursor:hand" border=none onclick="removeFile(14)"></div></td>
</tr>
<tr>
<td align="left"><input type=text size="25" class="tx"  value="" name="n1" ></td>
<td align=center><div style="postion:absolute" id="attach15"><img src="../../Images/Buttons/<%=ButtonDir%>/attachfile.gif" style="cursor:hand" border=none onclick="funAttach(15)" ></div><div id="remove15" style="postion:absolute;visibility:hidden"><img src="../../Images/Buttons/<%=ButtonDir%>/remove.gif" style="cursor:hand" border=none onclick="removeFile(15)"></div></td>
</tr>
<tr>
<td align="left"><input type=text size="25" class="tx"  value="" name="n1" ></td>
<td align=center><div style="postion:absolute" id="attach16"><img src="../../Images/Buttons/<%=ButtonDir%>/attachfile.gif" style="cursor:hand" border=none onclick="funAttach(16)"></div><div id="remove16" style="postion:absolute;visibility:hidden"><img src="../../Images/Buttons/<%=ButtonDir%>/remove.gif" style="cursor:hand" border=none onclick="removeFile(16)"></div></td>
</tr>
</table>

	<table width="100%" align=center>
	<tr><td class="blankcell"><hr></td></Tr>
	<tr><td class="blankcell">2.Click on 'Done' button after attaching all Files.</td></Tr>
	<tr><td class="blankcell"><img src="../../Images/Buttons/<%=ButtonDir%>/done.gif" style="cursor:hand" border=none onClick="funClose()"><img src="../../Images/Buttons/<%=ButtonDir%>/cancel.gif" style="cursor:hand" border=none onClick="window.close()"></td></Tr>
	<tr><td class="blankcell"><hr></td></Tr>
	</table>

</form>
<Div id="MenuSol"></Div>
</body>
</html>
