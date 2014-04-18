<%@ page import="java.util.*" %>
<%!
	public String getButtonStr(java.util.ArrayList buttonName,java.util.ArrayList buttonMethod)
	{
		java.util.Hashtable iconsHash = new java.util.Hashtable();
	   	               
	   	String   titleTip = "";           
	   	          
		StringBuffer sb = new StringBuffer();
		sb.append("<table border=0 cellspacing=3 cellpadding=5 class=buttonTable><tr>");
		String key = "",method="",iconStr="";
		for(int i=0;i<buttonName.size();i++)
		{
			titleTip = "Click here to ";  
			key = (String)buttonName.get(i);
			method = (String)buttonMethod.get(i);
			titleTip += key;
			sb.append("<td nowrap class='TDCmdBtnOff' onMouseDown='changeClass(this,\"TDCmdBtnDown\")' onMouseUp='changeClass(this,\"TDCmdBtnUp\")' onMouseOver='changeClass(this,\"TDCmdBtnUp\")' onMouseOut='changeClass(this,\"TDCmdBtnOff\")' onClick='javascript:"+method+"' valign=top title = '"+titleTip+"'>");
			iconStr = (String)iconsHash.get(key);
			
			
			
			if(iconStr!=null)
				sb.append("&nbsp;"+iconStr+"&nbsp;<b>"+key+" &nbsp;&nbsp;&nbsp;</b></td>"); 
			else
				sb.append("<b>&nbsp;&nbsp;&nbsp;&nbsp;"+key+" &nbsp;&nbsp;&nbsp;&nbsp;</b></td>"); 
		}
		sb.append("</TR></TABLE>");
		return sb.toString();
	}	
%>
<%


	String dtFrmt = (String)session.getValue("DATEFORMAT");
	String frmtkey=(String)session.getValue("formatKey");

	String ButtonDir 	= (String)session.getValue("userStyle");
        String userLang_meta 	= (String)session.getValue("userLang");
	java.util.ArrayList  buttonName = new java.util.ArrayList();
	java.util.ArrayList  buttonMethod = new java.util.ArrayList();
	
	 if(ButtonDir==null || "".equals(ButtonDir) || " ".equals(ButtonDir))
         	ButtonDir = "BROWN";
         else
         	ButtonDir = ButtonDir.toUpperCase();
       
	String statusbar =  "onMouseover=\";window.status=\' \'; return true\" onClick=\";window.status=\' \'; return true\"";

%>
<link type="text/css" rel="stylesheet" href="../../EzSales/Sales2/Library/Styles/Display/ez<%=ButtonDir%>Theme.css">
<meta http-equiv="Content-Type" content="text/html;charset=<%= "RUSSIAN".equals(userLang_meta)?"iso-8859-5":"iso-8859-1"%>">
<Script>
	function changeClass(obj, new_style)
	{
	    obj.className = new_style;
	}	
</Script>
