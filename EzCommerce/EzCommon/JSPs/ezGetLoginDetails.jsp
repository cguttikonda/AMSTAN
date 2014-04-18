 <jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"/>
 <jsp:useBean id="ezMiscManager" class="ezc.ezmisc.client.EzMiscManager" scope="session"/>
 <jsp:useBean id="UserManager" class="ezc.client.EzUserAdminManager" scope="session" />
 <%@ page import="ezc.ezparam.*,ezc.ezmisc.params.*"%>
 <%
 
 	String username = request.getParameter("username");
 	String email 	= request.getParameter("email");
 	String query	= "";
 	String messageSub = ""; 
	String messageText = "";
	String messageIcon= "<Html><Body><img src='http://colwd162/AST/logorevised.png' height='55' width='237'><br><br>";

	String userId 		= "";
	String passWd 		= "";
	String userMail 	= "";		
	String firstName 	= "";
	String middleName 	= "";
	String lastName 	= "";	
	String regMail		= "N";
 		
 	//out.println("username::::::::::::::::"+username+"::::::email::::::::::::::::"+email);
	
 	EzcParams mainParams=null;
 	EziMiscParams loginParams = null;
	ReturnObjFromRetrieve loginRet = null;
	ezc.ezcommon.EzCipher myCipher = null;
 	
	if(username!=null && !"null".equals(username) && !"".equals(username))
 		query	= "EU_ID ='"+username+"'";
 	if(email!=null && !"null".equals(email) && !"".equals(email))
 		query	= "EU_EMAIL ='"+email+"'";
 		
 	ezc.session.EzLogonStructure logs = new ezc.session.EzLogonStructure();		
		
	logs.setUserId("EZCADMIN");
	logs.setPassWd("astadmin");
	logs.setConnGroup("202");
	ezc.ezparam.EzLogonStatus LogonStatus =  (ezc.ezparam.EzLogonStatus)Session.logon(logs);
	//out.println("LogonStatus:::::::::::::::::::::"+LogonStatus.IsSuccess());
	if(LogonStatus.IsSuccess())
	{
		if(query!="")
		{

			mainParams  = new ezc.ezparam.EzcParams(false);
			loginParams = new EziMiscParams();
			loginRet    = new ReturnObjFromRetrieve();

			loginParams.setIdenKey("MISC_SELECT");
			loginParams.setQuery("SELECT EU_ID,EU_PASSWORD,EU_EMAIL,EU_FIRST_NAME,EU_MIDDLE_INITIAL,EU_LAST_NAME FROM EZC_USERS WHERE  "+query);

			mainParams.setLocalStore("Y");
			mainParams.setObject(loginParams);
			Session.prepareParams(mainParams);	

			try
			{
				loginRet = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParams);

				userId 		= loginRet.getFieldValueString(0,"EU_ID");
				passWd 		= loginRet.getFieldValueString(0,"EU_PASSWORD");
				userMail 	= loginRet.getFieldValueString(0,"EU_EMAIL");				
				firstName 	= loginRet.getFieldValueString(0,"EU_FIRST_NAME");
				middleName 	= loginRet.getFieldValueString(0,"EU_MIDDLE_INITIAL");
				lastName 	= loginRet.getFieldValueString(0,"EU_LAST_NAME");
				
				if(loginRet!=null && loginRet.getRowCount()>0 && !"null".equals(username))
				{
				
					myCipher = new ezc.ezcommon.EzCipher();
					passWd	 = (myCipher.ezDecrypt(passWd)).trim();
					//out.println("passWd::::::::"+passWd);
				}
				if(firstName==null || "null".equals(firstName) || "".equals(firstName))firstName="";
				if(middleName==null || "null".equals(middleName) || "".equals(middleName))middleName="";
				if(lastName==null || "null".equals(lastName) || "".equals(lastName))lastName="";
			}
			catch(Exception e)
			{
				out.println("Exception in Getting Data"+e);
			}
			ezc.ezcommon.EzLog4j.log("loginRet::::::"+loginRet.toEzcString(),"D");
			if(loginRet!=null )
			{
				
				messageSub = request.getServerName()+": Login Credentials request";
				messageText ="<Html><Body><img src='http://colwd162/AST/logorevised.png' height='55' width='237'><br><br>";
				messageText = messageText + "Dear "+firstName+",<Br><Br>Please find the password details requested by you.<Br><Br>";
				//messageText+="<Html><Body><Table width = '80%' align=center border=1 borderColorDark='#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0'><Tr><Th  style='background-color: #015488;color:#FFFFFF;font-family:arial,sans-serif;font-size:12px' align='right' width='25%'>User Id</Th><Td  style='color:#330000;font-family:arial,sans-serif;font-size:12px'>"+userId.toUpperCase() +"</Td><Th  style='background-color: #015488;color:#FFFFFF;font-family:arial,sans-serif;font-size:12px' align='right' width='25%'>Password</Th><Td  style='color:#330000;font-family:arial,sans-serif;font-size:12px'>"+passWd +"</Td></Tr></Table><Br><Br>";
				messageText = messageText + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<B>User Id</B> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; :&nbsp;&nbsp;"+userId.toUpperCase()+"<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<B>Password</B> &nbsp;&nbsp; : &nbsp;"+passWd ;
				messageText = messageText + "<Br><Br><Br>This is a system generated e-mail, Please do not reply to this message.";
								
				messageText+="<Br><Br>Regards,<Br><Br>American Standard Brands <BR>Customer Care<Br> 1 Centennial Ave<Br>Piscataway, NJ 08855<Br>1-800-442-1902.</Body></Html>";
%>				
				<%@ include file="ezSendPassMail.jsp"%>
<%			
			}
			
			
		}
	}	

 
 
 %>
 