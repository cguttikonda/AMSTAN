<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<jsp:useBean id="StockManager" class="ezc.ezstock.client.EzStockInfoManager" />
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<%@ page import="java.util.*" %>
<%@ page import="ezc.ezparam.*,ezc.ezstock.params.*" %>

<html>
<head>
<title>All Conditions -- Powered By EzCommerce(India) Ltd</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp" %>

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
			for(var j=0;j<document.myForm.CType.length;j++)
			{
			    if(cvalues[0] == document.myForm.CType[j].value )	
			    {
				if(cvalues[1]=="^")
				{
					document.myForm.CValue[j].value="";
				}
				else
				{
					document.myForm.CValue[j].value=cvalues[1];
				}
			     }	
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
	String[] conditions = new String[10];
	
	conditions[0] = "ZAED#Excise Duty (%)";
	conditions[1] = "ZACS#Education CESS (%)";
	conditions[2] = "ZATX#Sales Tax (%)";
	conditions[3] = "ZAPF#Packing and Forwarding";
	conditions[4] = "ZFRC#Freight";
	conditions[5] = "ZACF#C & F Charges";
	conditions[6] = "ZAIN#Insurance (%)";
	conditions[7] = "ZACR#Air / Sea Price";
	conditions[8] = "ZACD#Custom Duties (%)";
	conditions[9] = "RC00#Discount";
	
	/*ResourceBundle RfqCond= ResourceBundle.getBundle("RFQConditions");
	Enumeration conditions =RfqCond.getKeys();

	java.util.TreeMap conditionsTM = new java.util.TreeMap();	
	while(conditions.hasMoreElements())
	{
		String s=(String)conditions.nextElement();
		conditionsTM.put(s,RfqCond.getString(s));
	}
	Iterator condIterator = conditionsTM.keySet().iterator();
  	Object conditionsObj = new Object();*/


%>
<DIV id="theads">
	<table id="tabHead" width="95%" border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1 align = center >
  	<tr>
    	<th width="20%">Condition Type</th>
    	<th width="55%">Condition Name</th>
    	<th width="25%">Value</th>
  	</tr>
	</table>
	</DIV>

 	<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:96%;height:60%;left:2%">
	<table id="InnerBox1Tab" align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1  width="100%">

	<%
      	for(int i=0;i<conditions.length;i++)
	{
		StringTokenizer st = new StringTokenizer(conditions[i],"#");
		String condStr = st.nextToken();
		String conditionsText = st.nextToken();
		

	%>	<tr>
		<td width="20%"><input type="hidden" name="CType" value="<%=condStr%>"><%=condStr%></td>
	      	<td width="55%"><%=conditionsText%></td>
    		<td width="25%"><input type="text" name="CValue" size="8" align="center" value="" class="tx" readonly></td></tr>
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
<Div id="MenuSol"></Div>
</body>
</html>
