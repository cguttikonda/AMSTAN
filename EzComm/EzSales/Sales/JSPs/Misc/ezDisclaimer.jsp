<%@ page import = "ezc.ezparam.*" %>
<%@ page import = "ezc.ezshipment.client.*" %>
<%
	ezc.ezshipment.client.EzShipmentManager dsclmrManager = new ezc.ezshipment.client.EzShipmentManager();
	ezc.ezparam.EzcParams dsclmrparams = new ezc.ezparam.EzcParams(true);
	ezc.ezparam.EzcUserParams dsclmrusrparams= new ezc.ezparam.EzcUserParams();
	dsclmrusrparams.setUserId(Session.getUserId()+"¥Y");//This is for knowing whether customer clicked on 'I Agree' button when first time logged in the portal .
	dsclmrparams.setObject(dsclmrusrparams);
	Session.prepareParams(dsclmrparams);
	ezc.ezcommon.EzLog4j.log(">>>>>>>Disclaimer Insert>>>>>>>>>>>>>>>>>>>>>>","D");
	ezc.ezparam.ReturnObjFromRetrieve dsclmrRetObj = (ezc.ezparam.ReturnObjFromRetrieve)dsclmrManager.ezGetDisclaimerStamp(dsclmrparams);
	ezc.ezcommon.EzLog4j.log(">>>>>>>Disclaimer Insert>>>>>>>>>>>>>>>>>>>>>>","D");
	
	if (dsclmrRetObj!=null && dsclmrRetObj.getRowCount()==0)
	{
		ezc.ezcommon.EzLog4j.log(">>>>>>>Disclaimer Insert>>>>>>>>>>>>>>>>>>>>>>","D");
		dsclmrManager= new EzShipmentManager();
		dsclmrusrparams = new ezc.ezparam.EzcUserParams();
		dsclmrusrparams.setUserId(Session.getUserId()+"¥Y");//This is for knowing whether customer clicked on 'I Agree' button when first time logged in the portal .
		dsclmrparams.setObject(dsclmrusrparams);
		Session.prepareParams(dsclmrparams);
		dsclmrManager.ezPutDisclaimerStamp(dsclmrparams);	
	}
	session.putValue("DISCLAIMER","Y");

%>
<div class="main-container col2-left-layout middle account-pages">
<div class="hly-perftop"></div>
<div class="main">
<div class="col-main">
<div class="my-account">
<div class="dashboard">
<%
	String userEmail = (String)session.getValue("USEREMAIL");
	String userFName = (String)session.getValue("FIRSTNAME");
	String userLName = (String)session.getValue("LASTNAME");
		//out.println("userEmail:::::"+userEmail+":::userFName:::"+userFName+"::::userLName:::"+userLName);
	
	
		String sysKey = (String)session.getValue("SalesAreaCode");
		String selSoldTo = (String)session.getValue("AgentCode");
		String selShipTo = (String)session.getValue("ShipCode");
		
		//out.println("sysKey:::::"+sysKey+":::selSoldTo:::"+selSoldTo+"::::selShipTo:::"+selShipTo);

		
		String selSoldName 	= "";
		String selSoldAddr1	= "";
		String selSoldCity 	= "";
		String selSoldState 	= "";
		String selSoldCountry 	= "";
		String selSoldZipCode	= "";
		String selSoldPhNum 	= "";
		String selSoldEmail 	= "";
	
		ReturnObjFromRetrieve retsoldto_A = (ReturnObjFromRetrieve)UtilManager.getUserCustomers(sysKey);
		//out.println("retsoldto_A:::::::::::::::"+retsoldto_A.toEzcString());		
		if(retsoldto_A!=null)
		{
			session.putValue("retsoldto_A_Ses",retsoldto_A);
			for(int i=0;i<retsoldto_A.getRowCount();i++)
			{
				String soldToCode_A 	= retsoldto_A.getFieldValueString(i,"EC_ERP_CUST_NO");
				String soldToName_A 	= retsoldto_A.getFieldValueString(i,"ECA_NAME");
				
				if(selSoldTo.equals(soldToCode_A))
				{
					selSoldName 	= retsoldto_A.getFieldValueString(i,"ECA_NAME");
					selSoldAddr1	= retsoldto_A.getFieldValueString(i,"ECA_ADDR_1");
					selSoldCity 	= retsoldto_A.getFieldValueString(i,"ECA_CITY");
					selSoldState 	= retsoldto_A.getFieldValueString(i,"ECA_DISTRICT");
					selSoldCountry 	= retsoldto_A.getFieldValueString(i,"ECA_COUNTRY");
					selSoldZipCode	= retsoldto_A.getFieldValueString(i,"ECA_POSTAL_CODE");
					selSoldPhNum 	= retsoldto_A.getFieldValueString(i,"ECA_PHONE");
					selSoldEmail 	= retsoldto_A.getFieldValueString(i,"ECA_EMAIL");

					selSoldName 	= (selSoldName==null || "null".equals(selSoldName)|| "".equals(selSoldName))?"":selSoldName;
					selSoldAddr1 	= (selSoldAddr1==null || "null".equals(selSoldAddr1)|| "".equals(selSoldAddr1))?"":selSoldAddr1;
					selSoldCity 	= (selSoldCity==null || "null".equals(selSoldCity)|| "".equals(selSoldCity))?"":selSoldCity;// for city
					selSoldState 	= (selSoldState==null || "null".equals(selSoldState) || "".equals(selSoldState))?"":selSoldState;
					selSoldCountry 	= (selSoldCountry==null || "null".equals(selSoldCountry)|| "".equals(selSoldCountry))?"":selSoldCountry.trim();
					selSoldZipCode 	= (selSoldZipCode==null || "null".equals(selSoldZipCode)|| "".equals(selSoldZipCode))?"":selSoldZipCode;
					selSoldPhNum 	= (selSoldPhNum==null || "null".equals(selSoldPhNum)|| "".equals(selSoldPhNum))?"":selSoldPhNum;
					selSoldEmail 	= (selSoldEmail==null || "null".equals(selSoldEmail)|| "".equals(selSoldEmail))?"":selSoldEmail;
				}
			}
		}
		
		UtilManager.setSysKeyAndSoldTo(sysKey,selSoldTo);
		ReturnObjFromRetrieve  listShipTos_ent = (ReturnObjFromRetrieve)UtilManager.getListOfShipTos(selSoldTo);
		//out.println("selSoldTo:::"+selSoldTo);
		session.putValue("listShipTos_entSes",listShipTos_ent);
		//out.println("listShipTos_ent:::::::::::::::::"+listShipTos_ent.toEzcString());
		String shipToName = "";
		String shipAddr1 = "";
		String shipAddr2 = "";
		String shipState = "";
		String shipCountry = "";
		String shipZip = "";
		String shipPhNum = "";
		
		if(listShipTos_ent!=null)
		{		
			for(int l=0;l<listShipTos_ent.getRowCount();l++)
			{
				String shipToCode = listShipTos_ent.getFieldValueString(l,"EC_PARTNER_NO");
				
				if(selShipTo.equals(shipToCode))
				{

					shipToName 	= listShipTos_ent.getFieldValueString(l,"ECA_NAME");
					shipAddr1  	= listShipTos_ent.getFieldValueString(l,"ECA_ADDR_1"); //Street
					shipAddr2  	= listShipTos_ent.getFieldValueString(l,"ECA_CITY");
					shipState  	= listShipTos_ent.getFieldValueString(l,"ECA_STATE");
					shipCountry  	= listShipTos_ent.getFieldValueString(l,"ECA_COUNTRY");
					shipZip    	= listShipTos_ent.getFieldValueString(l,"ECA_PIN");
					shipPhNum    	= listShipTos_ent.getFieldValueString(l,"ECA_PHONE");

					shipToName 	= (shipToName==null || "null".equals(shipToName)|| "".equals(shipToName))?"":shipToName;
					shipAddr1 	= (shipAddr1==null || "null".equals(shipAddr1)|| "".equals(shipAddr1))?"":shipAddr1;
					shipAddr2 	= (shipAddr2==null || "null".equals(shipAddr2)|| "".equals(shipAddr2))?"":shipAddr2;// for city
					shipState 	= (shipState==null || "null".equals(shipState) || "".equals(shipState))?"":shipState;
					shipCountry 	= (shipCountry==null || "null".equals(shipCountry)|| "".equals(shipCountry))?"":shipCountry.trim();
					shipZip 	= (shipZip==null || "null".equals(shipZip)|| "".equals(shipZip))?"":shipZip;
					shipPhNum 	= (shipPhNum==null || "null".equals(shipPhNum)|| "".equals(shipPhNum))?"":shipPhNum;
				
				}
				else
				{

					shipToName 	= listShipTos_ent.getFieldValueString(0,"ECA_NAME");
					shipAddr1  	= listShipTos_ent.getFieldValueString(0,"ECA_ADDR_1"); //Street
					shipAddr2  	= listShipTos_ent.getFieldValueString(0,"ECA_CITY");
					shipState  	= listShipTos_ent.getFieldValueString(0,"ECA_STATE");
					shipCountry  	= listShipTos_ent.getFieldValueString(0,"ECA_COUNTRY");
					shipZip    	= listShipTos_ent.getFieldValueString(0,"ECA_PIN");
					shipPhNum    	= listShipTos_ent.getFieldValueString(0,"ECA_PHONE");

					shipToName 	= (shipToName==null || "null".equals(shipToName)|| "".equals(shipToName))?"":shipToName;
					shipAddr1 	= (shipAddr1==null || "null".equals(shipAddr1)|| "".equals(shipAddr1))?"":shipAddr1;
					shipAddr2 	= (shipAddr2==null || "null".equals(shipAddr2)|| "".equals(shipAddr2))?"":shipAddr2;// for city
					shipState 	= (shipState==null || "null".equals(shipState) || "".equals(shipState))?"":shipState;
					shipCountry 	= (shipCountry==null || "null".equals(shipCountry)|| "".equals(shipCountry))?"":shipCountry.trim();
					shipZip 	= (shipZip==null || "null".equals(shipZip)|| "".equals(shipZip))?"":shipZip;
					shipPhNum 	= (shipPhNum==null || "null".equals(shipPhNum)|| "".equals(shipPhNum))?"":shipPhNum;
								
				}
			}

	       }
%>
	<div class="page-title">
		<h1>My Dashboard</h1>
	</div>
	<div class="welcome-msg">
		<h2 class="sub-title">Hello, <%=userFName%> <%=userLName%>!</h2>
		<p>From your My Account Dashboard you have the ability to view a snapshot of your recent account activity and update your account information. Select a link below to view or edit information.</p>
	</div>
	
	<h2 class="sub-title">Quick Links/ Alerts</h2>
	<div class="col4-set">
	<div class="col-1">
	   	<div class="info-box">
	            <h3 class="box-title">Orders in Review <span class="separator">|</span> 
	        
	        
	        
<%			if(countMisc>0)
			{
%>				
				<a href="ezs-rb-myaccount-myorders.htm"><%=countMisc%></a>
<%			}
			else 
			{
%>				
			<%=countMisc%>
<%			}
%>


	</h3>
	</div>
	</div>
	<div class="col-2">
	   	<div class="info-box">
	            <h3 class="box-title">Saved Orders <span class="separator">|</span> 
	            
<%			if(countMisc1>0)
			{
%>				
				<a href="ezs-rb-myaccount-myorders.htm"><%=countMisc1%></a>
<%			}
			else 
			{
%>				
			<%=countMisc1%>&nbsp;&nbsp;
<%			}
%>	   
	            
	            </h3>
	        </div>
	</div>
	<div class="col-3">
	   	<div class="info-box">
	            <h3 class="box-title">Open Invoices <span class="separator">|</span> 
	            
<%			if(rowno>0)
			{
%>				
				<a href="../Invoices/ezOpenInvoices.jsp"><%=rowno%></a>
<%			}
			else 
			{
%>				
				<%=rowno%>&nbsp;&nbsp;
<%			}
%>	            	            
	            
	            </h3>
	        </div>
	</div>
	<div class="col-4">
	   	<div class="info-box">
	            <h3 class="box-title">Job Quotes Expiring this Month <span class="separator">|</span> 

<%			if(SalQCnt>0)
			{
%>				
				<a href="../Quotes/ezExpiringJobQuotes.jsp"><%=SalQCnt%></a>
<%			}
			else  
			{
%>				
				<%=SalQCnt%>&nbsp;&nbsp;
<%			}
%>	            
	            
	            </h3>
	        </div>
	</div>	
	</div> 
	
	
	
	<div class="col4-set">
		<div class="col-1">
		   	<div class="info-box">
		            <h3 class="box-title">UnRead Messages <span class="separator">|</span> 
		        
		        
		        
	<%			if(3>0)
				{
	%>				
					<a href="javascript:void(0)">3</a>
	<%			}
				else 
				{
	%>				
				<%=countMisc%>
	<%			}
	%>
	
	
		</h3>
		</div>
		</div>
		<div class="col-2">
		   	<div class="info-box">
		            <h3 class="box-title">UnRead News <span class="separator">|</span> 
		            
	<%			if(unreadNewsCnt>0)
				{
	%>				
					<a href="../News/ezListNewsDash.jsp"><%=unreadNewsCnt%></a>
	<%			}
				else 
				{
	%>				
				<%=unreadNewsCnt%>&nbsp;&nbsp;
	<%			}
	%>	   
		            
		            </h3>
		        </div>
		</div>
		<div class="col-3">
		   	<div class="info-box">
		            <h3 class="box-title">Active Promotions<span class="separator">|</span> 
		            
	<%			if(rowno>0)
				{
	%>				
					<a href="javascript:void(0)">3</a>
	<%			}
				else 
				{
	%>				
					<%=rowno%>&nbsp;&nbsp;
	<%			}
	%>	            	            
		            
		            </h3>
		        </div>
		</div>
		<div class="col-4">
		   	<div class="info-box">
		            <h3 class="box-title">Open RGA Claims <span class="separator">|</span> 
	
	<%			if(SalQCnt>0)
				{
	%>				
					<a href="javascript:void(0)">4</a>
	<%			}
				else  
				{
	%>				
					<%=SalQCnt%>&nbsp;&nbsp;
	<%			}
	%>	            
		            
		            </h3>
		        </div>
		</div>	
	</div>

	<h2 class="sub-title">Account Information</h2>
	<div class="col2-set">
	<div class="col-1">
	<div class="info-box">
		<h3 class="box-title">Contact Information <span class="separator">|</span> <a href="../SelfService/ezChangePassword.jsp">Change Password</a></h3>
		<p class="box-content">
		<%=userFName.substring(0,1).toUpperCase()+userFName.substring(1).toLowerCase()%><br>
		<%=userEmail%><br>
		<a class="dash-edit" href="../SelfService/ezChangeAcctInfo.jsp"><span><span>Edit</span></span></a>
		</p>
	</div>
	</div>
	</div>
	<div class="col2-set">
	<h2 class="sub-title">Address Information</h2>
	<div class="col-1">
	<div class="info-box">									 	
	<h3 class="box-title">Default Billing Address </h3>				
	<address class="box-content">							
	<ul>	
		<li>									
			<%=selSoldName%>						
		</li>
		<li>									
			<%=selSoldAddr1%>						
		</li>									
		<li>									
			<%=selSoldCity%>						
		</li>									
		<li>									
			<%=selSoldState%>						
		</li>
		<li>									
			<%=selSoldCountry%>						
		</li>
		
		<li>									
			<%=selSoldPhNum%>						
		</li>
		<li>									
			<%=selSoldEmail%>						
		</li>
	</ul>

	</address>
	<a class="dash-edit" href="../SwitchAccount/ezChangeSoldTo.jsp"><span><span>Manage SoldTo</span></span></a>
	</div>
	</div>
	<div class="col-2">
	<div class="info-box">
	<h3 class="box-title">Default Shipping Address</h3>
	<address class="box-content">
	<ul>	
		<li>									
			<%=shipToName%>								
		</li>										
		<li>										
			<%=shipAddr1%>								
		</li>																			
		<li>									
			<%=shipState%>						
		</li>
		<li>									
			<%=shipCountry%>						
		</li>
		
		<li>									
			<%=shipPhNum%>						
		</li>
		<li>									
			<%=selSoldEmail%>						
		</li>
	</ul></address>
	<a class="dash-edit" href="../SwitchAccount/ezChangeShipTo.jsp"><span><span>Manage ShipTo</span></span></a>
	</div>
	</div>
</div>
</div>
</div>
</div>
<div class="col-left sidebar">
	<div class="block block-account">
		<div class="block-title">
			<strong><span>My Account</span></strong>
		</div>
		<div class="block-content">
			<ul>
			<li class="current"><strong>Account Dashboard</strong></li>
			<li><a href="javascript:void(0)">Account Information</a></li>
			<li><a href="javascript:void(0)">Address Information</a></li>
			<li><a href="../Sales/ezSalesOrders.jsp">My Orders</a></li>
			<li><a href="../News/ezListNewsDash.jsp">My News</a></li>
			<li><a href="javascript:void(0)">My Favorites</a></li>
			</ul>
		</div>
	</div>
</div>
</div>
</div>