<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>

<html>
<head>
<title>Certificate Of Analysis -- Powered By EzCommerce India</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iShowCal.jsp"%>
<%
	String index = request.getParameter("index");
	String coastr= request.getParameter("coastr");
%>
<script src="../../Library/JavaScript/ezTrim.js"></script>
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


var fieldNames = new Array()
var mainFieldNames = new Array()
var index= '<%=index%>'





fieldNames[0] = "desc"
fieldNames[1] = "dimensionsLength"
fieldNames[2] = "dimensionsWidth"
fieldNames[3] = "dimensionsHeight"
fieldNames[4] = "grammage"
fieldNames[5] = "flapCuttings"
fieldNames[6] = "printing"
fieldNames[7] = "shade"
fieldNames[8] = "aqlDefects"


mainFieldNames[0] = "arNum"
mainFieldNames[1] = "dateOfAnal"
mainFieldNames[2] = "dateOfMfg"
mainFieldNames[3] = "noOfBoxes"
mainFieldNames[4] = "specNo"



function closeWindow()
{
    window.close()
}

function setDefaults()
{

//added by nagesh
var coastr="<%=coastr%>"

//alert(coastr);

var coaarr=coastr.split("¤");

if(coaarr[0]=="-")
{
	coaarr[0]="";
}
if(coaarr[2]=="-")
{
	coaarr[2]=""
}
if(coaarr[3]=="-")
{
	coaarr[3]="";
}
if(coaarr[4]=="-")
{
	coaarr[4]="";
}

document.myForm.dcno.value=coaarr[0];
document.myForm.material.value=coaarr[1];
document.myForm.dcdate.value=coaarr[2];
document.myForm.batchno.value=coaarr[3];
document.myForm.batchqty.value=coaarr[4];


///nagesh Ended here


    var data = parentObj.coaLong[index].value
    if(funTrim(data)!="")
    {
    	fieldValues = data.split("§")
    	for(i=0;i<fieldNames.length;i++)
    	{
    	   if(fieldValues[i]!="-")
    	   {
    		eval('document.myForm.'+fieldNames[i]).value=fieldValues[i]
    	   }
    	}
    }

    var data1 = parentObj.coaData[index].value
    if(data1!="")
    {
       	mainFieldValues = data1.split("§")
       	for(i=0;i<mainFieldNames.length;i++)
       	{
       	   if(mainFieldValues[i]!="-")
       	   {
		   		//added by nagesh
		   		if(mainFieldValues[i]=="01.01.1900")
				{
					mainFieldValues[i]="";
				}
				//ended here
       			eval('document.myForm.'+mainFieldNames[i]).value=mainFieldValues[i]
       	   }
      	}
    }


}


function closeWin()
{
  if(document.myForm.arNum.value!="")
  {
    var fieldData="";
    var cnt=0;
    for(i=0;i<fieldNames.length;i++)
    {
	fieldValue=eval('document.myForm.'+fieldNames[i]).value
	if(fieldValue=="")
	{
	  fieldData=fieldData+"-§";
	  cnt++;
	}
	else
	{
	  fieldData=fieldData+fieldValue+"§";
	}
    }

    if(cnt!=fieldNames.length)
    {
    	fieldData = fieldData.substring(0,fieldData.length-1)
    }
    else
    {
    	fieldData = "";
    }

    var mainFieldData="";
    var cnt1=0;
    for(i=0;i<mainFieldNames.length;i++)
    {
	mainFieldValue=eval('document.myForm.'+mainFieldNames[i]).value
	if(mainFieldValue=="")
	{
	  mainFieldData=mainFieldData+"-§";
	  cnt1++;
	}
	else
	{
	  mainFieldData=mainFieldData+mainFieldValue+"§";
	}
    }

    if(cnt1!=mainFieldNames.length)
    {
    	mainFieldData = mainFieldData.substring(0,mainFieldData.length-1)
    }
    else
    {
    	mainFieldData = "";
	fieldData = "";
    }

    parentObj.coaLong[index].value=fieldData
    parentObj.coaData[index].value=mainFieldData
   // alert("*******"+mainFieldData)
    window.close()
  }
  else
  {
     alert("Please Enter AR Number")
     document.myForm.arNum.focus()
  }

}

</script>
</head>

<body onLoad='setDefaults()'>
<form name="myForm">
<TABLE width=40% align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
  <Tr align="center">
      <td class=displayheader>Certificate Of Analysis</Td>
    </Tr>

</Table><br>
	<TABLE width=96% align=center>
	<Tr>
      	<td>
	Use this page for packing material's only. For other materials close this window and use 'Attach File' button.
	</Td>
    	</Tr>
	</Table>

<table width="96%" align="center" border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
  <tr>
      <th width="16%" align="left">Material </th>
      <td width="29%"><input type="text" name="material" class="tx" value="" size=12 readonly></td>
    <th width="16%" align="left">Batch Qty </th>
    <td width="29%"><input type="text" name="batchqty" class="tx" value="" size=12 readonly></td>
  </tr>

  <tr>
      <th width="16%" align="left">Batch No </th>
      <td width="29%"><input type="text" name="batchno" class="tx" value="" size="12" readonly></td>

    <th width="16%" align="left">AR No</th>
    <td width="29%"><input class="InputBox" type="text" name="arNum" maxlength=16  size="12">
</td>
  </tr>
  <tr>
      <th width="16%" align="left">Date Of Analysis </th>
      <td width="29%">
        <input class="InputBox" type="text" name="dateOfAnal" readonly  size="12"><a href='JavaScript:showCal("document.myForm.dateOfAnal",55,150,"<%= cDate%>","<%= cMonth%>","<%= cYear%>")'><img src="../../Images/Common/calender.gif" height="20" style="cursor:hand" border=no></a>
</td>
    <th width="16%"  align="left">Mfg. Date</th>
    <td width="29%"><input class="InputBox" type="text" name="dateOfMfg" readonly  size="12"><a href='JavaScript:showCal("document.myForm.dateOfMfg",55,350,"<%= cDate%>","<%= cMonth%>","<%= cYear%>")'><img src="../../Images/Common/calender.gif" height="20" style="cursor:hand" border=no></a>
</td>
  </tr>
  <tr>

      <th width="16%" height="20" align="left">Ref.Doc No</th>
      <td width="29%" height="20"><input type="text" name="dcno" class="tx" value="" size=12 readonly></td>
	<th width="16%" height="20" align="left">Ref.Doc Date</th>
      <td width="29%" height="20"><input type="text" name="dcdate" class="tx" value="" size=12 readonly></td>
	</td>
  </tr>
  <tr>
      <th width="16%" align="left">Specification No</th>
      <td width="29%"><input class="InputBox" type="text" name="specNo" maxlength=16  size="12">
</td>

      <th width="16%" align="left">No. Of Boxes</th>
      <td width="29%"><input class="InputBox" type="text" name="noOfBoxes" maxlength=16  size="12"></td>
  </tr>
</table>
<br>
<table align="center" width="96%" border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
  <tr>
    <th width="13%">Sl.No</th>
    <th width="24%">Test</th>
    <th width="23%">Result</th>
    <th width="40%">Specification</th>
  </tr>
  <tr>
    <td width="13%">1 .</td>
    <td width="24%">Description</td>
    <td width="23%"><input class=InputBox type="text" name="desc">
</td>
    <td width="40%">As per specification</td>
  </tr>
  <tr>
    <td width="13%">2.</td>
    <td width="24%">Dimensions - Length</td>
    <td width="23%"><input class=InputBox type="text" name="dimensionsLength">
</td>
    <td width="40%">&nbsp;&nbsp;&nbsp;+1.0mm </td>
  </tr>
  <tr>
    <td width="13%">3.</td>
    <td width="24%">Dimensions - Width1</td>
    <td width="23%"><input class=InputBox type="text" name="dimensionsWidth">
</td>
    <td width="40%">&nbsp;&nbsp;&nbsp;+1.0mm </td>
  </tr>
  <tr>
    <td width="13%">4.</td>
    <td width="24%">Dimensions - Height</td>
    <td width="23%"><input class=InputBox type="text" name="dimensionsHeight">
</td>
    <td width="40%">&nbsp;&nbsp;&nbsp;+1.0mm </td>
  </tr>
  <tr>
    <td width="13%">5.</td>
    <td width="24%">Grammage</td>
    <td width="23%"><input class=InputBox type="text" name="grammage">
</td>
    <td width="40%">&nbsp;&nbsp;&nbsp;+5% GSM</td>
  </tr>
  <tr>
    <td width="13%">6.</td>
    <td width="24%">Flap Cuttings</td>
    <td width="23%"><input class=InputBox type="text" name="flapCuttings">
</td>
    <td width="40%">As per method</td>
  </tr>
  <tr>
    <td width="13%">7.</td>
    <td width="24%">Printing</td>
    <td width="23%"><input class=InputBox type="text" name="printing">
</td>
    <td width="40%">
      As per std. App text design & colour scheme.<br>
      Printing should be sharp and free from smudging</td>
  </tr>
  <tr>
    <td width="13%">8.</td>
    <td width="24%">Shade</td>
    <td width="23%"><input class=InputBox type="text" name="shade">
</td>
    <td width="40%">Shall comply with approved standard shade card</td>
  </tr>
  <tr>
    <td width="13%">9.</td>
    <td width="24%">
      AQL DEFECTS: <br>
      &nbsp;&nbsp;&nbsp;> Critical<br>
	  &nbsp;&nbsp;&nbsp;> Major<br>
	  &nbsp;&nbsp;&nbsp;> Minor<br>
	  &nbsp;&nbsp;&nbsp;> Total
    </td>
    <td width="23%"><input class=InputBox type="text" name="aqlDefects">
</td>
    <td width="40%">LIMITS :<br>
	  &nbsp;&nbsp;&nbsp;> Nil<br>
	  &nbsp;&nbsp;&nbsp;> NMT 2.0%<br>
	  &nbsp;&nbsp;&nbsp;> NMT 4.0%<br>
	  &nbsp;&nbsp;&nbsp;> NMT 5.0%
	</td>
  </tr>
</table><br>
<center>
<a href="JavaScript:closeWin()"><img style="cursor:hand" border=none src="../../Images/Buttons/<%=ButtonDir%>/upload.gif" ></a>
<a href="JavaScript:closeWindow()"><img style="cursor:hand" border=none src="../../Images/Buttons/<%=ButtonDir%>/cancel.gif" ></a>
</center>
</form>
<Div id="MenuSol"></Div>
</body>
</html>
