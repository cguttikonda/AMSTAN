function getAmndPODtl(ponum)
{
	var url="../RFQ/ezGetAmndPOdetails.jsp?PurOrderNum="+ponum+"&POorCon=P";
	var sapWindow=window.open(url,"newwin","width=800,height=500,left=20,resizable=no,scrollbars=yes,toolbar=no,menubar=no,minimize=no,status=yes");
}
function formEvents(formEv)
{
	document.myForm.action=formEv;
	document.myForm.submit();
}

function formEvents1(formEv)
{
	window.open(formEv,"PoPrint","menubar=no,statusbars=no,toolbar=no,width=700,height=600,left=10,top=10");
}

function funSubmit(formEv,formActionCode,formActionDesc,queryExists)
{
	if(queryExists == "Q")
	{
		if("100066" == formActionCode)
			alert("PO/Contract cannot be submitted for approval as you have sent a query");
		if("100080" == formActionCode)	
			alert("PO/Contract cannot be released as you have sent a query");
		if("100068" == formActionCode)	
			alert("PO/Contract cannot be rejected as you have sent a query");
	}
	else
	{
			if(document.myForm.reasons != null)
			{
				chkValue = document.myForm.reasons.value 
				if(chkValue  == "")
				{
					alert("Please enter comments before taking action on the document");
					document.myForm.reasons.focus()
					return;
				}
			}	
			 
			url = "../RFQ/ezRemarks.jsp";
			values="";
			if("100068" == formActionCode)
			{
				var dialogvalue=window.showModalDialog("../Misc/ezRejectToUser.jsp",window.self,"center=yes;dialogHeight=20;dialogWidth=30;help=no;titlebar=no;status=no;resizable=no")
				if ((dialogvalue=='Canceld~~')||(dialogvalue==null))
				{
					document.getElementById("ButtonsDiv").style.visibility="visible"
					document.getElementById("msgDiv").style.visibility="hidden"				
					return;
				}
				else
				{
					document.myForm.rejectToUser.value = dialogvalue;
				}
				if(dialogvalue != null && dialogvalue != "")
				{
					document.myForm.rejectToUser.value = dialogvalue;
				}
				else
				{
					return;
				}
			}
			
			if("100066" == formActionCode)
			{
				if(document.myForm.attachs.length>0)
				{
					document.myForm.attachflag.value="true";
					var astring=""
					for(var i=0;i<document.myForm.attachs.length;i++)
					{
						astring=astring+document.myForm.attachs.options[i].value+",";
					}
					astring	= astring.substring(0,astring.length-1);
					document.myForm.attachString.value=astring;
				}
			}
			
			document.getElementById("ButtonsDiv").style.visibility="hidden"
			document.getElementById("msgDiv").style.visibility="visible"
			
			document.myForm.actionCode.value = formActionCode
			
			document.myForm.target = "_self"
			document.myForm.action = formEv
			
			document.myForm.submit();
	}	
}
function goToPlantAddr(plant)
{
	window.open("../Misc/ezPlantAddress.jsp?plant="+plant,"plantdet", "status=no,toolbar=no,menubar=no,location=no,left=250,top=200,width=450,height=320");
}

function funOpenWin(colNo,vendorNo,docType)
{
	document.myForm.commentType.value="QUERY";
	var retValue = window.showModalDialog("../RFQ/ezAddQcfQueriesWindow.jsp?COLNO="+colNo+"&DOCTYPE="+docType+"&Vendor="+vendorNo,window.self,"center=yes;dialogHeight=30;dialogWidth=50;help=no;titlebar=no;status=no;minimize:yes")	
}
function showStatusWindow(colRfqNo,netPr,loginType,auth,soldto)
{
	window.showModalDialog("../RFQ/ezShowQcfStatus.jsp?COLNO="+colRfqNo+"&NETPR="+netPr+"&loginType="+loginType+"&AUTH="+auth+"&SOLDTO="+soldto,window.self,"center=yes;dialogHeight=30;dialogWidth=35;help=no;titlebar=no;status=no;resizable=no")
}

function SAPView(num)
{
	var url="../RFQ/ezQCFSAPPrint.jsp?qcfNumber="+num;
	var sapWindow=window.open(url,"newwin","width=850,height=650,left=20,resizable=no,scrollbars=yes,toolbar=no,menubar=no,minimize=no,status=yes");
}

function getConDetPDF()
{
	document.myForm.action="../Purorder/ezOfflineConDetPrint.jsp";
	document.myForm.submit();
}

function showAttchdFiles(docNumber,docType)
{
	var url="../UploadFiles/ezAttachmentList.jsp?docNum="+docNumber+"&docType="+docType+"&attachdFiles="+document.myForm.attachString.value;
	var retValue = window.showModalDialog(url,"","width=450,height=350,left=320,top=120,resizable=no,scrollbars=no,toolbar=no,menubar=no,minimize=no,status=yes");
	

	if(retValue!=null)
	{
		if(retValue=="Canceld~~")
		{
			//window.close();
		}
		else
		{
			var retArgs = retValue.split(",");
			if(retArgs.length > 0)
				document.myForm.attachflag.value = "true"
			document.myForm.attachString.value = retValue
		}	
	}	
	
	
	
	/*if(retValue != null || retValue != "" || retValue != "Canceld~~" || "undefined" != retValue || retValue != "CLOSE")
	{
		var retArgs = retValue.split(",");
		if(retArgs.length > 0)
			document.myForm.attachflag.value = "true"
		document.myForm.attachString.value = retValue
	}*/
}	
 function funNavigate(navFileName)
{
	if(navFileName == "")
		history.go(-1);
	else
		document.location.href=navFileName;
}
function commentsSpace(url)
{
	var retValue = window.showModalDialog(url,window.self,"center=yes;dialogHeight=25;dialogWidth=40;help=no;titlebar=no;status=no;minimize:yes")	
	if ((retValue=='Canceld~~')||(retValue==null))
	{
		return;
	}
	else
	{
		document.myForm.reasons.value = retValue;
	}
	
}
function textCounter(field, countfield, maxlimit) 
{
	if (field.value.length > maxlimit) 
	{
		alert("Comments Limit Exceeded : You can enter only "+maxlimit+" in the Comments field");
		field.value = field.value.substring(0, maxlimit);
		return false;
	}	
	else 
	{
		countfield.value = maxlimit - field.value.length;
	}	
	return true
}
function funOpenFile()
{
	var dbClickOnFlNm = document.myForm.attachs.value
	if(dbClickOnFlNm!= null && dbClickOnFlNm!= "")
	{
		var winHandle = window.open("../RFQ/ezViewFile.jsp?CLOSEWIN=N&filePath="+dbClickOnFlNm,"newwin","width=800,height=550,left=100,top=30,resizable=yes,scrollbars=yes,toolbar=no,menubar=no,minimize=yes,status=no,location=yes");		
	}	
}

function funRemove()
{
	var attachments=new Array();
	var j=0;
	var count=0;
	if(document.myForm.attachs.length>0)
	{
		for(var i=0;i<document.myForm.attachs.length;i++)
		{
			if(document.myForm.attachs.options[i].selected==true)
			{
				count++;
			}
		}
		if(count==0)
		{
			alert("Please Select a File To Remove");
		}
	}
	else
	{
		alert("No Attachments To Remove");
	}
	for(var i=0;i<document.myForm.attachs.length;i++)
	{
		if(document.myForm.attachs.options[i].selected==false)
		{
			attachments[j]=document.myForm.attachs.options[i].value;
			j++;
		}
	}

	for(var i=document.myForm.attachs.length;i>=0;i--)
	{
		document.myForm.attachs.options[i]=null;
	}
	for(var i=0;i<attachments.length;i++)
	{
		document.myForm.attachflag.value="true"
		document.myForm.attachs.options[i]=new Option(attachments[i],attachments[i]);
	}
}