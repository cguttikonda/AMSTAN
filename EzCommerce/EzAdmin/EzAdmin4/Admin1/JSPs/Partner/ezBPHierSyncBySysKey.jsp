<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ page import="ezc.ezparam.*,ezc.ezmisc.params.*,java.util.*,java.util.zip.*" %>
<%@ page import="com.sap.mw.jco.*,java.util.*" %>
<%@ page import ="ezc.sapconnection.*,com.sap.mw.jco.*,com.sap.mw.jco.JCO" %>
<jsp:useBean id="ezMiscManager" class="ezc.ezmisc.client.EzMiscManager" scope="session"/>
<jsp:useBean id="CatalogMan" class="ezc.client.EzCatalogManager" scope="session"/>
<%@ include file="../../../Includes/JSPs/Config/iListBusAreas.jsp"%>
<%@ include file="../../../Includes/JSPs/Partner/iListBPBySysKey.jsp"%>
<%@ include file="../../../Includes/JSPs/Partner/iBPCustSyncBySysKey.jsp"%>

<%!
	String cust = "";
	String btn = "";
%>
<html>
<head>
<Script src="../../Library/Script/popup.js"></Script>
<Script src="../../Library/JavaScript/ezTabScroll.js"></script>
<Title>Synchronize Base ERP SoldTos</Title>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<script>
function funSynchHier()
{
	
	Popup.showModal('modal');
	document.myForm.action="ezWholeSaleHierExtend.jsp"
	document.myForm.submit();
	
} 
</script>

<Style>
ul
{
    list-style-type: none;
}
</Style>

</head>
<%
	if(ret.getRowCount()!=0)
	{
%>
		<body onLoad='scrollInit()'  onResize='scrollInit()' scroll="no">
<%
	}
	else
	{
%>
		<body>
<%
	}
%>
<br>
<%
	int numBPAreas = 0;
	int numEzc = 0;
	int textBoxCount = 0;
%>
<form name=myForm method=post >
<div id="modal" style="z-index:100;position:absolute;left:280px; top:140px; border:1px solid #EEEDE7; border-radius:7px; background-color:#ffffff; padding:1px; font-size:10;width:330px;height:150px; text-align:center; display:none;">
	<ul>
		<li>&nbsp;</li>
		<li><img src="../../Library/images/loading.gif" width="80" height="80" alt=""></li>
		<li><font size=2><B>Your request is being processed. Please wait...</B></font></li>
	</ul>
</div>

<%
	if(ret.getRowCount()==0)
	{
%>
		<br><br><br><br>
		<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0>
		<Tr>
			<Td class="displayheader" align="center">No Sales Areas To List</Td>
		</Tr>
		</Table>
		<br>
		<center>
			<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
		</center>
<%
		return;
	}
%>
	<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="89%">
  	<Tr align="center">
    		<Td class="displayheader">ERP <%=cTitle%> Data Synchronization</Td>
	</Tr>
	</Table>
	<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="89%">
	<Tr align="center">
	<Th width="16%" align="right"><%=areaLabel.substring(0,areaLabel.length()-1)%></Th>
	<Td width="40%" align = "left">
<%
	String wsk=null;
	for(int i=0;i<ret.getRowCount();i++)
	{
		if(websyskey.equals(ret.getFieldValue(i,SYSTEM_KEY)))
		{
			 wsk=ret.getFieldValueString(i,SYSTEM_KEY_DESCRIPTION);
			 break;
		}
	}
%>
		<a href= "../Config/ezSetBusAreaDefaults.jsp?Area=<%=areaFlag%>&SystemKey=<%=websyskey%>"><%= wsk %> (<%=websyskey%>)&nbsp;</a>
	</Td>
      	<Th width="18%" align="right">Business Partner:</Th>
      	<Td width="26%" align = "left">
<%
	String buspar=null;
	for(int i=0;i<ret1.getRowCount();i++)
	{
		if(Bus_Partner.equals(ret1.getFieldValueString(i,"EBPC_BUSS_PARTNER")))
		{
			 buspar=ret1.getFieldValueString(i,"ECA_COMPANY_NAME");
			 break;
		}
	}
%>
	<a href = "../Partner/ezBPSummaryBySysKey.jsp?WebSysKey=<%=websyskey%>&Area=<%=areaFlag%>&BusinessPartner=<%=Bus_Partner%>"><%=buspar%></a>
      	</Td>
	</Tr>
	</Table>

<%

		String salDef = request.getParameter("chk1");
		
		String bPartner   =  salDef.split("/")[0];		
		String sysKey     =  salDef.split("/")[1];
		String hierCode   =  salDef.split("/")[2];
				
		EzcParams mainParamsMisc= new EzcParams(false);
		EziMiscParams miscParams = new EziMiscParams();
		ReturnObjFromRetrieve retObjMisc = null;

		miscParams.setIdenKey("MISC_SELECT");
		miscParams.setQuery("SELECT top 1 a.ecad_sys_key, (SELECT ECAD_VALUE FROM EZC_CAT_AREA_DEFAULTS WHERE ECAD_SYS_KEY=a.ecad_sys_key AND ECAD_KEY='SALESORG') SALESORG,(SELECT ECAD_VALUE FROM EZC_CAT_AREA_DEFAULTS WHERE ECAD_SYS_KEY=a.ecad_sys_key AND ECAD_KEY='DIVISION') DIVISION,(SELECT ECAD_VALUE FROM EZC_CAT_AREA_DEFAULTS WHERE ECAD_SYS_KEY=a.ecad_sys_key AND ECAD_KEY='DISTRIBUTION') DISTCHNL FROM EZC_CAT_AREA_DEFAULTS a WHERE a.ECAD_SYS_KEY='"+sysKey+"' ");
		mainParamsMisc.setLocalStore("Y");
		mainParamsMisc.setObject(miscParams);
		Session.prepareParams(mainParamsMisc);	

		try
		{		
			retObjMisc = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParamsMisc);
		}
		catch(Exception e)
		{
			out.println("Exception in Getting Data"+e);
		}
		
		String salesOrg="", disChannel="", division="";
		if(retObjMisc!=null && retObjMisc.getRowCount()>0)
		{
			salesOrg 	=  retObjMisc.getFieldValueString(0,"SALESORG");
			disChannel 	=  retObjMisc.getFieldValueString(0,"DISTCHNL");
			division 	=  retObjMisc.getFieldValueString(0,"DIVISION");					
		}
		
		JCO.Client client=null;
		JCO.Function function = null;	

		String [] custObjCols = {"ERPCUSTNUMBER","DIVISION","DISTCHAN","SALESORG"};

		ReturnObjFromRetrieve custRetObj = new ReturnObjFromRetrieve(custObjCols);
		
		
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.YEAR, -15);
		
		
		String site_S = (String)session.getValue("Site");
		String skey_S = "999";
		
		function = EzSAPHandler.getFunction("Z_EZ_GET_BUS_CUSTOMER_MASTER",site_S+"~"+skey_S);
		JCO.ParameterList sapProc = function.getImportParameterList();

		sapProc.setValue("999","SYSTEM_NUM");
		if(salesOrg!=null && !"".equals(salesOrg))
			sapProc.setValue(salesOrg,"SALES_ORG");//salesOrg
		if(disChannel!=null && !"".equals(disChannel))
			sapProc.setValue(disChannel,"DIST_CHANNEL");//disChannel
		if(division!=null && !"".equals(division))
			sapProc.setValue(division,"DIVISION");//Division
			
			sapProc.setValue("","CUSTOMER_NUMBER");

		//sapProc.setValue("WE","PARTNER_FUNCTION");
		sapProc.setValue("EN","LANGUAGE");
		sapProc.setValue(cal.getTime(),"UPDATED_FROM");
		sapProc.setValue(hierCode,"HIGHLEVELCUST");
		ArrayList alCust   = new ArrayList();

		try
		{
			client = EzSAPHandler.getSAPConnection(site_S+"~"+skey_S);
			client.execute(function);
		}
		catch(Exception ec)
		{
			ezc.ezcommon.EzLog4j.log("Exception in Z_EZ_GET_BUS_CUSTOMER_MASTER>>>>>>>"+ec,"I");
		}
		try
		{

			JCO.Table partnerTable 	 =  function.getTableParameterList().getTable("BUS_PARTNERS");

			if ( partnerTable != null )
			{	
				if (partnerTable.getNumRows() > 0)
				{
					
					do
					{
						if(!alCust.contains(partnerTable.getValue("KUNNR")))
						{
							custRetObj.setFieldValue("ERPCUSTNUMBER", partnerTable.getValue("KUNNR"));
							custRetObj.setFieldValue("DIVISION", 	  partnerTable.getValue("SPART"));
							custRetObj.setFieldValue("DISTCHAN",      partnerTable.getValue("VTWEG"));
							custRetObj.setFieldValue("SALESORG",      partnerTable.getValue("VKORG"));
							custRetObj.addRow();
							
						}
						alCust.add(partnerTable.getValue("KUNNR"));
																													
					}while(partnerTable.nextRow());
				}
			}
						
		}
		catch(Exception e)
		{
			ezc.ezcommon.EzLog4j.log("Exception in building data>>>>>>>>>>>>>>>>>>>"+e,"I");
		}
		finally
		{
			if (client!=null)
			{
				JCO.releaseClient(client);
				client = null;
				function=null;
			}
		}
		
		//out.println("custRetObj:::"+custRetObj.toEzcString());
		
		int custRetObjCnt = 	custRetObj.getRowCount();
		
		if(custRetObjCnt>0)
		{
%>
		<input type=hidden name='bPartner' value='<%=bPartner%>'>
		<input type=hidden name='sysKey' value='<%=sysKey%>'>
		<input type=hidden name='hierCode' value='<%=hierCode%>'>
		
		<Table  width="89%" id="InnerBox1Tab" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >

		<Tr>

<%		for(int i=0;i<custRetObjCnt;i++)
		{

		if(i!=0 && i%3==0)
		{
%>	
		</tr><tr>
<%		}
%>

		<Td width = "25%">
		<input type=checkbox name='customer' id='<%=i%>' value ='<%=custRetObj.getFieldValueString(i,"ERPCUSTNUMBER")%>' checked>
		<%=Long.parseLong(custRetObj.getFieldValueString(i,"ERPCUSTNUMBER")) %> 

		</Td>			

<%		}

		if(custRetObjCnt>3 && custRetObjCnt%3!=0)
		{
		custRetObjCnt = 3 - (custRetObjCnt%3);
		for(int i=0;i<custRetObjCnt;i++)
		{
%>				
			<Td width = "33%">&nbsp;</Td>
<%			}

%>
		<Tr>
		</Table>
		
<%		}
%>

		<div id="ButtonDiv" align="center" style="position:absolute;top:80%;width:100%">
		<a href="JavaScript:funSynchHier()"><img src="../../Images/Buttons/<%= ButtonDir%>/synchronize.gif" border=none></a>
		<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>

		</div>
<%		}
		else
		{
%>			
		<br><br><br><br>
		<Table width=75% align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
		<tr>
		<Th colspan=4 width = "25%" align="center">No Customers to Extend for selected Hierarchy Code!</Th>
		</tr>
		</table>
		
		<div id="ButtonDiv" align="center" style="position:absolute;top:80%;width:100%">
			<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
		</div>


<%		}
		
%>
		


</form>
</body>
</html>
