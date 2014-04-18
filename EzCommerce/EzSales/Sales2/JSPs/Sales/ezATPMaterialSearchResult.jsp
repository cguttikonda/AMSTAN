<%@page import="ezc.sapconnection.*"%>
<%@page import="com.sap.mw.jco.*"%>
<%@page import="com.sap.mw.jco.JCO,ezc.ezutil.*"%>
<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Lables/iAddSales_Lables.jsp" %>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iShowCal.jsp"%>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<%@ include file="../../../Includes/JSPs/Misc/ezATPSearchInc.jsp"%>
<%
	String searchBy=request.getParameter("searchBy");
	String searchKey=request.getParameter("searchKey");
	//searchBy="M";
	//searchKey="1660225PC";
	
	//searchBy="D";
	//searchKey="1660.225*"; 
	
	ezc.ezparam.EzcParams   myParams	=new ezc.ezparam.EzcParams(true);
	ezc.ezmaterialsearch.client.EzMaterialSearchManager msManager	=new ezc.ezmaterialsearch.client.EzMaterialSearchManager();
	ezc.ezmaterialsearch.params.EziMaterialSearchParams msParams	=new ezc.ezmaterialsearch.params.EziMaterialSearchParams();
	msParams.setClassType(searchBy);
	msParams.setWithValues(searchKey);
	
	myParams.setObject(msParams);
	Session.prepareParams(myParams);
	ezc.ezparam.ReturnObjFromRetrieve retObj = (ezc.ezparam.ReturnObjFromRetrieve)msManager.ezSearchMaterial(myParams);
	
	
	/*ezc.ezparam.ReturnObjFromRetrieve retObj=new ezc.ezparam.ReturnObjFromRetrieve(new String[]{"MATERIAL","MATL_DESC"});
	com.sap.mw.jco.JCO.Function function= EzSAPHandler.getFunction("BAPI_MATERIAL_GETLIST");
	
	JCO.Table  matnrSelTab   = function.getTableParameterList().getTable("MATNRSELECTION");
	if("M".equals(searchBy)){
		matnrSelTab.appendRow();
		matnrSelTab.setValue("I","SIGN");
		matnrSelTab.setValue("CP","OPTION");
 		//matnrSelTab.setValue("1660225PC","MATNR_LOW");
 		matnrSelTab.setValue(searchKey,"MATNR_LOW");
	}
	
 	
 	JCO.Table  matDescSelTab   = function.getTableParameterList().getTable("MATERIALSHORTDESCSEL");
 	if("D".equals(searchBy)){
		matDescSelTab.appendRow();
		matDescSelTab.setValue("I","SIGN");
		matDescSelTab.setValue("CP","OPTION");
		//matDescSelTab.setValue("1660.225*","DESCR_LOW");
		matDescSelTab.setValue(searchKey,"DESCR_LOW");
	}*/	
 	
 	/*JCO.Table  manuFacPartTab   = function.getTableParameterList().getTable("MANUFACTURERPARTNUMB");
	manuFacPartTab.appendRow();
	manuFacPartTab.setValue("CP","MFR_NO");
 	manuFacPartTab.setValue("1660225PC","MANU_MAT");*/
 	
 	
 	
 	/*try{
		JCO.Client client = EzSAPHandler.getSAPConnection();
		client.execute(function);
		EzSAPHandler.commit(client);
		JCO.Table  matnrListTab   = function.getTableParameterList().getTable("MATNRLIST");
		int matnrListTabCount =matnrListTab.getNumRows();
		if(matnrListTabCount>0){
			do{
				retObj.setFieldValue("MATERIAL",matnrListTab.getValue("MATERIAL"));
				retObj.setFieldValue("MATL_DESC",matnrListTab.getValue("MATL_DESC"));
				retObj.addRow();
			}while(matnrListTab.nextRow());
		}

		if (client!=null)
		{
			JCO.releaseClient(client);
			client = null;
			function=null;
		}
 	}catch(Exception err){System.out.println("=====>"+err);}*/
 	
 	int retObjCount =0;
 	if(retObj!=null)
 	retObjCount=retObj.getRowCount();
 	
 	if(retObjCount>0){
 		java.util.Date myDateObj=new Date();
 		myDateObj.setDate(myDateObj.getDate()+1);
 		String myDate= FormatDate.getStringFromDate(myDateObj,".",FormatDate.MMDDYYYY);
 		
%> 		
 		<Table width="100%" id="InnerBox1Tab" border=1 align=right borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
<%		
		for(int i=0;i<retObjCount;i++){
			
%>
			<Tr>
			<Td align='center' width='5%'><input type='checkbox' name='chk' value='<%=retObj.getFieldValueString(i,"MATERIAL")%>'></Td>
			<Td align='left' width='20%'><%=retObj.getFieldValueString(i,"MATERIAL")%>
			<!--<A href="Javascript:matDetails('<%=retObj.getFieldValueString(i,"MATERIAL")%>','<%=(retObj.getFieldValueString(i,"MATL_DESC")).replace('"',' ')%>')" onMouseover="window.status='Click to view material details '; return true" onMouseover="window.status=' '; return true"></A>-->
			<input type='hidden' name='matNo' value='<%=retObj.getFieldValueString(i,"MATERIAL")%>'>
			</Td>
			<Td align='left' width='45%'><input type='hidden' name='matDesc' value='<%=retObj.getFieldValueString(i,"MATL_DESC")%>'><%=retObj.getFieldValueString(i,"MATL_DESC")%></Td>
			<Td align='center' width='10%'>EA<input type='hidden'  name='uom' value='EA'></Td>
			<!--
			<Td align='center' width='20%'>
			-->
			<input type='hidden' class='InputBox'  name='reqDate<%=i%>' value='<%=myDate%>' size='12' readonly>
			
			<!--
			</Td>
			<Td align='center' width='15%'>
			-->
			<input type='hidden' class='InputBox' size='8' name='quantity' onBlur="checkNum(this)" value='0'>
			</Td>
			<Td align='center' width='20%'>
				<a href="javascript:getATP('<%=i%>');" >ATP
				
				<%//if(retObjCount<6){%>
				
					<%--=getATPQuantity(retObj.getFieldValueString(i,"MATERIAL"),myDate,"0","EA",Session,(String)session.getValue("SHOWATP"),(String)session.getValue("ATPPLANT"))--%>
				<%//}else{%>
				<!--img src="../../Images/atp.gif" height="15" border="none" valign="center" -->
				<%//}%>
				</a>
			</Td>
			</Tr>
<%
			
			
		}
		out.println("</Table>");
	}else{
		out.println("µ0");
	}
	out.println("¥"+0);
	out.println("¥"+"TERMINATE");

 	
	
%>
<Div id="MenuSol"></Div> 