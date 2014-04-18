<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>

<%@ page import="java.util.*" %>
<html>
<head>
<title>All Conditions</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

	<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
<Script>
var tabHeadWidth=96
var tabHeight="65%"
</Script>
	<script src="../../Library/JavaScript/ezTrim.js"></script>
<script src="../../Library/JavaScript/ezTabScroll.js"></Script>
<script>


function allconditions()
{
	var allconditions="";
	var len=document.myForm.CValue.length;
	for(var i=0;i<len;i++)
	{

		if(funTrim(document.myForm.CValue[i].value)=="")
		{
			//allconditions=allconditions+"NA"+"*"+"NA"+"*"+"^"+"#";
			allconditions=allconditions+"NA"+"*"+"^"+"#";
		}
		else
		{
			ctype=document.myForm.CType[i].value;
			//cname=document.myForm.CName[i].value;
			cvalue=document.myForm.CValue[i].value;
			//allconditions=allconditions+ctype+"*"+cname+"*"+cvalue+"#";
			allconditions=allconditions+ctype+"*"+cvalue+"#";
		}
	}


	allconditions=allconditions.substring(0,allconditions.length-1);

	document.myForm.allcond.value=allconditions;
	window.returnValue=allconditions;
	window.close();
}


function funOnLoad()
{
	var values=window.dialogArguments;
	if((values!="")&&(values!="undefined"))
	{
		document.myForm.allcond.value=values;
		var fvalues=values.split("#");
		for(var i=0;i<fvalues.length;i++)
		{
			cvalues=fvalues[i].split("*");
			if(cvalues[1]=="^")
			{
				document.myForm.CValue[i].value="";
			}
			else
			{
				document.myForm.CValue[i].value=cvalues[1];
			}
		}
	}
}

function funCancel()
{
		window.returnValue="Canceld~~"
		window.close()

}

</script>

</head>

<body onLoad="scrollInit();funOnLoad()" onResize="scrollInit()">
<form name="myForm" method="post" >
<%
	ResourceBundle RfqCond= ResourceBundle.getBundle("RFQConditions");
	Enumeration conditions =RfqCond.getKeys();

	java.util.TreeMap conditionsTM = new java.util.TreeMap();	
	while(conditions.hasMoreElements())
	{
		String s=(String)conditions.nextElement();
		conditionsTM.put(s,RfqCond.getString(s));
	}
	Iterator condIterator = conditionsTM.keySet().iterator();
  	Object conditionsObj = new Object();


%>
<DIV id="theads">
	<table id="tabHead" width="95%" border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 align = center >
  	<tr>
    	<th width="20%">Condition Type</th>
    	<th width="55%">Condition Name</th>
    	<th width="25%">Value</th>
  	</tr>
	</table>
	</DIV>

 	<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:96%;height:60%;left:2%">
	<table id="InnerBox1Tab" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0  width="100%">

	<%
      	while(condIterator.hasNext())
	{
		conditionsObj = condIterator.next();
		String condStr = conditionsObj.toString();

	%>	<tr>
		<td width="20%"><input type="hidden" name="CType" value="<%=condStr%>"><%=condStr%></td>
	      	<td width="55%"><%=conditionsTM.get(condStr)%></td>
    		<td width="25%"><input type="text" name="CValue" size="8" align="center" value=""></td></tr>
	<%
	}
	%>

	</table>
	</div>

	<div align=center  STYLE='Position:Absolute;width:100%;top:90%'>
	<img src="../../Images/Buttons/<%=ButtonDir%>/ok.gif" style="cursor:hand" onClick="allconditions()" border=none>
	<img src="../../Images/Buttons/<%=ButtonDir%>/cancel.gif" style="cursor:hand" onClick="funCancel()" border=none>
	</div>
<input type="hidden" name="allcond" value="">
</form>
</body>
</html>
