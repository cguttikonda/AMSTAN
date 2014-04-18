<%!
	public String getItemNo(String ItemNo)
	{
		if(ItemNo.length()>13)
		{
			try
			{
				ItemNo = ""+Integer.parseInt(ItemNo.substring(13,18));
			}
			catch(Exception e)
			{
				ItemNo = "&nbsp";
			}
		}
		else
			ItemNo = "&nbsp";
			
		return ItemNo;	
	}
	
	public String getValues(String unit_new,String myvalue)
	{
		if(!"".equals(unit_new) && unit_new!=null)
		{
			myvalue = myvalue.trim();

			int comma_pos_old = myvalue.lastIndexOf(',');	
			if(comma_pos_old != -1)
				myvalue = myvalue.substring(0,comma_pos_old)+"."+myvalue.substring(comma_pos_old+1,myvalue.length());

		}
		
		return myvalue;
		
	}
	
	public String getDateFormat(String dateStr)
	{
		if(dateStr.length()!=8)
			return dateStr;	
			
		dateStr = dateStr.trim();
		dateStr = dateStr.substring(6,8)+"."+dateStr.substring(4,6)+"."+dateStr.substring(0,4);
		
		return dateStr;
	}
	public String getDecFormat(String decStr)
	{
		decStr = decStr.trim();
		if(decStr.indexOf(".")==-1){
			if(decStr.length()>5){
				decStr=decStr.substring(0,(decStr.length()-5))+"."+decStr.substring(decStr.length()-5,(decStr.length()));
			}
			else
			{
				decStr="00000"+decStr; 
				decStr="0."+decStr.substring(decStr.length()-5,decStr.length());
			}
		}
		return decStr;
	}
	
	
	
%>

<%@ include file="../../Library/Globals/errorPagePath.jsp" %>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
<%@ include file="../../../Includes/JSPs/Misc/iblockcontrol.jsp" %>
<%@ include file="../../../Includes/JSPs/Rfq/iGetAmndPOdetails.jsp" %>
<html>
<head>
  <Title>Amendment Details</Title>
<Script>
	var tabHeadWidth=90
	var tabHeight="35%"
</Script>
<Script src="../../Library/JavaScript/ezTabScroll.js"></Script>
<Style>
.tx {
	border:0;
	background-color:#ffffff;
	text-align:left;
	COLOR: #006666;
	FONT-FAMILY: Verdana, Arial;
    	FONT-SIZE: 10px
}
</Style>
</head>
<body scroll=yes>
<form name="myForm">

<%
	ezc.ezutil.FormatDate fd = new ezc.ezutil.FormatDate();
	if("C".equals(POorCon))
		POorCon = "Contract No.";
	else
		POorCon = "Po No.";
	if(finalRet.getRowCount()>0)
	{
%>
		<Table id="header" align=center width="60%" border=0 borderColorDark=#ffffff borderColorLight=#000000  cellspacing="0" cellpadding="2">
			<Tr>
				<Th>Amended Details For <%=POorCon%>: <%=poNum%></Th>
			</Tr>
		</Table>
		
			
		<div style="position:absolute;top:10%;width:100%;visibility:visible;height:40%" align="center">
		<Table align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1  width="90%">
			<Tr>				
				<Th width="33%">HEADER/ITEM</th>
				<Th width="8%">ITEM</th>
				<Th width="33%">CHANGES DONE</th>
				<Th width="13%">OLD VALUE</th>
				<Th width="13%">NEW VALUE</th>
			</Tr>
<%
			String dateStr = null,ItemNo=null,value_old=null,value_new=null,tabName=null;
			ReturnObjFromRetrieve myRet = null;
			Date dt = null;
			int rowCount = finalRet.getRowCount();
			for(int i=0;i<rowCount;i++)
			{
				myRet=(ReturnObjFromRetrieve)finalRet.getFieldValue(i,"RETOBJ");
				dt = (Date)finalRet.getFieldValue(i,"UTIME");
				dateStr = fd.getStringFromDate((Date)finalRet.getFieldValue(i,"UDATE"),"/",ezc.ezutil.FormatDate.MMDDYYYY)+"  "+dt.getHours()+":"+dt.getMinutes()+":"+dt.getSeconds();
%>
				<Tr>
				<Td colspan=5>
				<Table align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1  width="100%">
				   <Tr>
					<Th width="100%" style="background-color: #95b2c1" align="left">Changed By <%=finalRet.getFieldValueString(i,"USERNAME")%>&nbsp; On &nbsp;<%=dateStr%></th>
					
				    </Tr>
				</Table>
				</Td>
				</Tr>
<%
				for(int j=0;j<myRet.getRowCount();j++)
				{
					ItemNo = getItemNo(myRet.getFieldValueString(j,"TABKEY"));
					value_old = getValues(myRet.getFieldValueString(j,"UNIT_NEW"),myRet.getFieldValueString(j,"VALUE_OLD"));
					value_new = getValues(myRet.getFieldValueString(j,"UNIT_NEW"),myRet.getFieldValueString(j,"VALUE_NEW"));
					
					if("DATS".equals(myRet.getFieldValueString(j,"DATATYPE").trim()))
					{					
						value_old = getDateFormat(myRet.getFieldValueString(j,"VALUE_OLD"));
						value_new = getDateFormat(myRet.getFieldValueString(j,"VALUE_NEW"));
												
					}
					
					if("DEC".equals(myRet.getFieldValueString(j,"DATATYPE").trim()))
					{
						value_old = getDecFormat(myRet.getFieldValueString(j,"VALUE_OLD"));
						value_new = getDecFormat(myRet.getFieldValueString(j,"VALUE_NEW"));
					}
					
					
%>
				   <Tr>
<%
					if((myRet.getFieldValueString(j,"TABNAME")).equals(tabName))
					{
%>
						<Td width="33%" >&nbsp;</td>
<%
					}
					else
					{
%>
						<Td width="33%" ><%=myRet.getFieldValueString(j,"TABDESC")%>&nbsp;</td>
<%
					}
%>
				   	<Td width="8%" align="center"><%=ItemNo%>&nbsp;</td>
					<Td width="33%"><%=myRet.getFieldValueString(j,"FDESC")%>&nbsp;</td>
					<Td width="13%" align="right"><%=value_old%>&nbsp;</td>
					<Td width="13%" align="right"><%=value_new%>&nbsp;</td>
					
				   </Tr>
<%
				   tabName = myRet.getFieldValueString(j,"TABNAME");	
				}
				tabName = null;
			}
%>
			</Table>
			<Br><Br>
			


<%	
			buttonName = new java.util.ArrayList();
			buttonMethod = new java.util.ArrayList();

			buttonName.add("Close");
			buttonMethod.add("window.close()");
           		out.println(getButtonStr(buttonName,buttonMethod));

%>
			
 
			
<%
	}
	else
	{
%>
	<div id="buttons" style="position:absolute;top:40%;width:100%;visibility:visible" align="center">
		<Table id="header" align=center width="60%" border=0 borderColorDark=#ffffff borderColorLight=#000000  cellspacing="0" cellpadding="2">
			<Tr>
				<Th>Amended Details Not Found</Th>
			</Tr>
		</Table>
		<Br><Br>
<%
		buttonName.add("Close");
		buttonMethod.add("window.close()");
		out.println(getButtonStr(buttonName,buttonMethod));
%>
	</div>
<%
	}
%>

</form>
<Div id="MenuSol"></Div>
</body>
</html>

<%--


 23 :: 0 Field Name : OBJECTID ----> Field Value : 4100120798
 23 :: 1 Field Name : TABNAME ----> Field Value : EKPO
 23 :: 2 Field Name : TABDESC ----> Field Value : Purchasing Document Item
 23 :: 3 Field Name : FNAME ----> Field Value : MENGE
 23 :: 4 Field Name : FDESC ----> Field Value : Purchase order quantity
 23 :: 5 Field Name : USERNAME ----> Field Value : SUMEETS
 23 :: 6 Field Name : UDATE ----> Field Value : Wed Mar 24 00:00:00 IST 2004
 23 :: 7 Field Name : UTIME ----> Field Value : Thu Jan 01 11:59:10 IST 1970
 23 :: 8 Field Name : TABKEY ----> Field Value : 900410012079800010
 23 :: 9 Field Name : VALUE_OLD ----> Field Value : 250000
 23 :: 10 Field Name : VALUE_NEW ----> Field Value : 100000
 23 :: 11 Field Name : UNIT_OLD ----> Field Value : KG
 23 :: 12 Field Name : UNIT_NEW ----> Field Value : KG
 23 :: 13 Field Name : CUKY_OLD ----> Field Value : 
23 :: 14 Field Name : CUKY_NEW ----> Field Value : 

--%>	
	
	
