<%@ page import = "java.util.*"%>
<%@ page import = "ezc.ezutil.FormatDate"%>
<%@ page import ="ezc.ezutil.*" %>
<%@ page import ="ezc.ezparam.*" %>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"/>

<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>

<%
	String matCode = request.getParameter("MatNo");
	//String id 	= request.getParameter("ID");
	if(matCode!=null)
	matCode=matCode.replace('*','%');
	
	ArrayList mat = new ArrayList();
	ArrayList Desc = new ArrayList();
	ArrayList Uom = new ArrayList();
	String skey=(String) session.getValue("SalesAreaCode");
	 
	ezc.ezprojections.client.EzProjectionsManager ProjManager1 = new ezc.ezprojections.client.EzProjectionsManager();
	ezc.ezparam.EzcParams ezcpparams1 = new ezc.ezparam.EzcParams(true);

	ezc.ezprojections.params.EziProjectionHeaderParams inparamsProj1=new ezc.ezprojections.params.EziProjectionHeaderParams();
	
	inparamsProj1.setSystemKey(skey+"') AND EMM_NO LIKE ('"+matCode);
	//inparamsProj.setSystemKey("999666') AND EMM_NO LIKE ('%A%");
	//inparamsProj.setUserCatalog((String) session.getValue("CatalogCode"));
	
	//inparamsProj.setUserCatalog("14280");
	ezcpparams1.setObject(inparamsProj1);
	ezcpparams1.setLocalStore("Y");
	
	Session.prepareParams(ezcpparams1);
	
	
	 	
	ezc.ezparam.ReturnObjFromRetrieve retpro1 = (ezc.ezparam.ReturnObjFromRetrieve)ProjManager1.ezGetMaterialsByCountry(ezcpparams1);
	
	
	if(retpro1!=null && retpro1.getRowCount()>0){
		for(int i=0;i<retpro1.getRowCount();i++){
			mat.add(retpro1.getFieldValueString(i,"MATNO"));
			Desc.add(retpro1.getFieldValueString(i,"MATDESC"));
			Uom.add(retpro1.getFieldValueString(i,"UOM"));
		}
	}
	


	int rowCount = mat.size();
		
	if(rowCount>0)
	{
		java.util.Date myDateObj=new Date();
		myDateObj.setDate(myDateObj.getDate()+1);
 		String myDate= FormatDate.getStringFromDate(myDateObj,".",FormatDate.MMDDYYYY);
 		%>
 			
 			
			
		<Table width="100%" id="InnerBox1Tab" border=1 align=center borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
			
 		<%
		String tDesc= "";
		
		
		for(int g=0;g<rowCount;g++)
		{
		
			String minQ =retpro1.getFieldValueString(g,"UPC_NO");
			minQ = minQ.trim();	
					if(minQ == null || "".equals(minQ)|| "null".equals(minQ))
						minQ="1";
		
		
	%>	
			<Tr>
			<Td align='center' width='5%'><input type='checkbox' tabindex=2 name='chkmatno' value="<%=(String)mat.get(g)%>"></Td>
			<Td align='center' width='18%'onClick='openWindow()'>&nbsp;<A href="JavaScript:openWindow('<%=(String)mat.get(g)%>')" onMouseover="window.status='Click to view Plant Details '; return true" onMouseover="window.status=' '; return true"><%=(String)mat.get(g)%></a></Td>
			<Td align='left' width='44%'>&nbsp;<input type='hidden' name='matDesc' value="<%=(String)Desc.get(g)%>"><%=(String)Desc.get(g)%></Td>
			<Td align='center' width='5%'>&nbsp;<input type='hidden' name='Uom' value="<%=(String)Uom.get(g)%>"><%=(String)Uom.get(g)%> </Td>
			<%
				tDesc = (String)Desc.get(g);
				tDesc = tDesc.replace('"',' ');
			
			%>
			<Td align='center' width='18%'>&nbsp;<input type='text' size='8' style="text-align:right" onBlur='verifyQty1(this,"<%=minQ.trim()%>","<%=tDesc%>")'  tabindex='3' class='InputBox' onBlur='checkNum(this)' name='matQty' value='0'> &nbsp;[<%=minQ.trim()%>]</Td>									
			</Tr>
	<%			
		}		
	%>
		</Table>
		<input type="hidden" name="reqDate" value="<%=myDate%>">
		
<%
		
	}
	else
	{
		out.println("µ0");
	}
	
	out.println("¥"+0);
	out.println("¥"+"TERMINATE");
	
	
%>
<Div id="MenuSol"></Div> 