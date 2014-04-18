<%!
	public static String replaceString(String theString,String from,String to)
	{
		int go=0;
		String ret=theString;
		while (ret.indexOf(from,go)>=0)
		{
		go=ret.indexOf(from,go);
		ret=ret.substring(0,go)+to+ret.substring(go+from.length());
		go=go+to.length();
		}
		return ret;
	}
	public String getButtons(java.util.ArrayList names,java.util.ArrayList actions)
	{
		StringBuffer sb=new StringBuffer("<Table  border='0' cellspacing='0' cellpadding='0' align = center>");

		sb.append("<Tr>");
		sb.append("<Td class='TDCommandBarBorder'>");
		sb.append("<Table border='0' cellspacing='3' cellpadding='5'>");
		sb.append("<Tr>");    		
		String action = null;
		String bName  = null;
		for(int i=0;i<names.size();i++)
		{
		action = (String)actions.get(i);
		bName  = (String)names.get(i);

		sb.append("<Td nowrap class='TDCmdBtnOff' onMouseDown=\"changeClass(this,'TDCmdBtnDown')\" onMouseUp=\"changeClass(this,'TDCmdBtnUp')\" onMouseOver=\"changeClass(this,'TDCmdBtnUp')\" onMouseOut=\"changeClass(this,'TDCmdBtnOff')\"  onClick=\""+action+"\">");
		sb.append("<b>"+bName+"</b>");
		sb.append("</Td>");
		}
		sb.append("	</Tr></Table></Td>");
		sb.append("</Tr></Table>");
		return sb.toString();
	}
%>

<%
	java.util.ArrayList butNames   = new java.util.ArrayList();
	java.util.ArrayList butActions = new java.util.ArrayList();
	session.putValue("MYLOGINMILLIS",String.valueOf(System.currentTimeMillis()));

	response.setHeader("Pragma", "No-cache");
	response.setDateHeader("Expires", 0);
	response.setHeader("Cache-Control", "no-cache");

	String ButtonDir 	= (String)session.getValue("userStyle");
	String userLang_meta 	= (String)session.getValue("userLang");
	String statusbar 	=  "onMouseover=\";window.status=\' \'; return true\" onClick=\";window.status=\' \'; return true\"";	
%>

<%
	ButtonDir="ENGLISH/ORANGE";
	session.putValue("fontColor","white");
	session.putValue("fontColorOver","black");
	session.putValue("menuBGColor","#EDF1F4");
	session.putValue("menuBGColorOver","#F3EDD8");
	session.putValue("menuSeperatorColor","#F3EDD8");
	session.putValue("menuSeperatorColor1","black");
%>		
	<!--<link rel="stylesheet" href="../../Library/Styles/ezThemeBlue.css">-->
<%
	java.util.Vector authorizationVector = (java.util.Vector)session.getValue("USERAUTHS");
	int authVectSize = 0;
	if(authorizationVector != null)
		authVectSize = authorizationVector.size();
%>

<Script>
	var roleAuthScriptStore=new Array;
	<%
		for(int i=0;i<authVectSize;i++)
		{
	%>
			roleAuthScriptStore[<%=i%>] = '<%=authorizationVector.get(i)%>';
	<%
		}
	%>
	function checkRoleAuthorizations(authDesc)
	{
		var returnAuthCheck = false;
		var userAuthCount = roleAuthScriptStore.length
		for(i=0;i<userAuthCount;i++)
		{
			if(authDesc == roleAuthScriptStore[i])
			{
				returnAuthCheck = true;
				break;
			}
		}
		return returnAuthCheck;
	}
	function changeClass(obj, new_style) 
	{
		    obj.className = new_style;
	}
</Script>
<Script>
	function ezPop(message,poptype)
	{
		var returnValue = ""
		
		if(poptype == "ALERT")
			returnValue = window.showModalDialog("../Misc/ezPopUpwindow.jsp?WINTYPE=ALERT&MESSAGE="+message,"ALERT","center=yes;dialogHeight=10;dialogWidth=30;help=no;titlebar=no;status=no;minimize:no")	
		if(poptype == "CONFIRM")
			returnValue = window.showModalDialog("../Misc/ezPopUpwindow.jsp?WINTYPE=CONFIRM&MESSAGE="+message,"CONFIRM","center=yes;dialogHeight=10;dialogWidth=30;help=no;titlebar=no;status=no;minimize:no")	
		if(poptype == "PROMPT")
			returnValue = window.showModalDialog("../Misc/ezPopUpwindow.jsp?WINTYPE=PROMPT&MESSAGE="+message,"CONFIRM","center=yes;dialogHeight=10;dialogWidth=30;help=no;titlebar=no;status=no;minimize:no")	
		return returnValue;
	}
</Script>