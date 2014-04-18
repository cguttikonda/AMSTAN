<%@ page import="java.util.*" %>
<%!
	public String getButtonStr(java.util.ArrayList buttonName,java.util.ArrayList buttonMethod)
	{    
		java.util.Hashtable iconsHash = new java.util.Hashtable();  
		/*  
		iconsHash.put("Back","<img src=\"../../Images/Common/back.gif\">");
		iconsHash.put("OK","<img src=\"../../Images/Common/ok_arrow.gif\">");
		iconsHash.put("Ok","<img src=\"../../Images/Common/ok_arrow.gif\">");
		iconsHash.put("Next","<img src=\"../../Images/Common/next_arrow.gif\">");
		iconsHash.put("GO","<img src=\"../../Images/Common/go.gif\">");
		iconsHash.put("Go","<img src=\"../../Images/Common/go.gif\">");
		iconsHash.put("Close","<img src=\"../../Images/Common/close_icon.gif\">");
		iconsHash.put("Submit","<img src=\"../../Images/Common/submit_icon.gif\">");
		iconsHash.put("Add","<img src=\"../../Images/Common/add_arrow.gif\">");
		iconsHash.put("Add New","<img src=\"../../Images/Common/add_arrow.gif\">");
		iconsHash.put("Edit","<img src=\"../../Images/Common/edit_icon.gif\">");
		iconsHash.put("Save","<img src=\"../../Images/Common/save_icon.gif\">");
		iconsHash.put("Clear","<img src=\"../../Images/Common/clear_icon.gif\">");
		iconsHash.put("Reset","<img src=\"../../Images/Common/reset_icon.gif\">");
		iconsHash.put("Add to QCF","<img src=\"../../Images/Common/add_arrow.gif\">");
		iconsHash.put("Move To","<img src=\"../../Images/Common/next_arrow.gif\">");
		iconsHash.put("Delete","<img src=\"../../Images/Common/delete_icon.gif\">");
		iconsHash.put("Source Of Supply","<img src=\"../../Images/Common/source_icon.gif\">");
		iconsHash.put("Upload","<img src=\"../../Images/Common/upload_icon.gif\">");
		iconsHash.put("Create PO","<img src=\"../../Images/Common/create_icon.gif\">");
		iconsHash.put("Create RFQ","<img src=\"../../Images/Common/create_icon.gif\">");
		iconsHash.put("Add Documents","<img src=\"../../Images/Common/add_documents.gif\">");
		iconsHash.put("Done","<img src=\"../../Images/Common/done_icon.gif\">");
		iconsHash.put("Cancel","<img src=\"../../Images/Common/cancel_icon.gif\">");
		iconsHash.put("Attachment","<img src=\"../../Images/Common/attach_icon.gif\">");
	   	iconsHash.put("Remove","<img src=\"../../Images/Common/remove_icon.gif\">");
	   	iconsHash.put("Print","<img src=\"../../Images/Common/print_icon.gif\">");
	   	iconsHash.put("Print Version","<img src=\"../../Images/Common/print_icon.gif\">");
    		iconsHash.put("Send Reminder","<img src=\"../../Images/Common/send_invitation.gif\">");
	   	iconsHash.put("Send Invitation","<img src=\"../../Images/Common/send_invitation.gif\">");
	   	iconsHash.put("Linkage Report","<img src=\"../../Images/Common/link_icon.gif\">");
	   	iconsHash.put("View Shipments","<img src=\"../../Images/Common/shipment_icon.gif\">");
	   	iconsHash.put("View Receipts","<img src=\"../../Images/Common/recipt_icon.gif\">");
	   	iconsHash.put("Payment Details","<img src=\"../../Images/Common/payment_icon.gif\">");
	   	iconsHash.put("Send To Vendor","<img src=\"../../Images/Common/relese_icon.gif\">");
	   	iconsHash.put("Change Address","<img src=\"../../Images/Common/address_icon.gif\">");
	   	iconsHash.put("Acknowledge","<img src=\"../../Images/Common/acknowledge_icon.gif\">");
	   	iconsHash.put("Inbox","<img src=\"../../Images/Common/inbox_icon.gif\">");
	   	iconsHash.put("Compose","<img src=\"../../Images/Common/compose_icon.gif\">");
	   	iconsHash.put("Folders","<img src=\"../../Images/Common/folder_icon.gif\">");
	   	iconsHash.put("Add Folder","<img src=\"../../Images/Common/add_folder.gif\">");
	   	iconsHash.put("Delete Folder","<img src=\"../../Images/Common/delete_icon.gif\">");
	   	iconsHash.put("Reply","<img src=\"../../Images/Common/reply_icon.gif\">");
	   	iconsHash.put("Add Lines","<img src=\"../../Images/Common/add_lines.gif\">");
	   	iconsHash.put("More Details","<img src=\"../../Images/Common/more_details.gif\">");
	   	iconsHash.put("Activate","<img src=\"../../Images/Common/active.gif\">");
	   	iconsHash.put("DeActivate","<img src=\"../../Images/Common/inactive.gif\">");
	   	iconsHash.put("Responses","<img src=\"../../Images/Common/reply_icon.gif\">");
	   	iconsHash.put("Quote","<img src=\"../../Images/Common/quote_icon.gif\">");
	   	iconsHash.put("Comitted Dates","<img src=\"../../Images/Common/commited_date.gif\">");
	   	iconsHash.put("Close QCF","<img src=\"../../Images/Common/close_icon.gif\">");
	   	iconsHash.put("Work Flow Audit","<img src=\"../../Images/Common/audit_icon.gif\">");
	   	*/
	   	               
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
	public static String replaceString(String theString,String from,String to) 
	{ 
		String ret=theString; 
		int go=0; 
		if(ret!=null)
		{
			while (ret.indexOf(from,go)>=0) 
			{ 
				go=ret.indexOf(from,go); 
				ret=ret.substring(0,go)+to+ret.substring(go+from.length()); 
				go=go+to.length(); 
			} 
		}
		return ret; 

	} 
	
%>
<%
 



	String ButtonDir 	= (String)session.getValue("userStyle");
        String userLang_meta 	= (String)session.getValue("userLang");
	java.util.ArrayList  buttonName = new java.util.ArrayList();
	java.util.ArrayList  buttonMethod = new java.util.ArrayList();
	
	 if(ButtonDir==null || "".equals(ButtonDir) || " ".equals(ButtonDir))
         	ButtonDir = "CRI"; 
         	
         else
         	ButtonDir = ButtonDir.toUpperCase(); 
         	
       
	String statusbar =  "onMouseover=\";window.status=\' \'; return true\" onClick=\";window.status=\' \'; return true\"";
           
%>



<meta http-equiv="Content-Type" content="text/html;charset=<%= "RUSSIAN".equals(userLang_meta)?"iso-8859-5":"iso-8859-1"%>">
<%//@ include file="../../Sales2/Library/Styles/Display/ezCRITheme.jsp" %>
<%//@ include file="../../Sales2/Library/Styles/Display/ezASTheme.jsp" %>
<Style>
.tx1{


font-family: arial,sans-serif;
	border:0;
	font-size: 10px;
	background-color:#EFEFEF;
	text-align:left;
	color: #000000

}
</Style>
<Script>

	
	function changeClass(obj, new_style)               
	{
	    obj.className = new_style;    
	}	 
</Script>
 