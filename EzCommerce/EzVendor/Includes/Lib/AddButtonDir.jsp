<%@ page import="java.util.*,ezc.ezutil.*,java.io.*,ezc.ezutil.FormatDate" %>
<%!
	java.util.ResourceBundle buttonBundle = null;
	String button_lang = null;
	
	public String getButtonLabel(String LKey){
		String buttonText="";
		if(LKey != null && buttonBundle != null){
			try{
				LKey =(LKey.trim()).replace(' ','_');
				buttonText = buttonBundle.getString(LKey);
			}catch(Exception e){ buttonText = LKey; }
		}
		else
			buttonText = LKey;

		return 	buttonText;
	}
	
	public String getNumberFormat(String dblValue,int maxDecimal)
	{
		String retValue = "";
		try
		{
			java.text.NumberFormat numberFormat = java.text.NumberFormat.getInstance();
			numberFormat.setMaximumFractionDigits(0);
			numberFormat.setMinimumFractionDigits(maxDecimal);
			if(dblValue != null && !"null".equals(dblValue) && !"".equals(dblValue.trim()))
				retValue = numberFormat.format(Double.valueOf(dblValue))+"";
			else	
				retValue = "0";
				
			retValue = retValue.replaceAll(",","");
		}
		catch(Exception ex)
		{
			retValue = dblValue;
		}
		return retValue;
	}
	
	public static String replaceStr(String theString,String from,String to)
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
		String bundleStr = "";
		
			      
		if(button_lang == null || "null".equals(button_lang))
			button_lang = "ENGLISH" ;
		else
			button_lang = (button_lang.toUpperCase()).trim() ;	
			          	   
		//EzVendorButtons_ENGLISH
		bundleStr = "EzVendorButtons_"+button_lang;	   
		try{
			buttonBundle = ResourceBundle.getBundle(bundleStr);
		 }catch(Exception e){ }
	
		for(int i=0;i<buttonName.size();i++)
		{
			titleTip = "Click here to ";  
			key 	= (String)buttonName.get(i);
			if(!"EXTRA_CELL".equals(key))
			{
				method 	= (String)buttonMethod.get(i);
				titleTip += key;
				sb.append("<td nowrap class='TDCmdBtnOff' onMouseDown='changeClass(this,\"TDCmdBtnDown\")' onMouseUp='changeClass(this,\"TDCmdBtnUp\")' onMouseOver='changeClass(this,\"TDCmdBtnUp\")' onMouseOut='changeClass(this,\"TDCmdBtnOff\")' onClick='javascript:"+method+"' valign=top title = '"+titleTip+"'>");
				iconStr = (String)iconsHash.get(key);
				key = getButtonLabel(key);
				if(iconStr!=null)
					sb.append("&nbsp;"+iconStr+"&nbsp;<b>"+key+" &nbsp;&nbsp;&nbsp;</b></td>"); 
				else
					sb.append("&nbsp;&nbsp;&nbsp;&nbsp;"+key+" &nbsp;&nbsp;&nbsp;&nbsp;</td>"); 
			}
			else
			{
				sb.append("<td nowrap class='blankcell'>&nbsp;</td><td class='blankcell'>&nbsp;</td>");
			}
			
		}
		sb.append("</TR></TABLE>");
		return sb.toString();
	}	
%>
<%
	
	
	button_lang = (String)session.getValue("userLang");
	
	response.setHeader("Pragma", "No-cache");
	response.setDateHeader("Expires", 0);
	response.setHeader("Cache-Control", "no-cache");
	String ButtonDir = "PINK";
	
	session.putValue("MYLOGINMILLIS",String.valueOf(System.currentTimeMillis()));

	
	if(("PINK").equals(ButtonDir))
	{
%>
		<link rel="stylesheet" href="../../Library/Styles/ezThemePink.css">
<%
		session.putValue("fontColor","white");
		session.putValue("fontColorOver","black");
		session.putValue("menuBGColor","#EDF1F4");
		session.putValue("menuBGColorOver","#F3EDD8");
		session.putValue("menuSeperatorColor","#F3EDD8");
		session.putValue("menuSeperatorColor1","black");
	}
	ButtonDir="ENGLISH/"+ButtonDir;
	String statusbar =  "onMouseover=\";window.status=\' \'; return true\" onClick=\";window.status=\' \'; return true\"";
	java.util.ArrayList  buttonName = new java.util.ArrayList();
	java.util.ArrayList  buttonMethod = new java.util.ArrayList();
%>
<Script>
	function changeClass(obj, new_style)
	{
	    obj.className = new_style;
	}
	function setMessageVisible()
	{
		var divVal = document.getElementById("ButtonDiv");
		if(divVal == null)
		 	alert("divVal is null !!!!");
		else
		divVal.style.visibility="hidden";
		document.getElementById("EzButtonsMsg").style.visibility="visible";
	}
	function navigateBack(fileName)
	{
		location.href=fileName
	}
	function selectCheckAll()
	{
		var tocheck = document.myForm.checkAll.checked
		var checkObj = document.myForm.chk1
		if(checkObj != null)
		{
			var checkLength = checkObj.length;
			if(isNaN(checkLength))
			{
				if(document.myForm.chk1.checked)
					document.myForm.chk1.checked=false
				else	
					document.myForm.chk1.checked=true
			}
			else
			{
				for(i=0;i<checkLength;i++)
				{
					if(!document.myForm.chk1[i].disabled)
					{
						if(tocheck)
						{
							document.myForm.chk1[i].checked=true
						}
						else
						{
							document.myForm.chk1[i].checked=false
						}
					}	
				}
			}	
		}	
	}

</Script>