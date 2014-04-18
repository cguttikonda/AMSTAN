<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"/>
<%!
	public String nullCheck(String str)
	{
		String ret = str;

		if(ret==null || "null".equalsIgnoreCase(ret) || "".equals(ret))
			ret = "";
		else
			ret = ret.replaceAll("\'","`");

		return ret;
	}
%>
<%
		
	
	
	String userMail		= nullCheck(request.getParameter("to_Email")); //"BP_CC_Registration@americanstandard.com"; 
	String firstName	= nullCheck(request.getParameter("firstName"));
	String lastName		= nullCheck(request.getParameter("lastName"));
	String email		= nullCheck(request.getParameter("email"));
	String phNo		= nullCheck(request.getParameter("phNo"));
	String compName		= nullCheck(request.getParameter("compName"));
	String compAddr		= nullCheck(request.getParameter("compAddr"));
	String soldTo		= nullCheck(request.getParameter("soldTo"));
	String capImage		= nullCheck(request.getParameter("capImage"));
	//String details	= nullCheck(request.getParameter("details"));
	String sessionCap	= (String)session.getAttribute("key");
	//out.println("Session:::::::::::::::::"+Session);
	String street1		= nullCheck(request.getParameter("street1"));
	String street2		= nullCheck(request.getParameter("street2"));
	String city		= nullCheck(request.getParameter("city"));
	String state		= nullCheck(request.getParameter("state"));
	String zip		= nullCheck(request.getParameter("zip"));
	String asbManager	= nullCheck(request.getParameter("asbManager"));
	String roleType		= nullCheck(request.getParameter("roleType"));
	String [] selManager	= request.getParameterValues("selManager");
	String managerName	= nullCheck(request.getParameter("manName"));
	String manPhNo		= nullCheck(request.getParameter("manPhNo"));
	String manTittle	= nullCheck(request.getParameter("manTitle"));
	String manEmail		= nullCheck(request.getParameter("manEmail"));
	String addBuff 		= "";
	String regMail		= "Y";
	String regSub		= "";
	String preFix 		= "Dear Team,<Br><Br>Please take action on the below registration.<Br><Br>";
	if(street1!=null && !"".equals(street1)) addBuff = street1.toUpperCase() +"<br>";
	if(city!=null && !"".equals(city)) addBuff = addBuff +"&nbsp;&nbsp;&nbsp;"+ city.toUpperCase() +"<br>";
	if(state!=null && !"".equals(state)) addBuff = addBuff +"&nbsp;&nbsp;&nbsp;"+ state.toUpperCase() +"<br>";
	if(zip!=null && !"".equals(zip)) addBuff = addBuff +"&nbsp;&nbsp;&nbsp;"+ zip +"<br>";

	if(managerName!=null && !"null".equalsIgnoreCase(managerName) && !"".equals(managerName))
		managerName = managerName.toUpperCase();

	String roleOption = "";
	String gateKeeper = "Y";

	if(roleType!=null)
	{
		if("RA".equals(roleType)) roleOption = "Rep Agency";
		else if("IU".equals(roleType)) roleOption = "ASB Employee";
		else if("CU".equals(roleType)) roleOption  = "Customer";

		if(!"CU".equals(roleType))
		{
			gateKeeper  = "";
			managerName = "";
			manPhNo     = "";
			manTittle   = "";
			manEmail    = "";
		}
	}

	/*out.println("selManager::::::"+selManager[0]);
	out.println("street1::::::"+street1+":::street2:::::"+street2);
	out.println("city::::::"+city+":::state:::::"+state);
	out.println("zip::::::"+zip+":::asbManager:::::"+asbManager);
	out.println("managerName::::::"+managerName+":::manPhNo:::::"+manPhNo);
	out.println("manTittle::::::"+manTittle+":::manEmail:::::"+manEmail);
	*/
	boolean sendMailBool = false;
	
	if(!"".equals(firstName) && !"".equals(lastName) && !"".equals(email) && !"".equals(phNo) && !"".equals(addBuff))	// && !"".equals(managerName) && !"".equals(manPhNo) && !"".equals(manEmail))
		sendMailBool = true;
	
	//out.println("sendMailBool::::::"+sendMailBool);
	//StringBuffer buffer = new StringBuffer();
	
	String messageSub	= request.getServerName()+" : User Registration.";
	String messageText  = "<Html><Body><img src='http://"+request.getServerName()+"/AST/logorevised.png' height='55' width='237'><br><br>";
	messageText = messageText + "%UserAttention%";
	messageText = messageText + "<table width=100% style=background-color:#eeede7; border-radius:8px; > <tr><th scope=col1>&nbsp;</th><th scope='col' style='color:#000000;font-family: Arial, Helvetica, sans-serif;'>Registration Details</th><th scope='col'>&nbsp;</th></tr>";
	messageText = messageText + "<tr><td>&nbsp;</td><td><Table width = '97%' height=289 border=1 align=center bordercolor=#666666 style=background-color:#FFFFFF; >";
	messageText = messageText + "<Tr><Th  style='background-color: #5b5e5e;color:#FFFFFF;font-family:arial,sans-serif;font-size:12px' align='right' width='25%'>User Name &nbsp;&nbsp;&nbsp;</Th><Td  style='color:#330000;font-family:arial,sans-serif;font-size:12px'>&nbsp;&nbsp;&nbsp;"+firstName.toUpperCase()+" "+lastName.toUpperCase()+"</Td>  </Tr>";
	messageText = messageText + "<Tr><Th  style='background-color: #5b5e5e;color:#FFFFFF;font-family:arial,sans-serif;font-size:12px' align='right' width='25%'>Email &nbsp;&nbsp;&nbsp;</Th><Td  style='color:#330000;font-family:arial,sans-serif;font-size:12px'>&nbsp;&nbsp;&nbsp;"+email+"</Td></tr>";
	messageText = messageText + "<Tr><Th  style='background-color: #5b5e5e;color:#FFFFFF;font-family: arial,sans-serif;font-size: 12px' align='right' width='25%'>Phone No.&nbsp;&nbsp;&nbsp;</Th><Td  style='color: #330000;font-family: arial,sans-serif;font-size: 12px'>&nbsp;&nbsp;&nbsp;"+phNo+"</Td></tr>";
	messageText = messageText + "<Tr><Th  style='background-color: #5b5e5e;color:#FFFFFF;font-family: arial,sans-serif;font-size: 12px' align='right'  width='25%'>Company Name &nbsp;&nbsp;&nbsp;</Th><Td  style='color: #330000;font-family: arial,sans-serif;font-size: 12px'>&nbsp;&nbsp;&nbsp;"+compName.toUpperCase()+"</Td></Tr>";
	messageText = messageText + "<Tr><Th  style='background-color: #5b5e5e;color:#FFFFFF;font-family: arial,sans-serif;font-size: 12px' align='right' width='25%'>Company Address &nbsp;&nbsp;&nbsp;</Th><Td  style='color: #330000;font-family: arial,sans-serif;font-size: 12px'>&nbsp;&nbsp;&nbsp;"+addBuff+"</Td></tr>";
 	messageText = messageText + "<tr><Th  style='background-color: #5b5e5e;color:#FFFFFF;font-family: arial,sans-serif;font-size: 12px' align='right' width='25%'>ASB Sales Manager &nbsp;&nbsp;&nbsp;</Th><Td  style='color: #330000;font-family: arial,sans-serif;font-size: 12px'>&nbsp;&nbsp;&nbsp;"+asbManager.toUpperCase()+"</Td></Tr>";
 	messageText = messageText + "<tr><Th  style='background-color: #5b5e5e;color:#FFFFFF;font-family: arial,sans-serif;font-size: 12px' align='right' width='25%'>Role &nbsp;&nbsp;&nbsp;</Th><Td  style='color: #330000;font-family: arial,sans-serif;font-size: 12px'>&nbsp;&nbsp;&nbsp;"+roleOption+"</Td></Tr>";

	if(roleType!=null && "CU".equals(roleType))
	{
		messageText = messageText + "<tr><Th  colspan=2 align='right'  style='background-color: #5b5e5e; color: #FFFFFF; font-family: arial,sans-serif; font-size: 12px; text-align: center;' col>Gate Keeper Manager Details</Th></Tr>";
		messageText = messageText + "<tr><Th  style='background-color: #5b5e5e;color:#FFFFFF;font-family: arial,sans-serif;font-size: 12px' align='right'> Name  &nbsp;&nbsp;&nbsp;</Th><Td  style='color: #330000;font-family: arial,sans-serif;font-size: 12px'>&nbsp;&nbsp;&nbsp;"+managerName+"</Td></Tr>";
		messageText = messageText + "<tr><Th  style='background-color: #5b5e5e;color:#FFFFFF;font-family: arial,sans-serif;font-size: 12px' align='right'> Phone &nbsp;&nbsp;&nbsp;</Th><Td  style='color: #330000;font-family: arial,sans-serif;font-size: 12px'>&nbsp;&nbsp;&nbsp;"+manPhNo+"</Td></Tr>";
		messageText = messageText + "<tr><Th  style='background-color: #5b5e5e;color:#FFFFFF;font-family: arial,sans-serif;font-size: 12px' align='right'> Title &nbsp;&nbsp;&nbsp;</Th><Td  style='color: #330000;font-family: arial,sans-serif;font-size: 12px'>&nbsp;&nbsp;&nbsp;"+manTittle+"</Td></Tr>";
		messageText = messageText + "<tr><Th  style='background-color: #5b5e5e;color:#FFFFFF;font-family: arial,sans-serif;font-size: 12px' align='right'> Email &nbsp;&nbsp;&nbsp;</Th><Td  style='color: #330000;font-family: arial,sans-serif;font-size: 12px'>&nbsp;&nbsp;&nbsp;"+manEmail+"</Td></Tr>";
	}
    	messageText = messageText + "</Table></td><td>&nbsp;</td></tr><tr><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr></table>";
	//messageText = messageText + "<Br><Br>Regards,<Br>"+firstName+" "+lastName+".</Body></Html>";
	
	
	ezc.session.EzLogonStructure logs = new ezc.session.EzLogonStructure();		
	logs.setUserId("EMAILUSER");
	logs.setPassWd("emailuser");
	logs.setConnGroup("202");
	ezc.ezparam.EzLogonStatus LogonStatus =  (ezc.ezparam.EzLogonStatus)Session.logon(logs);
	//out.println("LogonStatus::::"+LogonStatus);
	ezc.ezparam.ReturnObjFromRetrieve retObjMisc =null;
	ezc.ezparam.EzcParams mainParamsMisc= new ezc.ezparam.EzcParams(false);

	ezc.ezmisc.params.EziMiscParams miscParams = null;
	ezc.ezmisc.client.EzMiscManager ezMiscManager = null;
	if(sendMailBool)
	{
		String messageText1 = messageText;
		messageText = messageText.replaceAll("%UserAttention%",preFix);
%>
		<%@ include file="ezSendPassMail.jsp"%>
<%
		messageText1 = messageText1.replaceAll("%UserAttention%","Hello "+firstName+" "+lastName+",<br><br>Thank you for registering with myASbp.com.<br> Your information will be reviewed and you will receive a notification on what comes next.<br><br>");
		regSub 	     = messageText1+"<br><br>American Standard Brands<br>Customer Care<br>1 Centennial Ave<br>Piscataway, NJ 08855<br>P: 1-800-442-1902.</Body></Html>";

		ezc.ezmail.EzcMailParams mailParams_R=new ezc.ezmail.EzcMailParams();
		mailParams_R.setGroupId("Amstan");
		mailParams_R.setTo(email);
		mailParams_R.setCC(manEmail);
		mailParams_R.setMsgText(regSub);
		mailParams_R.setSubject("Thank you for registering with myASbp.com");
		mailParams_R.setSendAttachments(false);
		mailParams_R.setContentType("text/html");
		ezc.ezmail.EzMail myMail_R=new ezc.ezmail.EzMail();
		boolean value_R=myMail_R.ezSend(mailParams_R,Session);
		ezc.ezcommon.EzLog4j.log("::::Registartion mail Sent TO :::::"+email+":::MANAGER::::"+manEmail+":::messageText::"+messageText+"::::value_R:::::","I");
		
		miscParams    = new ezc.ezmisc.params.EziMiscParams();
		ezMiscManager = new ezc.ezmisc.client.EzMiscManager();
		String insrQry = "INSERT INTO EZC_REGISTRATION_FORM_DTLS VALUES('"+firstName.toUpperCase()+"','"+lastName.toUpperCase()+"','"+email+"','"+phNo+"','"+compName.toUpperCase()+"','"+street1.toUpperCase()+"','"+city.toUpperCase()+"','"+state.toUpperCase()+"','"+zip+"','"+asbManager.toUpperCase()+"','"+gateKeeper+"','"+managerName+"','"+manPhNo+"','"+manTittle+"','"+manEmail+"',GETDATE(),'"+roleType+"' ,'' ,'')";
		miscParams.setIdenKey("MISC_INSERT");
		miscParams.setQuery(insrQry);
		
		mainParamsMisc.setLocalStore("Y");
		mainParamsMisc.setObject(miscParams);
		Session.prepareParams(mainParamsMisc);	

		try
		{		
			ezc.ezcommon.EzLog4j.log("miscParams.getQuery():::EZC_REGISTRATION_FORM_DTLS:::::"+miscParams.getQuery() ,"I");
			ezMiscManager.ezAdd(mainParamsMisc);
		}
		catch(Exception e)
		{
			ezc.ezcommon.EzLog4j.log("Exception in Getting Data"+e,"E");
		}		
		
		
		try{
			Session.logOut();
		}catch(Exception e){ezc.ezcommon.EzLog4j.log("Exception while logout of EMAILUSER","D");}
			
		
		
		
	}


%>
<!DOCTYPE html>
<html class="wf-proximanova-i7-active wf-proximanova-i4-active wf-proximanova-n4-active wf-proximanova-n7-active wf-active" lang="en"><head>
<meta http-equiv="X-UA-Compatible" content="chrome=1">
<title>American Standards Brands Business Portal</title>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="description" content="Default Description">
<meta name="keywords" content="EzCommerce">
<meta name="robots" content="INDEX,FOLLOW">
<link rel="icon" href="../../../EzComm/EzSales/Sales/Library/images/favicon.ico" type="image/x-icon">
<link rel="shortcut icon" href="../../../EzComm/EzSales/Sales/Library/images/favicon.ico" type="image/x-icon"> 
<link rel="stylesheet" type="text/css" href="../../../EzComm/EzSales/Sales/Library/Styles/style0.css"> 
<link rel="stylesheet" type="text/css" href="../../../EzComm/EzSales/Sales/Library/Styles/style1.css" media="all">
<!--<link rel="stylesheet" type="text/css" href="../../Library/Styles/style2.css" media="print">-->

<!--[if lt IE 7]> 
<script type="text/javascript">
//<![CDATA[ 
    var BLANK_URL = 'https://www.americanstandard.com/js/blank.html';
    var BLANK_IMG = 'https://www.americanstandard.com/js/spacer.gif';    
//]]> 
</script>
<![endif]-->
<!-- **** FONTS **** -->
<script type="text/javascript">
BASE_URL = 'http://www.myasb2b.com/';
SKIN_URL = 'http://www.myasb2b/skin/';
</script>
<!-- **** END FONTS **** -->
<TITLE>American Standard - Can't access your account?</TITLE>
<SCRIPT type="text/javascript">var contextPath = ""</SCRIPT>
<LINK rel="stylesheet" type="text/css" href="../AST_Login/batch.css"media="all">
<!--[if lt IE 9]>
<link type="text/css" rel="stylesheet" href="../AST_Login/batch.css?conditionalComment=lt+IE+9" media="all">
<![endif]--><!--[if IE 9]>
<LINK rel="stylesheet" type="text/css" href="../AST_Login/batch(1).css"
media="all"><![endif]--><!--[if lte IE 9]>
<LINK rel="stylesheet" type="text/css" href="../AST_Login/batch(2).css" media="all"><![endif]-->

<LINK rel="stylesheet" type="text/css" href="../AST_Login/jira.webresources_global-static.css" media="all">
<LINK rel="stylesheet" type="text/css" href="../AST_Login/jira.webresources_global-static(1).css" media="print">
<link type="text/css" rel="stylesheet" href="../AST_Login/global-static.css" media="all">
<LINK rel="stylesheet" type="text/css" href="../AST_Login/feedback.css" media="all">
<LINK rel="stylesheet" type="text/css" href="../AST_Login/resources.css" media="all">
<LINK rel="stylesheet" type="text/css" href="../AST_Login/quicksearch.css" media="all">
<LINK rel="stylesheet" type="text/css" href="../AST_Login/bonfire-active-session-headsup.css" media="all">

<SCRIPT type="text/javascript" src="../AST_Login/batch.js"></SCRIPT>
<SCRIPT type="text/javascript" src="../AST_Login/gh-globalkeyboardshortcuts.js"></SCRIPT>
<SCRIPT type="text/javascript" src="../AST_Login/feedback.js"></SCRIPT>
<SCRIPT type="text/javascript" src="../AST_Login/resources.js"></SCRIPT>
<SCRIPT type="text/javascript" src="../AST_Login/soy-deps.js"></SCRIPT>
<SCRIPT type="text/javascript" src="../AST_Login/admin-quicksearch.js"></SCRIPT> 
<SCRIPT type="text/javascript" src="../AST_Login/shortcuts.js"></SCRIPT>


<script type="text/javascript" src="//use.typekit.net/mwb2rov.js"></script>
<script type="text/javascript">try{Typekit.load();}catch(e){}</script>


</head>

<body class=" catalog-category-view">
<div class="wrapper container" id="top-of-page" style="width:100% !important;">
	<noscript>
        &lt;div class="noscript"&gt;
            &lt;div class="noscript-inner"&gt;
                &lt;p&gt;&lt;strong&gt;JavaScript seem to be disabled in your browser.&lt;/strong&gt;&lt;/p&gt;
                &lt;p&gt;You must have JavaScript enabled in your browser to utilize the functionality of this website.&lt;/p&gt;
            &lt;/div&gt;
        &lt;/div&gt;
	</noscript>
<div class="page">

<div class="header">
<header>

<form name="myFavForm" method="post">
<a href="../../../ezLogin.jsp" title="American Standard" class="logo"><img src="../../../logorevised.png" alt="American Standard" height="55px" width="237px"></a><!--Images/amstd_logo.bmp-->
</form>

</header>

</div>


<%@ include file="ezRegisterNewCustBody.jsp"%>
<%@ include file="../../../EzComm/EzSales/Sales/JSPs/Misc/ezRegPassfooter.jsp"%>

</div>
</div>
</body>
</html>     