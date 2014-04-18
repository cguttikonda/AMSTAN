<%@ include file="../../../Includes/JSPs/SelfService/iAddressMail.jsp"%>


<%
	String toUser = "";
	String msgSubject = "Address Changed";
	String msgText = request.getParameter("billCompany")+""+request.getParameter("BillAddress1")+""+request.getParameter("BillCity")+""+request.getParameter("billToState")+""+request.getParameter("BillZip")+""+request.getParameter("BillCountry")+""+request.getParameter("Phone")+""+request.getParameter("shipAddr1")+""+request.getParameter("webAddr");//+""+Session.getUserId();

	if(retsoldto!=null)
	{
		for(int j=0;j<retsoldto.getRowCount();j++)
		{			
			toUser = retsoldto.getFieldValueString(j,"EU_ID")+",";
		}
	}


%>

toUser     <%=toUser%>
msgSubject <%=msgSubject%>
msgText    <%=msgText%>

<input type='hidden'  name="msgSubject" value="">
<input type='hidden'  name="msgText" value="">
<input type='hidden'  name="toUser" value="">
<input type='hidden'  name="ccUser" value="">
<input type='hidden'  name="bccUser" value="">