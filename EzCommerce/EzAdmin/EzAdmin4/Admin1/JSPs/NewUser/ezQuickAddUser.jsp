<%//@ page language="java" errorPage="../Misc/ezErrorDisplay.jsp"%>
<%@ include file="../../../Includes/JSPs/NewUser/iGetSalesAreas.jsp"%> 
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<%@ page import="ezc.ezparam.*,ezc.ezmisc.params.*,java.util.*,java.util.zip.*" %>
<%@ page import="com.sap.mw.jco.*,java.util.*" %>
<%@ page import ="ezc.sapconnection.*,com.sap.mw.jco.*,com.sap.mw.jco.JCO" %>
<jsp:useBean id="ezMiscManager" class="ezc.ezmisc.client.EzMiscManager" scope="session"/>
<jsp:useBean id="CatalogMan" class="ezc.client.EzCatalogManager" scope="session"/>
<%
	EzcParams mainParamsMisc_A = new EzcParams(false);
	EziMiscParams miscParams_A = new EziMiscParams();
	ReturnObjFromRetrieve retObjMisc_A = null;

	miscParams_A.setIdenKey("MISC_SELECT");
	miscParams_A.setQuery("SELECT EU_ID FROM EZC_USERS");

	mainParamsMisc_A.setLocalStore("Y");
	mainParamsMisc_A.setObject(miscParams_A);
	Session.prepareParams(mainParamsMisc_A);	

	try
	{		
		retObjMisc_A = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParamsMisc_A);
	}
	catch(Exception e)
	{
		out.println("Exception in Getting Data"+e);
	}
%>

<Html>
<Head>
<Script src="http://code.jquery.com/jquery-latest.js"></Script>
<script src="../../Library/JavaScript/ezTabScroll.js"></script>
<script src="../../Library/JavaScript/ezTrim.js"></script>
<Script src="../../Library/Script/popup.js"></Script>
<script>
userArray = new Array();
<%
	int allUserCount = retObjMisc_A.getRowCount();
	for(int i=0;i<allUserCount;i++)
	{
%>
		userArray[<%=i%>] = '<%=((retObjMisc_A.getFieldValueString(i,"EU_ID")).toUpperCase()).trim()%>'
<%
	}
%>
function chkUserExists()
{
	userId = funTrim(document.myForm.userId.value);
	userId = userId.toUpperCase();
	for (var i=0;i<userArray.length;i++)
	{
		if (userId==userArray[i])
		{
			alert("User already Exists with "+userId+" name");
			document.myForm.userId.focus();
		}
	}
}


function qucikAddUser()
{	
	if(chk())
	{
		Popup.showModal('modal');
		document.myForm.action="ezQuickAddUserSave.jsp"
		document.myForm.submit();
	}	
}
 
var MValues = new Array();

MValues[0] =new EzMList("userId"," User ID");
MValues[1] =new EzMList("userName"," First Name");
MValues[2] =new EzMList("lastName"," Last Name");
MValues[3] =new EzMList("partnerName"," Partner Name");
MValues[4] =new EzMList("email"," E Mail");
MValues[5] =new EzMList("catnum"," Catalog");

function EzMList(fldname,flddesc)
{
	this.fldname=fldname;
	this.flddesc=flddesc;
}
function chk()
{
	for(c=0;c<MValues.length;c++)
	{
		if(funTrim(eval("document.myForm."+MValues[c].fldname+".value")) == "")
		{
			if(c=="5")
			{
				alert("Please Select"+MValues[c].flddesc);
				eval("document.myForm."+MValues[c].fldname+".focus()")
			}	
			else			
			{
				alert("Please enter"+MValues[c].flddesc);
				eval("document.myForm."+MValues[c].fldname+".focus()")
			}	
			return false;
		}
	}
	if(document.myForm.syskey !=null)
	{
		var chkbox = document.myForm.syskey.length;
		chkcount=0;
		if(isNaN(chkbox))
		{
			if(document.myForm.syskey.checked)
			{
				chkcount++;
			}
		}
		else
		{
			for(a=0;a<chkbox;a++)
			{
				if(document.myForm.syskey[a].checked)
				{
					chkcount++;
					break;
				}
			}
			if(chkcount == 0)
			{
				alert("Please check atleast one syskey");
				return false;
			}
		}
	}
	if(document.myForm.customer !=null)
	{
		var chkbox = document.myForm.customer.length;
		chkcount=0;
		if(isNaN(chkbox))
		{
			if(document.myForm.customer.checked)
			{
				chkcount++;
			}
		}
		else
		{
			for(a=0;a<chkbox;a++)
			{
				if(document.myForm.customer[a].checked)
				{
					chkcount++;
					break;
				}
			}
			if(chkcount == 0)
			{
				alert("Please check atleast one customer");
				return false;
			}
		}
	}
	return true;
}
		
function userExtend()
{
	Popup.showModal('modal');
	document.myForm.action="ezExtendUser.jsp"
	document.myForm.submit();
} 
function userWholeExtend()
{
	if(chk())
	{
		Popup.showModal('modal');
		document.myForm.action="ezWholeSaleExtend.jsp"
		document.myForm.submit();
	}
} 
function userWithNewPartner()
{
	Popup.showModal('modal');
	document.myForm.action="ezQuickAddUser.jsp";
	document.myForm.submit();
}
	
</script>
<Style>
ul
{
    list-style-type: none;
}
</Style>

</Head>
<Body  onLoad="scrollInit();" onResize="scrollInit()" scroll="no" >
<Form name=myForm method=post>	
<div id="modal" style="z-index:100;position:absolute;left:280px; top:140px; border:1px solid #EEEDE7; border-radius:7px; background-color:#ffffff; padding:1px; font-size:10;width:330px;height:150px; text-align:center; display:none;">
	<ul>
		<li>&nbsp;</li>
		<li><img src="../../Library/images/loading.gif" width="80" height="80" alt=""></li>
		<li><font size=2><B>Your request is being processed. Please wait...</B></font></li>
	</ul>
</div>
<%	
				

	if(salesArea!=null && !"null".equals(salesArea) && !"".equals(salesArea) && hierCode!=null && !"null".equals(hierCode) && !"".equals(hierCode))
	{
	
		JCO.Client client=null;
		JCO.Function function = null;	

		String [] custObjCols = {"ERPCUSTNUMBER","DIVISION","DISTCHAN","SALESORG","SYSKEY"};

		ReturnObjFromRetrieve custRetObj = new ReturnObjFromRetrieve(custObjCols);
		
		
		EzcParams mainParamsMisc= new EzcParams(false);
		EziMiscParams miscParams = new EziMiscParams();
		ReturnObjFromRetrieve retObjMisc = null;

		miscParams.setIdenKey("MISC_SELECT");
		miscParams.setQuery("SELECT DISTINCT(EC_ERP_CUST_NO) SOLDTO,EC_SYS_KEY SYSKEY FROM EZC_CUSTOMER order by SOLDTO");

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
		
		ArrayList alCust1 = new ArrayList();
		
		/*for(int al=0;al<retObjMisc.getRowCount();al++)
		{
			alCust1.add(retObjMisc.getFieldValueString(al,"SOLDTO"));
		}*/

		//out.println("retObjMisc"+retObjMisc.toEzcString());
		
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.YEAR, -15);
		//cal.add(Calendar.DATE, -30);	       	  
		//cal.add(Calendar.MONTH, -6);

		//out.println("1 year ago: " + cal.getTime());

		//ezc.ezcommon.EzLog4j.log("timeStmpStr>>>>>>>"+timeStmpStr,"I");
		
		String site_S = (String)session.getValue("Site");
		String skey_S = "999";
		
		function = EzSAPHandler.getFunction("Z_EZ_GET_BUS_CUSTOMER_MASTER",site_S+"~"+skey_S);
		JCO.ParameterList sapProc 	= function.getImportParameterList();

		sapProc.setValue("999","SYSTEM_NUM");
		if(salesOrg!=null && !"".equals(salesOrg))
			sapProc.setValue("","SALES_ORG");//salesOrg
		if(disChannel!=null && !"".equals(disChannel))
			sapProc.setValue("","DIST_CHANNEL");//disChannel
		if(Division!=null && !"".equals(Division))
			sapProc.setValue("","DIVISION");//Division
		if(soldTo!=null && !"".equals(soldTo))
			sapProc.setValue(soldTo,"CUSTOMER_NUMBER");

		//sapProc.setValue("WE","PARTNER_FUNCTION");
		sapProc.setValue("EN","LANGUAGE");
		sapProc.setValue(cal.getTime(),"UPDATED_FROM");
		//sapProc.setValue("","UPDATED_FROM");
		sapProc.setValue(hierCode,"HIGHLEVELCUST");
		//sapProc.setValue("","HIGHLEVELCUST");


		ArrayList alCust   = new ArrayList();
		ArrayList alSyskey = new ArrayList();
		

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
						String allAppend = "",sareaAppend = "";
						String erpAppend = (String)partnerTable.getValue("KUNNR");
						String divAppend = (String)partnerTable.getValue("SPART");
						String disAppend = (String)partnerTable.getValue("VTWEG");
						String sorAppend = (String)partnerTable.getValue("VKORG");
						allAppend	 = erpAppend+"_"+sorAppend+"_"+disAppend+"_"+divAppend;
						sareaAppend	 = sorAppend+disAppend+divAppend;
						
						if(!alCust.contains(allAppend))
						{	
							String getSysHM = "";
							if(sareaHM.containsKey(sareaAppend))
							{
								getSysHM = (String)sareaHM.get(sareaAppend);
								
								custRetObj.setFieldValue("ERPCUSTNUMBER", partnerTable.getValue("KUNNR"));
								custRetObj.setFieldValue("DIVISION", 	  partnerTable.getValue("SPART"));
								custRetObj.setFieldValue("DISTCHAN",      partnerTable.getValue("VTWEG"));
								custRetObj.setFieldValue("SALESORG",      partnerTable.getValue("VKORG"));
								custRetObj.setFieldValue("SYSKEY",        getSysHM);							
								alSyskey.add(sareaHM.get(sareaAppend));							
								custRetObj.addRow();	
							}
							
													
						}						
						alCust.add(allAppend);
						
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
		//out.println("custRetObj::::"+custRetObj.toEzcString());
		ezc.ezcommon.EzLog4j.log("custRetObj::::"+custRetObj.toEzcString(),"I");
		
		int custRetObjCnt = 	custRetObj.getRowCount();
		
		session.putValue("custRetObjSes",custRetObj);

		
	String userIdStr = "";

	try
	{
		userIdStr	= (Long.parseLong(soldTo))+"";
	}
	catch(Exception e)
	{
		userIdStr 	= soldTo;
	}

	ReturnObjFromRetrieve retcat = null;
	EzCatalogParams cparams = new EzCatalogParams();
	cparams.setLanguage("EN");
	Session.prepareParams(cparams);
	retcat = (ReturnObjFromRetrieve)CatalogMan.getCatalogList(cparams);

	int catRows = retcat.getRowCount();
	if(custRetObjCnt>0)
	{
		custRetObj.sort(new String[]{"SYSKEY"},true);
	if(catRows==0)
	{
%>
		<br><br><br><br>
		<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
		<Tr align="center">
		<Th>There are no Catalogs to List</Th>
		</Tr>
		</Table>
		<br>
		<center>
			<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%=ButtonDir%>/back.gif" border=none></a>
		</center>
<%
		return;
	}
%>

	<div id="theads" >
	<br>
      	<Table id="tabHead" width="89%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	<Tr>
		<Th>Quick Add Customer</Th>
	</Tr>
	</Table>

	<Table  width="89%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	<Tr>
		<input type = "hidden" name = "soldTo" value="<%=soldTo%>">
		<input type = "hidden" name = "hierCode" value="<%=hierCode%>">
		<Th width = "25%" align="right">User ID*</Th>
		<Td width = "25%"><input type = "text" class = "InputBox" name = "userId" size = 15 maxlength = "10" value="" onBlur="chkUserExists()" ></Td>
		<Th width = "25%" align="right">Partner Name*</Th>
		<Td width = "25%"><input type = "text" class = "InputBox" name = "partnerName" size = 30 maxlength = "60"></Td>
		
		<input type="hidden" name = "plant" value="1000">
	
		
			
	</Tr>
	<Tr>
		<Th width = "25%" align="right">First Name*</Th>
		<Td width = "25%"><input type = "text" class = "InputBox" name = "userName" size = 30 maxlength = "60"></Td>
		
		<Th align = "right">E Mail*</Th>
		<Td><input type = "text" class = "InputBox" name = "email" size = 20 maxlength = "128"></Td>
	</Tr>
	<Tr>
		<Th width = "25%" align="right">last Name*</Th>
		<Td width = "25%"><input type = "text" class = "InputBox" name = "lastName" size = 30 maxlength = "60"></Td>
		<Th align = "right">Catalog*</Td>
		<Td>
			<select name="catnum" id=ListBoxDiv>
				<Option value = "">--Select Catalog--</Option>
<%
				if ( catRows > 0 )
				{
					retcat.sort(new String[]{"EPC_NAME"},true);
					for ( int i = 0 ; i < catRows ; i++ )
					{
%>
						<option value=<%=retcat.getFieldValueString(i,"EPC_NO")%>>
							<%=((String)retcat.getFieldValue(i,"EPC_NAME"))%>
						</option>
<%
					}
				}
%>
		
			</select>	
		</Td>	
		</Tr>
		</Table>

			<Table width = "89%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >	
				<Tr>
					<Th align="center" width = "30%" colspan = 3>Business Area</Th>
				</Tr>
			</Table>

			</Div>
		
    
			
			<div id="InnerBox1Div">
			        <Table  id="InnerBox1Tab" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
				<Tr>
<%	
				String areaFlag = "C";
				String[] sortFields = {"SYSKEY"};
				retSalArea.sort(sortFields,true);

				//out.println("retSalArea:::"+retSalArea.toEzcString());

				for(int i=0;i<retRowCount;i++)
				{

					if(i!=0 && i%3==0)
					{
%>					</tr><tr>
<%					}
				String checked = "disabled";

				if(alSyskey.contains(retSalArea.getFieldValueString(i,"SYSKEY")))
					checked="checked";
%>
					<Td width = "33%" title = "(<%=retSalArea.getFieldValueString(i,"SYSKEY")%>) <%=retSalArea.getFieldValueString(i,"SYSKEY_DESC")%>">
					<input type = "CheckBox" name = "syskey" id="<%=i%>" value = "<%=retSalArea.getFieldValueString(i,"SYSKEY")%>" <%=checked%> >			
					<input type = "text" value = "(<%=retSalArea.getFieldValueString(i,"SYSKEY")%>) <%=retSalArea.getFieldValueString(i,"SYSKEY_DESC")%>" size = "40" class = "DisplayBox" readonly Style = "Cursor:hand;text-decoration:underline">

					</Td>
<%				}
				if(retRowCount>3 && retRowCount%3!=0)
				{
					retRowCount = 3 - (retRowCount%3);
					for(int i=0;i<retRowCount;i++)
					{
%>						<Td width = "33%">&nbsp;</Td>
<%					}
				}
%>
				</Tr>
				
				</Table>
				<Table width = "99%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >	
						<Tr>
							<Th align="center" width = "30%" colspan = 3>Customers</Th>
						</Tr>
				</Table>
			
			
			<Table  width="99%" id="InnerBox1Tab" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >

			
			

			
			<Tr>
<%			for(int i=0;i<custRetObjCnt;i++)
			{
		
			if(i!=0 && i%3==0)
			{
%>	
			</tr><tr>
<%			}
%>
			
			<Td width = "25%">
			<input type=checkbox name='customer' id='<%=i%>' value ='<%=custRetObj.getFieldValueString(i,"ERPCUSTNUMBER")%>¥<%=custRetObj.getFieldValueString(i,"SYSKEY")%>' checked>
			<%=Long.parseLong(custRetObj.getFieldValueString(i,"ERPCUSTNUMBER")) %> (<%=custRetObj.getFieldValueString(i,"SYSKEY")%>)
			
			</Td>			
			
<%			}
			
			if(custRetObjCnt>3 && custRetObjCnt%3!=0)
			{
			custRetObjCnt = 3 - (custRetObjCnt%3);
			for(int i=0;i<custRetObjCnt;i++)
			{
%>				
				<Td width = "33%">&nbsp;</Td>
<%			}
			}
%>
			<Tr>
			</Table>
<%			}
			else
			{
%>			
			<br><br><br><br>
			<Table width=75% align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
			<tr>
			<Th colspan=4 width = "25%" align="center">No Customers to Extend for selected Hierarchy Code!</Th>
			</tr>
			</table>
			
<%			}
%>			
			
				
		</Div>
		
		<Div id="ButtonDiv" align="center" style="position:absolute;top:90%;width:100%">
		<Table>
		<Tr>
<%		if(custRetObjCnt>0)
		{
%>
		<Td class=blankcell>
			<a href="javascript:userWholeExtend()"><img src="../../Images/Buttons/<%= ButtonDir%>/go.gif" border="none"></a>
		</Td>
<%		}
%>
		<Td class=blankcell>
			<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%=ButtonDir%>/back.gif" border=none></a>
		</Td>
		</Tr>
		</Table>		
		</Div>

	
<%	
	
	}
	//out.println(retUserCustCount+":::::::syncSucess::::"+syncSucess);
	else if(salesArea==null || "null".equals(salesArea) || "".equals(salesArea))
	{
%>		<br><br><br><br>
		<Table width=75% align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
			<Tr>
				<Th>There is no Sales Area with given Defaults.Please contact System Administrator.</Th>			
			</Tr>
		</Table>
		<Div id="ButtonDiv" align="center" style="position:absolute;top:90%;width:100%">
			<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%=ButtonDir%>/back.gif" border=none></a>
		</Div>

<%	}
	else if(syncSucess)
	{
%>		<br><br><br><br>
		<Table width=50% align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
			<Tr>
				<Th>This Customer is already Synchronized in System.</Th>

			</Tr>
		</Table>
		<input type="hidden" name = "userWithNewPartner" value="Y">
		<input type="hidden" name = "soldTo"   value="<%=soldTo%>">
		<input type="hidden" name = "division" value="<%=Division%>">
		<input type="hidden" name = "dchannel" value="<%=disChannel%>">
		<input type="hidden" name = "salesorg" value="<%=salesOrg%>">
		<input type="hidden" name = "hiercode" value="<%=hierCode%>">
		<Div id="ButtonDiv" align="center" style="position:absolute;top:90%;width:100%">
			<a href="javascript:userWithNewPartner()"><img src="../../Images/Buttons/<%= ButtonDir%>/go.gif" border="none"></a>
			<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%=ButtonDir%>/back.gif" border=none></a>
		</Div>
<%	}
	else if(retUserCustCount==0) 
	{
	
%>		<%--Quick Add User--%>
		<%@ include file="ezQuickAddUserAdd.jsp"%>
		<Div id="ButtonDiv" align="center" style="position:absolute;top:90%;width:100%">
		<Table>
		<Tr>
		<Td class=blankcell>
			<a href="javascript:qucikAddUser()"><img src="../../Images/Buttons/<%= ButtonDir%>/go.gif" border="none"></a>
		</Td>			
		<Td class=blankcell>
			<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%=ButtonDir%>/back.gif" border=none></a>
		</Td>
		</Tr>
		</Table>
		</Div>
<%	}
	else 
	{	
%>		<%--User Extend--%>
		<%@ include file="ezQuickAddUserExtend.jsp"%>
		<Div id="ButtonDiv" align="center" style="position:absolute;top:90%;width:100%">
		<Table>
		<Tr>
		<Td class=blankcell>
			<a href="javascript:userExtend()"><img src="../../Images/Buttons/<%= ButtonDir%>/go.gif" border="none"></a>
		</Td>			
		<Td class=blankcell>
			<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%=ButtonDir%>/back.gif" border=none></a>
		</Td>
		</Tr>
		</Table>		
		</Div>
<%	}
%>		
	
</Form>
</Body>
</Html>  