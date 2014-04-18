<%@ page language="java" errorPage="../Misc/ezErrorDisplay.jsp"%>
<%@ include file="../../../Includes/JSPs/Threshold/iGetThreshold.jsp"%>
<Html>
<Head>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<Script>
	var tabHeadWidth=60
	var tabHeight="50%"
</Script>
<Script src="../../Library/JavaScript/Scroll/ezTabScroll.js"></Script>
<Script src="../../Library/JavaScript/ezTrim.js"></Script>
<Script>
	function funAdd()
	{
		document.myForm.action="ezAddThreshold.jsp";
		document.myForm.submit();
	}
	function funDelete()
	{
		var len = document.myForm.rdThNum.length;
		var cnt = 0;
		var chkTh = "";

		if(isNaN(len))
		{
			if(document.myForm.rdThNum.checked)
			{
				chkTh = document.myForm.rdThNum.value;
				cnt++;
			}
		}
		else
		{	
			for(i=0;i<len;i++)
			{	
				if(document.myForm.rdThNum[i].checked)
				{
					chkTh = document.myForm.rdThNum[i].value;
					cnt++;
					break;
				}
			}
		}
		if(cnt==0)
		{
			alert("Please Select a Threshold to Delete");
			return
		}
		else
		{
			var y = confirm("Are you sure to Delete?");
			
			if(eval(y))
			{
				document.myForm.action="ezDelThreshold.jsp?threshNo="+chkTh;
				document.myForm.submit();
			}
		}
	}	
</Script>
</Head>
<Body  onLoad="scrollInit()" onResize="scrollInit()" scroll="no" >
<Form name=myForm method=post >
<br><br><br>

	<Div align=center>
<%
	boolean delFlag = false;

	if(retThresholdsCount>0)
	{
%>
	<div id="theads">
	<Table width="60%" id="tabHead" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0>
	<Tr>
		<Th align="center" valign="middle" width="5%">&nbsp;</Th>
		<Th align="center" valign="middle" width="40%">Manufacturer</Th>
		<Th align="center" valign="middle" width="40%">Item Category</Th>
		<Th align="center" valign="middle" width="15%">Threshold</Th>
	</Tr>
	</Table>
	</div>
	<div id="InnerBox1Div" style="overflow:auto;position:absolute;width:60%;height:50%">
	<Table width="100%" id="InnerBox1Tab" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>
<%
		for(int i=0;i<retThresholdsCount;i++)
		{
			delFlag = true;
			
			String thNum 	= retThresholds.getFieldValueString(i,"EDT_TH_NO");
			String mfrID 	= retThresholds.getFieldValueString(i,"EDT_MFR_ID");
			String itemCat	= retThresholds.getFieldValueString(i,"EDT_PROD_CAT");
			String threshold = retThresholds.getFieldValueString(i,"EDT_THRESHOLD");
			
			String itemCatDesc = (String)itemCatHash.get(itemCat);
			
			if(itemCatDesc==null || "null".equals(itemCatDesc)) itemCatDesc = "";
%>
		<Tr>
			<Td align="center" valign="top" width="5%"><input type="radio" name="rdThNum" value="<%=thNum%>"></Td>
			<Td align="left" valign="top" width="40%">&nbsp;<%=mfrID%> --> <%=(String)manfIdHash.get(mfrID)%></Td>
			<Td align="left" valign="top" width="40%">&nbsp;<%=itemCatDesc%></Td>
			<Td align="right" valign="top" width="15%">&nbsp;<%=threshold%> %</Td>
		</Tr>
<%
		}
%>
	</Table>
	</div>
<%
	}
	else
	{
%>
	<br><br><br><br>
	<Table   width="60%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	<Tr>
		<Th>No threshold created. Click on Add to create.</Th>
	</Tr>
	</Table>
<%
	}
%>
	</Div>
	<Div id="ButtonDiv" align="center" style="position:absolute;top:90%;width:100%">
		<a href="JavaScript:funAdd()"><img src="../../Images/Buttons/<%=ButtonDir%>/add.gif" border=none></a>
<%
		if(delFlag)
		{
%>		
		<a href="JavaScript:funDelete()"><img src="../../Images/Buttons/<%=ButtonDir%>/delete.gif" border=none></a>
<%
		}
%>
	</Div>
</Form>
</Body>
</Html>