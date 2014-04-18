<%@ include file="../../Library/Globals/ezCacheControl.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ include file="../../../Includes/JSPs/Sales/iSalesDetails.jsp"%>
<%@ include file="../../../Includes/Lib/ezGlobalBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<%
	String StatusButton = sdHeader.getFieldValueString(0,"STATUS").trim();
	
	StatusButton = StatusButton.trim();

	//out.println(sdHeader.toEzcString());
	String UserRole 	= (String)session.getValue("UserRole");
	UserRole		= UserRole.trim();
	String UserLogin 	= Session.getUserId();
	UserLogin 		= UserLogin.trim();
	String ModifiedBy 	= sdHeader.getFieldValueString(0,"MOD_ID");
	ModifiedBy 		= ModifiedBy.trim();
	String CreatedBy 	= sdHeader.getFieldValueString(0,"CREATE_USERID");	
	CreatedBy 		= CreatedBy.trim();
	boolean EDIT 		= false ;
	boolean DETAILS		= false ;
	
	boolean NEW= false ;if(("New").equalsIgnoreCase(StatusButton)) NEW = true;
	boolean SUBMITTED= false ; if(("Submitted").equalsIgnoreCase(StatusButton))SUBMITTED= true ;
	boolean CANCELLED= false ;if (("canceled").equalsIgnoreCase(StatusButton)) CANCELLED= true; 
	boolean REJECTED= false ;if (("Rejected").equalsIgnoreCase(StatusButton))REJECTED= true ;
	boolean APPROVED= false ;if(("Approved").equalsIgnoreCase(StatusButton))APPROVED= true;
 	boolean TRANSFERED= false ;if(("Transfered").equalsIgnoreCase(StatusButton))TRANSFERED= true;
 	boolean RETURNEDBYCM= false ;if(("ReturnedByCM").equalsIgnoreCase(StatusButton))RETURNEDBYCM= true;
 	boolean RETURNEDBYLF= false ;if(("ReturnedByLF").equalsIgnoreCase(StatusButton))RETURNEDBYLF= true;
	boolean RETURNEDBYBP= false ;if(("ReturnedByBP").equalsIgnoreCase(StatusButton))RETURNEDBYBP= true;
	boolean SUBMITTEDTOBP= false ;if(("SubmittedToBP").equalsIgnoreCase(StatusButton))SUBMITTEDTOBP= true;

	boolean CU = false ;if(("CU").equalsIgnoreCase(UserRole)) CU = true;
 	boolean AG = false ;if(("AG").equalsIgnoreCase(UserRole)) AG = true;
	boolean CM = false ;if(("CM").equalsIgnoreCase(UserRole)) CM = true;
	boolean LF = false ;if(("LF").equalsIgnoreCase(UserRole)) LF = true;
	boolean BP = false ;if(("BP").equalsIgnoreCase(UserRole)) BP = true;

	boolean MOD_USER = false ;if( (sdHeader.getFieldValueString(0,"MOD_ID").trim()).equalsIgnoreCase(Session.getUserId().trim()) ) MOD_USER = true;
	boolean CRE_USER = false ;if( (sdHeader.getFieldValueString(0,"CREATE_USERID").trim()).equalsIgnoreCase(Session.getUserId().trim()) ) CRE_USER = true;

	if(NEW)
	{
		if(CRE_USER)
		{
			EDIT = true;
		}
	}
	else if(SUBMITTED)
        {
		if((CU)&&(!MOD_USER))
		{
			EDIT = true;
		}
		else if((((CU)||(AG))&&(MOD_USER))||(LF))
		{
			DETAILS = true ;
		}
		else if(CM)
		{
			EDIT = true;
		}
		else if((AG)&&(!MOD_USER))
		{
			EDIT = true;
		}
	}
	else if(RETURNEDBYLF)
	{
		if(CRE_USER)
		{
			EDIT = true;
		}
		else
		{
			DETAILS = true;
		}
	}
	else if(RETURNEDBYCM)
	{
		if(CRE_USER)
		{
			EDIT = true;
		}
		else
		{
			DETAILS = true;
		}
	}
	else if(APPROVED)
	{
		if(LF)
		{
			EDIT = true;
		}
		else
		{
			DETAILS = true;
		}
	}
	else if(SUBMITTEDTOBP)
	{
		if(BP)
		{
			EDIT = true;
		}
		else
		{
			DETAILS = true;
		}
	}
	else if(RETURNEDBYBP)
	{
		if(LF)
		{
			EDIT = true;
		}
		else 
		{
			DETAILS = true;
		}
	}
	else if((REJECTED)||(CANCELLED) ||(TRANSFERED))
	{
		DETAILS = true;
	}
	
	
	System.out.println("EDITEDITEDITEDITEDITEDIT::"+EDIT);
	System.out.println("DETAILSDETAILSDETAILSDETAILS::"+DETAILS);
	
	if(EDIT)
	{
		try
		{
			ezc.eztrans.EzTransactionParams params=new ezc.eztrans.EzTransactionParams();
			params.setSite("100");//connection group number.
			params.setObject("SALESORDER");//the table name.
			params.setKey(webOrNo.trim());//the row which u want to lock
			params.setUserId(Session.getUserId());//login user id
			params.setId(session.getId());//http session id
			java.util.Date upToTime = new java.util.Date();
			upToTime.setTime(upToTime.getTime()+ 500000);//5*60*1000
			params.setUpto(upToTime);//till the time you want to keep the lock
			params.setOpType("LOCK");//to keep lock on the particular row.
			ezc.eztrans.EzTransaction trans=new ezc.eztrans.EzTransaction();
			trans.ezTrans(params);
		}catch(ezc.eztrans.EzLockTransException  e)
		{
			response.sendRedirect("ezTransLockError.jsp?webOrNo="+webOrNo+"&exp="+e.getLockedId());
		}
%>
	<%//@ include file="ezEditSales.jsp" %>

	<jsp:forward page="ezEditSales.jsp" >
		<jsp:param name='pageFlag' value='EDIT' />
	</jsp:forward>	

<%	}else if (DETAILS)
	{
%>		<%@ include file="../../../Includes/JSPs/Lables/iSalesDetails_Lables.jsp"%>
		<%@ include file="ezSalesDetails.jsp"%>
<%	}
%>