<jsp:useBean id="UserManager" class="ezc.client.EzUserAdminManager" scope="session"></jsp:useBean>
<%@ page import = "ezc.ezparam.*,ezc.ezadmin.ezadminutils.params.*" %>
<%@ page import = "ezc.ezparam.*" %>
<%!
	public ReturnObjFromRetrieve getListOfShipTos(String custNO,String busPartner,ezc.session.EzSession Session)
	{
		ezc.ezparam.ReturnObjFromRetrieve retObjMisc =null;
		ezc.ezparam.EzcParams mainParamsMisc= new ezc.ezparam.EzcParams(false);
		
		ezc.ezmisc.params.EziMiscParams miscParams = new ezc.ezmisc.params.EziMiscParams();
		ezc.ezmisc.client.EzMiscManager ezMiscManager = new ezc.ezmisc.client.EzMiscManager();
		miscParams.setIdenKey("MISC_SELECT");
		String query="Select A.*, B.* from EZC_CUSTOMER A , EZC_CUSTOMER_ADDR B where  A.EC_PARTNER_FUNCTION in ('WE') and A.EC_ERP_CUST_NO = '"+custNO+"' AND A.EC_BUSINESS_PARTNER = '"+busPartner+"' and B.ECA_LANG = 'EN' and A.EC_NO = B.ECA_NO";

		miscParams.setQuery(query);
		mainParamsMisc.setLocalStore("Y");
		mainParamsMisc.setObject(miscParams);
		Session.prepareParams(mainParamsMisc);	

		try
		{		
			ezc.ezcommon.EzLog4j.log("miscParams.getQuery()::::::::"+miscParams.getQuery() ,"I");
			retObjMisc = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParamsMisc);
		}
		catch(Exception e)
		{
			ezc.ezcommon.EzLog4j.log("Exception in Getting Data"+e,"E");
		}		
		return retObjMisc;
	}
%>
<%
	String user_id = request.getParameter("UserID");
	String repAgency = request.getParameter("RepAgency");

	boolean repAgen_B = false;
	if(repAgency!=null && !"null".equalsIgnoreCase(repAgency) && !"".equals(repAgency) && !"N/A".equals(repAgency))
		repAgen_B = true;

	/***************** Sub User Authorizations Start ******************/

	Hashtable subUserAuthHT = new Hashtable();

	subUserAuthHT.put("VONLY","View");
	subUserAuthHT.put("VEDIT","View and Edit");

	/***************** Sub User Authorizations End ******************/
%>
<%@ include file="../../../Includes/JSPs/Misc/iSubUserDetails.jsp"%>
<%
	int retObjCnt=0;
	Vector selShips = new Vector();
	Vector selSolds = new Vector();
	ReturnObjFromRetrieve retObjShip =null;
	mainParamsMisc= new ezc.ezparam.EzcParams(false);

	miscParams = new ezc.ezmisc.params.EziMiscParams();
	miscParams.setIdenKey("MISC_SELECT");
	//String query="SELECT DISTINCT(EECD_DEFAULTS_VALUE),EECD_NO FROM EZC_ERP_CUSTOMER_DEFAULTS WHERE EECD_NO IN (SELECT EUD_VALUE FROM EZC_USER_DEFAULTS WHERE EUD_USER_ID='"+user_id+"' AND EUD_KEY='SOLDTOPARTY') AND EECD_DEFAULTS_KEY='SHIPTO' AND EECD_USER_ID='"+user_id+"'";
	String query="select distinct(EUD_VALUE) VALUE,EUD_KEY from EZC_USER_DEFAULTS where EUD_user_id = '"+user_id+"'  and EUD_KEY IN ('SHIPTOPARTY','SOLDTOPARTY')";

	miscParams.setQuery(query);
	mainParamsMisc.setLocalStore("Y");
	mainParamsMisc.setObject(miscParams);
	Session.prepareParams(mainParamsMisc);	

	try
	{		
		ezc.ezcommon.EzLog4j.log("miscParams.getQuery()::::::::"+miscParams.getQuery() ,"I");
		retObjShip = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParamsMisc);
	}
	catch(Exception e)
	{
		ezc.ezcommon.EzLog4j.log("Exception in Getting Data"+e,"E");
	}
	if(retObjShip!=null && retObjShip.getRowCount()>0)
	{
		retObjCnt = retObjShip.getRowCount();
		for(int r=0;r<retObjCnt;r++)
		{
			if("SHIPTOPARTY".equals(retObjShip.getFieldValueString(r,"EUD_KEY")))
				selShips.add(retObjShip.getFieldValueString(r,"VALUE"));
			if("SOLDTOPARTY".equals(retObjShip.getFieldValueString(r,"EUD_KEY")))
				selSolds.add(retObjShip.getFieldValueString(r,"VALUE"));
		}

	}
	//out.println(selShips);
%>
<html>
<head>
<Script>
function funBack()
{
	history.go("-1");
}
</Script>	
</head>
<body  scroll=no>
<form name=myForm method=post action="">
<div id="modal1" style="border:0px solid black; background-color:white; padding:1px; font-size:10;width:40%;height:20%; text-align:center; display:none;">
	<ul>
		<li>&nbsp;</li>
		<li><img src="../../Library/images/loading.gif" width="100" height="100" alt=""></li>
		<li><font size=2><B>Your request is being processed. Please wait...</B></font></li>
	</ul>
</div>
<div class="main-container col2-left-layout middle account-pages">
<div class="main">
<div class="col-main roundedCorners containerds">
	<table class="data-table" id="quickatp">
	<Th colspan="4" align ="center" style="background-color:#000000; color:#66CC33; font-size:15px;">
		<h1>Basic Information for <%=ret.getFieldValueString(0,"EU_ID")%></h1>
	</Th>
	<tbody>
	<Tr>
		<input type = "hidden" name = "soldTo" value="">
		<Th>User ID</Th>
		<Td>&nbsp;<%=ret.getFieldValueString(0,"EU_ID")%></Td>
		<Th>E Mail</Th>
		<Td>&nbsp;<%=ret.getFieldValueString(0,"EU_EMAIL")%></Td>
	</Tr>
	<Tr>
		<Th>First Name</Th>
		<Td>&nbsp;<%=ret.getFieldValueString(0,"EU_FIRST_NAME")%></Td>	
		<Th>Last Name</Th>
		<Td>&nbsp;<%=ret.getFieldValueString(0,"EU_LAST_NAME")%></Td>	
	</Tr>
	</tbody>
	<Tr>
		<Th colspan=4 align ="center" style="background-color:#000000; color:#66CC33; font-size:15px;">
			<h1> Accounts Accessibility </h1>
		</Th>
	</Tr>
<%
	if(!repAgen_B)
	{
%>
	<!--<Tr>
		<Th align="center">
			<input type="checkbox" name="CheckBox1" value="" disabled onclick="selectAll()">
		</Th>
		<Th>
			<h1> Allowed Sold To Account(s)* </h1>
		</th>
		<Th colspan=3>
			<h1> Allowed Ship To Account(s)* </h1>
		</Th>
	</Tr>-->
	<Tr>
	<Td colspan=4>
	<Table class="data-table" style=" height:300px; overflow:auto; display:block;">
	<Tr>
		<Th align="center" width="10%">
			<input type="checkbox" name="CheckBox1" value="" disabled onclick="selectAll()">
		</Th>
		<Th width="40%">
			<h1> Allowed Sold To Account(s)* </h1>
		</th>
		<Th colspan=2 width="50%">
			<h1> Allowed Ship To Account(s)* </h1>
		</Th>
	</Tr>
<%
	retsoldtoSU = (ReturnObjFromRetrieve)session.getValue("retsoldto_A_Ses");
	int syskeyCount = 0;
	int custRows 	= retsoldtoSU.getRowCount(); 
	
	if(retSyskey!=null)
		syskeyCount = retSyskey.getRowCount(); 
		
	String defSysKey = null;
		
	ReturnObjFromRetrieve  listShipTosSU = null;
	Vector addedSoldTo = new Vector();
	Vector shipDelete = new Vector();
	//out.println("retSyskey::::::"+retSyskey.toEzcString());
	//out.println("retsoldtoSU::::::"+retsoldtoSU.toEzcString());
	if ( syskeyCount > 0 )
	{
		//for ( int i = 0 ; i < syskeyCount; i++ )
		{
			
			//soldToSyskey = retSyskey.getFieldValueString(i,"eud_sys_key");
			for(int j=0;j<custRows;j++)
			{
				String blockCode_A 	= retsoldtoSU.getFieldValueString(j,"ECA_EXT1");
				if(blockCode_A==null || "null".equalsIgnoreCase(blockCode_A)) blockCode_A = "";

				if(!"BL".equalsIgnoreCase(blockCode_A))
				{
				String custNum 	    = (String)retsoldtoSU.getFieldValue(j,"EC_ERP_CUST_NO");
				String soldToSyskey = retsoldtoSU.getFieldValueString(j,"EC_SYS_KEY");
				String Checked ="";
								
				if(addedSoldTo.contains(custNum))
					continue;
				else
					addedSoldTo.add(custNum);				
				listShipTosSU = (ReturnObjFromRetrieve)getListOfShipTos(custNum,(String)session.getValue("BussPart"),Session);
				if(selSolds.contains(custNum))
				{
					Checked = "checked";
				}	
%>
				<Tr>
					<Td colspan = "2">
						<input type="checkbox" name="CheckBox" value="<%=retsoldtoSU.getFieldValueString(j,"EC_ERP_CUST_NO")%>#<%=soldToSyskey%>" <%=Checked%> disabled>
						<%=retsoldtoSU.getFieldValue(j,"ECA_NAME")%>&nbsp;
						(<%=retsoldtoSU.getFieldValue(j,"EC_ERP_CUST_NO")%>)&nbsp;

					</Td> 
					<Td colspan = "2">
					<Table>
<%
					//out.println("listShipTosSU::::::"+listShipTosSU.toEzcString());
					for(int ship=0;ship<listShipTosSU.getRowCount();ship++)
					{
						blockCode_A 	= listShipTosSU.getFieldValueString(ship,"ECA_EXT1");
						if(blockCode_A==null || "null".equalsIgnoreCase(blockCode_A)) blockCode_A = "";

						if(!"BL".equalsIgnoreCase(blockCode_A))
						{
						String shipToName = listShipTosSU.getFieldValueString(ship,"ECA_COMPANY_NAME");
						String shipToNum = listShipTosSU.getFieldValueString(ship,"EC_PARTNER_NO");
						String accountGrp = listShipTosSU.getFieldValueString(ship,"ECA_ACCOUNT_GROUP");
						String Checked1 ="";
						if(selShips.contains(shipToNum))
							Checked1 = "checked";

						if(shipDelete.contains(shipToNum))
							continue;
						else
							shipDelete.add(shipToNum);									

						String addBuff = nullCheck(listShipTosSU.getFieldValueString(ship,"ECA_COMPANY_NAME"))+",<br>"+nullCheck(listShipTosSU.getFieldValueString(ship,"ECA_ADDR_1"))+","+nullCheck(listShipTosSU.getFieldValueString(ship,"ECA_ADDR_2"))+",<br>"+nullCheck(listShipTosSU.getFieldValueString(ship,"ECA_CITY"))+","+nullCheck(listShipTosSU.getFieldValueString(ship,"ECA_STATE"))+","+nullCheck(listShipTosSU.getFieldValueString(ship,"ECA_PHONE"));

						if("CPDA".equals(accountGrp)) addBuff = "Drop Ship";
%>
						<Tr>
						<Td style="border:0px"><input type="checkbox" name="SelShipTo" value="<%=listShipTosSU.getFieldValueString(ship,"EC_PARTNER_NO")%>##<%=(listShipTosSU.getFieldValue(ship,"EC_SYS_KEY"))%>##<%=retsoldtoSU.getFieldValue(j,"EC_ERP_CUST_NO")%>" <%=Checked1%> disabled>
						<input type="hidden" name="hiddenShip"></Td>
<%
						shipToName = shipToName.trim();
						if(shipToName != null)
						{
%>
							<Td style="border:0px"><%=shipToNum%><br><%=addBuff%></Td>
<%
						}
						else
						{
%>
							<Td style="border:0px">No ShipTo Name</Td>
<%
						}
						}
					}
%>
					</Table>
					</Td>
				</Tr>
						<input type=hidden name="SelSoldTo" value="<%=retsoldtoSU.getFieldValueString(j,"EUD_VALUE")%>">
						<input type=hidden name="SelSysKey" value="<%=soldToSyskey%>">
<%
				}
			}
		}
	}
	else
	{
%>
		<Tr>
			<Td>No ERP Customers To List</Td>
		</Tr>
<%
	}
%>
	</Table>
	</Td>
	</Tr>
<%
	}
	String ordStatus_Auth = "EZC_CUSTOMER_COR";
	if(repAgen_B)
	{
		String checkedY = "";
		String checkedN = "";
		ordStatus_Auth = "EZC_REPAGE_CORE";

		if("Y".equals(exclMat))
			checkedY = "checked";
		else if("N".equals(exclMat))
			checkedN = "checked";
%>
		<Tr>
		<Th class="a-right" colspan="2">Rep Agency</Th>
		<Td class="a-left" colspan="2"><%=repAgency%></Td>
		</Tr>
		<Tr>
		<Th class="a-right" colspan="2">Allow Exclusive Materials</Th>
		<Td class="a-left" colspan="2">
			<input type="radio" name="exclMat" value="Y" disabled <%=checkedY%>>Yes &nbsp;&nbsp;&nbsp;&nbsp;
			<input type="radio" name="exclMat" value="N" disabled <%=checkedN%>>No
		</Td>
		</Tr>
<%
	}
%>
	<Tr>
		<Th colspan=4 align ="center" style="background-color:#000000; color:#66CC33; font-size:15px;">
		<h1> User Authorization </h1>
		</Th>
	</Tr>
	<tr>
		<!--<th>Core</th>-->
		<th colspan="2">Order Accessibility</th>
		<!--<th>Special Program Usage</th>-->
		<th colspan="2">Financial Accessibility </th>
	</tr>
	<!--<td>
	<input type="checkbox" checked="" disabled="" value="EZC_CUSTOMER_COR" name="CustomerCore" >Core Customer Authorizations
	<br>
	</td>-->
	<td colspan="2">
<%	
		ezc.record.util.EzOrderedDictionary userAuth_R = Session.getUserAuth();
		if(userAuth_R.containsKey("ORDER_STATUS"))
		{ %>
			<input type="checkbox" name="subUserAuthDisp" disabled="" value="<%=ordStatus_Auth%>" <%=checkKey(ordStatus_Auth,suAuthRolesHT)%> >&nbsp;Check Order Status<br>
<%		} %>
<%		if(userAuth_R.containsKey("SO_TEMPLATE"))//SO_CREATE
		{ %>
			<input type="checkbox" name="subUserAuthDisp" disabled="" value="EZC_CUST_ORD_ENT" <%=checkKey("EZC_CUST_ORD_ENT",suAuthRolesHT)%>  >&nbsp;Save Order as Template<br>
<% 		} %>
<%		if(userAuth_R.containsKey("SUBMIT_ORDER"))
		{ %>
			<input type="checkbox" name="subUserAuthDisp" disabled="" value="EZC_CUST_ORD_SUB" <%=checkKey("EZC_CUST_ORD_SUB",suAuthRolesHT)%> >&nbsp;Submit to American Standard<br>
<% 		} %>
<%		if(userAuth_R.containsKey("SO_CANCEL"))
		{ %>
			<input type="checkbox" name="subUserAuthDisp" disabled="" value="EZC_CUST_ORD_CAN" <%=checkKey("EZC_CUST_ORD_CAN",suAuthRolesHT)%> >&nbsp;Cancel to Cancellation<br>
<% 		} %>
<%		if(userAuth_R.containsKey("SO_RETURN_CREATE"))
		{ %>
			<input type="checkbox" name="subUserAuthDisp" disabled="" value="EZC_CUST_ORD_RGA" <%=checkKey("EZC_CUST_ORD_RGA",suAuthRolesHT)%> >&nbsp;RGA/Return<br>
<% 		} %>
<%		if(userAuth_R.containsKey("FOC_ORDER"))
		{ %>
			<input type="checkbox" name="subUserAuthDisp" disabled="" value="EZC_INTSLS_FOCRE" <%=checkKey("EZC_INTSLS_FOCRE",suAuthRolesHT)%> >&nbsp;FOC Creation<br>
<% 		} %>
<%		//if(userAuth_R.containsKey("VIP_ORDER"))
		//{ %>
			<!--<input type="checkbox" name="subUserAuthDisp" disabled="" value="EZC_VIP_PROGRAM"  <%//=checkKey("EZC_VIP_PROGRAM",suAuthRolesHT)%> >&nbsp;VIP Program<br>-->
<% 		//} %>
<%		if(userAuth_R.containsKey("DISP_ORDER"))
		{ %>
			<input type="checkbox" name="subUserAuthDisp" disabled="" value="EZC_DISP_PROGRAM" <%=checkKey("EZC_DISP_PROGRAM",suAuthRolesHT)%> >&nbsp;Display Program<br>
<% 		} %>
<%		if(userAuth_R.containsKey("ASK_QUESTION"))
		{ %>
			<input type="checkbox" disabled="" <%=checkKey("EZC_CUST_QUERY",suAuthRolesHT)%> value="EZC_CUST_QUERY" name="ViewCat">&nbsp;Ask Questions<br>
<% 		} %>
	</td>
	<td colspan="2">
<%		if(userAuth_R.containsKey("SO_PAY_DTL"))
		{ %>
			<input type="checkbox"  disabled="" <%=checkKey("EZC_CUST_FIN",suAuthRolesHT)%> value="EZC_CUST_FIN" name="ViewCat">&nbsp;Invoices<br>
<% 		} %>
	</td>
	</tr>
	<tr>
		<th colspan="2">News/Announcements</th>
		<th colspan="2">Pricing</th>
	</tr>
	<tr>
	<td colspan="2">
<%		if(userAuth_R.containsKey("VIEW_PL_NEWS"))
		{ %>
			<input type="checkbox" name="subUserAuthDisp" disabled="" value="EZC_CUST_PLNEWS" <%=checkKey("EZC_CUST_PLNEWS",suAuthRolesHT)%> ">&nbsp;Products List Price<br>
<% 		} %>
<%		if(userAuth_R.containsKey("VIEW_PS_NEWS"))
		{ %>
			<input type="checkbox" name="subUserAuthDisp" disabled="" value="EZC_CUST_PS_NEWS" <%=checkKey("EZC_CUST_PS_NEWS",suAuthRolesHT)%> ">&nbsp;Periodic Statement<br>
<% 		} %>
<%		if(userAuth_R.containsKey("VIEW_PSPEC_NEWS"))
		{ %>
			<input type="checkbox" name="subUserAuthDisp" disabled="" value="EZC_CUST_PSPEC_N" <%=checkKey("EZC_CUST_PSPEC_N",suAuthRolesHT)%> ">&nbsp;Market Area Net Price<br>
<% 		} %>
<%		if(userAuth_R.containsKey("VIEW_NPROD_NEWS"))
		{ %>
			<input type="checkbox" name="subUserAuthDisp" disabled="" value="EZC_CUST_NP_NEWS" <%=checkKey("EZC_CUST_NP_NEWS",suAuthRolesHT)%> ">&nbsp;New Products<br>
<% 		} %>
<%		if(userAuth_R.containsKey("VIEW_DC_NEWS"))
		{ %>
			<input type="checkbox" name="subUserAuthDisp" disabled="" value="EZC_CUST_DC_NEWS" <%=checkKey("EZC_CUST_DC_NEWS",suAuthRolesHT)%> ">&nbsp;Discontinued. Products<br>
<% 		} %>
<%		if(userAuth_R.containsKey("VIEW_PCHNG_NEWS"))
		{ %>
			<input type="checkbox" name="subUserAuthDisp" disabled="" value="EZC_CUST_PCH_NEW" <%=checkKey("EZC_CUST_PCH_NEW",suAuthRolesHT)%> ">&nbsp;New Pricing Net Sheet<br>
<% 		} %>
<%		if(userAuth_R.containsKey("VIEW_PROMO_NEWS"))
		{ %>
			<input type="checkbox" name="subUserAuthDisp" disabled="" value="EZC_CUST_PRO_NEW" <%=checkKey("EZC_CUST_PRO_NEW",suAuthRolesHT)%> ">&nbsp;Promotions<br>
<% 		} %>
<%		if(userAuth_R.containsKey("VIEW_SLOB_NEWS"))
		{ %>
			<input type="checkbox" name="subUserAuthDisp" disabled="" value="EZC_CUST_SL_NEWS" <%=checkKey("EZC_CUST_SL_NEWS",suAuthRolesHT)%> ">&nbsp;Products On Clearance<br>
<% 		} %>
<%		if(userAuth_R.containsKey("VIEW_GA_NEWS"))
		{ %>
			<input type="checkbox" name="subUserAuthDisp" disabled="" value="EZC_CUST_GA_NEWS" <%=checkKey("EZC_CUST_GA_NEWS",suAuthRolesHT)%> ">&nbsp;General Announcements<br>
<% 		} %>
	</td>
	<td colspan="2">
<%		if(userAuth_R.containsKey("VIEW_PRICES"))
		{ %>
			<input type="checkbox"  disabled="" <%=checkKey("EZC_CUST_PRICING",suAuthRolesHT)%> value="EZC_CUST_PRICING" name="ViewCat">&nbsp;Best Pricing, Net Pricing & Net Multiplier<br>
<% 		} %>
	</td>
	</tr>
	</tbody>
	</table>
	<br>
	<!--<div >
		<input type="button" value="Back" title="Back" onClick="funBack()" />
	</div>-->
	<div class="buttons-set form-buttons">
		<p class="back-link"><a href="ezListSubUsers.jsp"><small>&laquo; </small>Go back</a></p>
	</div	
</form>
</body>
</div>
<div class="col-left sidebar roundedCorners">
	<div class="block block-account">
	<div class="block-title"><strong><span>My Account</span></strong></div>
	<div class="block-content">
	<ul>
	<li><a href="../SelfService/ezChangeAcctInfo.jsp">Account Profile</a></li>
	<li ><a href="../SelfService/ezChangePassword.jsp">Change Password</a></li>
<%
	if (!"CM".equals(userRole))
	{
%>			
		<li><a href="../SelfService/ezAddSubUser.jsp">Add Sub User</a></li>
		<div style="color:#66cc33;"><strong><span>List Sub Users</span></strong></div>
		<!--<li><a href="../SelfService/ezListSubUsers.jsp">List Sub Users</a></li>-->
<%
	}
%>
		<!-- <li><a href="../News/ezListNewsDash.jsp?newsFilter=PA">Promotions</a></li> -->
	</ul>
	</div>
	</div>
	</div>
</div>
</div>
</html>
<%!
	public String checkKey(String myStr, Hashtable suAuthRolesHT)
	{
		
		if (suAuthRolesHT.containsKey(myStr)){
			return "checked";
		} else {
			return "";
		}	
	}
	public String nullCheck(String str)
	{
		String ret = str;

		if(ret==null || "null".equalsIgnoreCase(ret) || "".equals(ret))
			ret = "";

		return ret;
	}
%>