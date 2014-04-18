<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>

<%@page import="ezc.ezutil.*"%>
<%@page import="java.util.*"%>
<%@include file="../../../Includes/JSPs/Materials/iViewCertificate.jsp"%>
<%@include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<html>
<head>
<title>Certificate Of Analysis -- Powered By EzCommerce India</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%
		FormatDate fd = new FormatDate();
		String coastr= request.getParameter("coastr");
%>
<script>
var fieldValue='';
var fieldNames = new Array();
fieldNames[0] = "desc"
fieldNames[1] = "dimensionsLength"
fieldNames[2] = "dimensionsWidth"
fieldNames[3] = "dimensionsHeight"
fieldNames[4] = "grammage"
fieldNames[5] = "flapCuttings"
fieldNames[6] = "printing"
fieldNames[7] = "shade"
fieldNames[8] = "aqlDefects"

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


   <%
     if(Count>0)
     {
	 boolean flag=false;
      	 for(int i=0;i<coaFields.length;i++)
       	 {
	    flag=false;
   	    for(int j=0;j<Count;j++)
	    {
		if(coaFields[i].equals(retOther.getFieldValueString(j,"KEYS")))
		{
   %>
		   fieldValue='<%=retOther.getFieldValueString(j,"VALUE1")%>'


    <%  	   	   flag=true;
		   break;
		}
	    }
    %>
	    eval("document.myForm."+fieldNames['<%=i%>']).value = fieldValue
	    fieldValue = ''	
    <%	 }
     }
   %>
}

</script>
</head>
<body onLoad="setDefaults()">
<form name="myForm" >
<TABLE width=40% align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
  <Tr align="center">
      <td class=displayheader>Certificate Of Analysis</Td>
    </Tr>

</Table><br>
<table width="90%" align="center" border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
  <tr>
      <th width="16%" align="left">Material :</th>
      <td width="29%"><input type="text" class="tx" name="material" size=12 readonly></td>
      <th width="16%" align="left">Batch Qty :</th>
      <td width="29%"><input type="text" class="tx"  name="batchqty" size=12 readonly></td>
  </tr>

  <tr>
      <th width="16%" align="left">Batch No :</th>
      <td width="29%"><input type="text" class="tx" name="batchno" size=12 readonly></td>
      <th width="16%" align="left">A.R.No. :</th>
    <%
	   String arNumber=ret.getFieldValueString(0,"ARNUMBER");
           arNumber = arNumber.equals("null")? "":arNumber;
    %>
      <td width="29%"><%=arNumber%>&nbsp;</td>
  </tr>
  <tr>
      <th width="16%" align="left">Date Of Analysis</th>
       <%
	   String dateOfAnal=FormatDate.getStringFromDate((java.util.Date)ret.getFieldValue(0,"DATEOFANALYSIS"),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")));
	 
   
          	   dateOfAnal = (dateOfAnal.equals("null") || dateOfAnal.equals("01"+(String)session.getValue("DATESEPERATOR")+"01"+(String)session.getValue("DATESEPERATOR")+"1900")) ? "":fd.getStringFromDate((Date)ret.getFieldValue(0,"DATEOFANALYSIS"),".",FormatDate.DDMMYYYY);
   %>

      <td width="29%"><%=dateOfAnal%>&nbsp;</td>
    <th width="16%" align="left">Mfg. Date</th>
       <%
	   String dateOfMfg=FormatDate.getStringFromDate((java.util.Date)ret.getFieldValue(0,"DATEOFMFG"),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")));
           dateOfMfg = (dateOfMfg.equals("null") || dateOfMfg.equals("01"+(String)session.getValue("DATESEPERATOR")+"01"+(String)session.getValue("DATESEPERATOR")+"1900")) ? "":fd.getStringFromDate((Date)ret.getFieldValue(0,"DATEOFMFG"),".",FormatDate.DDMMYYYY);
	%>
   <td width="29%"><%=dateOfMfg%>&nbsp;</td>
  </tr>
  <tr>
      <th width="16%"  align="left">Date :</th>
      <td width="29%"><input type="text" name="dcdate" class="tx" size=12 readonly>
      <th width="16%" align="left">DC No :</th>
      <td width="29%"><input type="text" name="dcno" class="tx" size=12 readonly></td>


</td>
  </tr>
  <tr>
      <th width="16%" align="left">Specification No. :</th>
      <%
	   String specNumber=ret.getFieldValueString(0,"SPECNUMBER");
           specNumber = specNumber.equals("null")? "":specNumber;
      %>
      <td width="29%"><%=specNumber%>&nbsp;</td>
      <th width="16%" align="left">No. Of Boxes :</th>
       <%
	   String boxes=ret.getFieldValueString(0,"BOXES");
           boxes = boxes.equals("null")? "":boxes;
      %>
      <td width="29%"><%=boxes%>&nbsp;</td>

  </tr>
</table>
<br>
<table align="center" width="90%" border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
  <tr>
    <th width="13%">Sl.No</th>
    <th width="24%">Test</th>
    <th width="23%">Result</th>
    <th width="40%">Specification</th>
  </tr>
  <tr>
    <td width="13%">1 .</td>
    <td width="24%">Description</td>
    <td width="23%"><input class="tx" type="text" name="desc" readonly>
</td>
    <td width="40%">As per specification</td>
  </tr>
  <tr>
    <td width="13%">2.</td>
    <td width="24%">Dimensions - Length</td>
    <td width="23%"><input class="tx" type="text" name="dimensionsLength" readonly>
</td>
    <td width="40%">&nbsp;&nbsp;&nbsp;+1.0mm </td>
  </tr>
  <tr>
    <td width="13%">3.</td>
    <td width="24%">Dimensions - Width1</td>
    <td width="23%"><input class="tx" type="text" name="dimensionsWidth" readonly>
</td>
    <td width="40%">&nbsp;&nbsp;&nbsp;+1.0mm </td>
  </tr>
  <tr>
    <td width="13%">4.</td>
    <td width="24%">Dimensions - Height</td>
    <td width="23%"><input class="tx" type="text" name="dimensionsHeight" readonly>
</td>
    <td width="40%">&nbsp;&nbsp;&nbsp;+1.0mm </td>
  </tr>
  <tr>
    <td width="13%">5.</td>
    <td width="24%">Grammage</td>
    <td width="23%"><input class="tx" type="text" name="grammage" readonly>
</td>
    <td width="40%">&nbsp;&nbsp;&nbsp;+5% GSM</td>
  </tr>
  <tr>
    <td width="13%">6.</td>
    <td width="24%">Flap Cuttings</td>
    <td width="23%"><input class="tx" type="text" name="flapCuttings" readonly>
</td>
    <td width="40%">As per method</td>
  </tr>
  <tr>
    <td width="13%">7.</td>
    <td width="24%">Printing</td>
    <td width="23%"><input class="tx" type="text" name="printing" readonly>
</td>
    <td width="40%">
      As per std. App text design & colour scheme.<br>
      Printing should be sharp and free from smudging</td>
  </tr>
  <tr>
    <td width="13%">8.</td>
    <td width="24%">Shade</td>
    <td width="23%"><input class="tx" type="text" name="shade" readonly>
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
    <td width="23%"><input class="tx" type="text" name="aqlDefects" readonly>
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
<img style="cursor:hand" border=none src="../../Images/Buttons/<%=ButtonDir%>/ok.gif" onClick="window.close()">
</center>
</form>
<Div id="MenuSol"></Div>
</body>
</html>
