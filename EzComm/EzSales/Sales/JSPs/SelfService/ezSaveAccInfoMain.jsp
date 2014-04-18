
<%@ include file="../../Library/Globals/ezCacheControl.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<%@ page import = "ezc.ezparam.*" %>
<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>



<%@ page import="ezc.ezparam.*,ezc.ezbasicutil.*,java.util.*" %>
<%@ page import="ezc.customer.invoice.params.*,ezc.ezmisc.params.*,ezc.ezadmin.ezadminutils.params.*" %>
<%@ page import="java.text.*,ezc.ezsap.*,ezc.client.*,ezc.ezutil.FormatDate" %>


<div class="main-container col2-left-layout middle account-pages">
<div class="main">
<div class="col-main roundedCorners" style="height: 130px;">
<div class="page-title">

<%
		String ufname=request.getParameter("ufname");
		String ulname=request.getParameter("ulname");
		String uemail=request.getParameter("uemail");
		String uId= (String)Session.getUserId().toUpperCase();

/*********************************************************************************************/	
	String authVal = request.getParameter("authVal");
	ezc.ezcommon.EzLog4j.log("authVal::::::::::::::"+authVal,"D");		
	EzcParams mainParamsImg=null;
 	EziMiscParams loginParams = null;
	ReturnObjFromRetrieve loginRet = null;
	
	if(authVal!=null && !"null".equals(authVal))
		{
			mainParamsImg  = new ezc.ezparam.EzcParams(false);
			loginParams = new EziMiscParams();
			loginRet    = new ReturnObjFromRetrieve();
	
			loginParams.setIdenKey("MISC_UPDATE");
			//loginParams.setQuery("UPDATE EZC_USER_DEFAULTS SET EUD_VALUE='"+authVal+"' WHERE EUD_USER_ID = '"+((String)Session.getUserId()).toUpperCase()+"' AND EUD_KEY='SHOWIMAGES'");
			String myMergeString ="MERGE EZC_USER_DEFAULTS AS ttable	USING ( SELECT '"+
			                      ((String)Session.getUserId()).toUpperCase()+"' AS EUD_USER_ID,'SHOWIMAGES' AS EUD_KEY,'NOT' AS EUD_SYS_KEY ,'D' AS EUD_DEFAULT_FLAG,'Y' AS EUD_IS_USERA_KEY) AS sourcetable"+
			                      " ON ttable.EUD_USER_ID = sourcetable.EUD_USER_ID "+
			                      " AND ttable.EUD_KEY = sourcetable.EUD_KEY " + 
			                      " WHEN MATCHED THEN UPDATE SET ttable.EUD_VALUE = '"+ authVal+ "' "+
			                      "	WHEN NOT MATCHED THEN INSERT (EUD_USER_ID,EUD_SYS_KEY,EUD_KEY,EUD_VALUE,EUD_DEFAULT_FLAG,EUD_IS_USERA_KEY) " +
					      " VALUES ('"+((String)Session.getUserId()).toUpperCase()+"','NOT','SHOWIMAGES','"+authVal+"','D','Y');";		                      
			                      
			loginParams.setQuery(myMergeString);
			mainParamsImg.setLocalStore("Y");
			mainParamsImg.setObject(loginParams);
			Session.prepareParams(mainParamsImg);	
	
			try
			{
				ezMiscManager.ezUpdate(mainParamsImg);
				ezc.ezcommon.EzLog4j.log("myMergeString::::::::"+myMergeString ,"I");
			}
			catch(Exception e)
			{
				out.println("Exception in Getting Data"+e);
			}
			session.removeValue("SHOWIMAGES");
			session.putValue("SHOWIMAGES",authVal);
	}
	
/*********************************************************************************************/

		if(ufname!=null && !"null".equals(ufname) && !"".equals(ufname))
		{
			ufname=ufname.trim();
			ufname.toUpperCase();
		}
		
		if(ulname!=null && !"null".equals(ulname) && !"".equals(ulname))
		{
			ulname=ulname.trim();
			ulname.toUpperCase();
		}
		if(uemail!=null && !"null".equals(uemail) && !"".equals(uemail))
		{
			uemail=uemail.trim();		
		}
			

		EzcParams mainParamsAcc= new EzcParams(false);
		EziMiscParams miscParamsAcc = new EziMiscParams();										

		miscParamsAcc.setIdenKey("MISC_UPDATE");
		String query="update EZC_USERS set eu_first_name='"+ufname+"',eu_last_name='"+ulname+"',eu_email='"+uemail+"' where EU_ID='"+uId+"'";
		miscParamsAcc.setQuery(query);

		mainParamsAcc.setLocalStore("Y");
		mainParamsAcc.setObject(miscParamsAcc);
		Session.prepareParams(mainParamsAcc);	
		try
		{		
			ezc.ezcommon.EzLog4j.log("query::::::::"+query ,"I");
			ezMiscManager.ezUpdate(mainParamsAcc);
			ezc.ezcommon.EzLog4j.log("query::::::::"+query ,"I");

		}
		catch(Exception e)
		{
			out.println("Exception in Getting Data"+e);
		}
		
		
		session.removeValue("USEREMAIL");
		session.removeValue("FIRSTNAME");
		session.removeValue("LASTNAME");
		
		session.putValue("USEREMAIL",uemail);
		session.putValue("FIRSTNAME",ufname);
		session.putValue("LASTNAME",ulname);
%>

<h2>Account Profile has been Changed successfully</h2> 	

</div>


 <!-- <div class="buttons-set form-buttons">
        <p class="back-link"><a href="../Misc/ezDashBoard.jsp"><small>&laquo; </small>Go Home</a></p>
    </div>-->
	

<div class="col1-set">
<div class="info-box">


	
</div> <!-- Info box -->
</div> <!-- col1-set -->
</div> <!-- col-main -->

<div class="col-left sidebar roundedCorners">
	<div class="block block-account">
		<div class="block-title">
			<strong><span>A/C INFORMATION</span></strong>
		</div>
		<div class="block-content">
			<ul>
			<div style="color:#66cc33;">
				<li class="current"><strong><a href="../SelfService/ezChangeAcctInfo.jsp">Account Profile</a></strong></li>
			</div>			
			<!--<li class="current"><a href="../SelfService/ezChangeAcctInfo.jsp">Account Profile</a></li>-->
<%
			if(!"CM".equals(userRole))
			{
%>			
				<li><a href="../SelfService/ezChangePassword.jsp">Change Password</a></li>
				
<%
			}
			if (!"CM".equals(userRole) && "N".equals((String)session.getValue("IsSubUser")))
			{
%>			
			<li><a href="../SelfService/ezAddSubUser.jsp">Add Sub User</a></li>
			<li><a href="../SelfService/ezListSubUsers.jsp">List Sub Users</a></li>
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


</div> <!--main -->
</div> <!-- main-container col1-layout -->