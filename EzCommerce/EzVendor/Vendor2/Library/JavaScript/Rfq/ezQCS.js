function showWin(qcf,quan)
{
	var url="ezQcfComments.jsp?qcfNumber="+qcf+"&quantity="+quan;
	newWindow=window.open(url,window.self,"width=750,height=550,left=20,resizable=no,scrollbars=yes,toolbar=no,menubar=no,minimize=no,status=yes");
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

function openByPassList(qcfNetPrice,queryCount)
{
	if(document.myForm.qcfComments.value=="")
	{
		alert("Please Enter Your Comments")
		document.myForm.bypass.checked= false;
		document.myForm.qcfComments.focus();
		return;
	}	
	
	if(document.myForm.bypass.checked)
	{
		var retValue = window.showModalDialog("ezByPassList.jsp?PRICE="+qcfNetPrice,window.self,"center=yes;dialogHeight=25;dialogWidth=30;help=no;titlebar=no;status=no;minimize:yes")	
		if(retValue != null)
		{
			var retArgs = 	retValue.split("¥")
			if(retArgs[1] != null)
			{
				if(retArgs[1] == "APPROVE")
				{
					funSubmit("100067",queryCount)
					document.myForm.byPassAllow.value = 'N'
				}	
				else
				{
					document.myForm.hideBypassCount.value=retArgs[0];
					document.myForm.byPassAllow.value = 'Y'
				}	
			}
			else
				document.myForm.byPassAllow.value = 'N'
		}	
			
	}	
}

function funPrint()
{
	window.print();
}

function rank()
{
	var collectiveRFQNo = document.myForm.collectiveRFQNo.value;
	document.myForm.action = "ezRFQList.jsp?collectiveRFQNo="+collectiveRFQNo;
	document.myForm.submit();		
}

function funBack()
{
	document.myForm.action = "ezListQCS.jsp";
	document.myForm.submit();
	
}

function LTrim(str)
{
	var whitespace = new String(" \t\n\r ");
	var s = new String(str);
	if (whitespace.indexOf(s.charAt(0)) != -1) {
	    var j=0, i = s.length;
	    while (j < i && whitespace.indexOf(s.charAt(j)) != -1)
		j++;
	    s = s.substring(j, i);
	}
	return s;
}
function RTrim(str)
{
	var whitespace = new String(" \t\n\r ");
	var s = new String(str);
	if (whitespace.indexOf(s.charAt(s.length-1)) != -1) {
	    var i = s.length - 1;       // Get length of string
	    while (i >= 0 && whitespace.indexOf(s.charAt(i)) != -1)
		i--;
	    s = s.substring(0, i+1);
	}
	return s;
}
function Trim(str)
{
	return RTrim(LTrim(str));
}
	


function funSubmit(action,queryCount)
{
	if(queryCount!=null)
	{
		if(queryCount > 0)
		{
			if("100066" == action)
				alert("QCF cannot be submitted for approval as you have sent a query on this qcf");
			if("100067" == action)	
				alert("QCF cannot be Approved as you have sent a query on this qcf");
			if("100068" == action)	
				alert("QCF cannot be rejected as you have sent a query on this qcf");
			return;
		}	
	}
	
	
	
	if("100066" == action)
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
	
	var len = document.myForm.propose.length     
	var Count = 0;
	if(!isNaN(len))
	{
	     for(var i=0;i<len;i++)
	     {
	         if(document.myForm.propose[i].checked)
	     	 {
		      Count++;										     			
		 }
	     }	
	}
	else
	{
	     if(document.myForm.propose.checked)
	     {
	     	    Count++;	
	     }
     	}
	if(Count==0)
	{
		alert("Please Propose atleast one Quotation")
		return false;
	}
	
	
	if(document.myForm.qcfComments.value!="")
	{
		var k=0;
		var qcfCmnVal = document.myForm.qcfComments.value;
		qcfCmnVal=Trim(qcfCmnVal);
		var len =  qcfCmnVal.length;
		
		if(len==0)
		{   
			alert("Please Enter Your Comments")
			document.myForm.qcfComments.focus();
			return false;
		}
	}
	

	
	if(document.myForm.qcfComments.value=="")
	{   
		alert("Please Enter Your Comments")
		document.myForm.qcfComments.focus();
		return false;
	}
	else if(textCounter(document.myForm.qcfComments,document.myForm.remLen,2000) )
	{
		document.getElementById("ButtonsDiv").style.visibility="hidden"
		document.getElementById("msgDiv").style.visibility="visible"
		document.myForm.type.value='A'
		document.myForm.actionNum.value=action
		if("100066" == action)
			document.myForm.prevStatus.value= 'SUBMITTED'
		if("100067" == action)
			document.myForm.prevStatus.value= 'APPROVED'
		if("100068" == action)	
		{
			document.myForm.prevStatus.value= 'REJECTED'
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
		}
		
		if(action == '100067')
		{
			
			var len = document.myForm.propose.length;
			if(!isNaN(len))
			{
				for(var  indx=0;indx<len;indx++)
				{
					if(document.myForm.propose[indx].disabled==true)
						document.myForm.propose[indx].disabled=false;
				}
			}
			else
			{
				if(document.myForm.propose.disabled==true)
					document.myForm.propose.disabled=false;
			}
		}	
		
		document.myForm.action="ezSaveQcfComments.jsp"
		document.myForm.submit();
	}
}
function reQuote()
{
	if(!checkRoleAuthorizations("SEND_REQUOTE"))
	{
		alert("You are not authorized to send for requote to Vendor");
		return;
	}	
	
	document.myForm.action="ezReQuoteRFQList.jsp";
	document.myForm.submit();
} 
function funOpenWin(colNo)
{
	document.myForm.commentType.value="QUERY";
	var retValue = window.showModalDialog("ezAddQcfQueriesWindow.jsp?COLNO="+colNo+"&DOCTYPE=QCF",window.self,"center=yes;dialogHeight=30;dialogWidth=50;help=no;titlebar=no;status=no;minimize:yes")	
}
function showAttchdFiles(QcfNumber,docType)
{
	var url="../UploadFiles/ezShowAttchdFiles.jsp?docNum="+QcfNumber+"&docType="+docType;
	newWindow=window.open(url,"","width=450,height=350,left=320,top=120,resizable=no,scrollbars=no,toolbar=no,menubar=no,minimize=no,status=yes");
}	
function funShowVndrDetails(syskey,soldto)
{
		var retValue = window.showModalDialog("ezVendorContactDetails.jsp?SysKey="+syskey+"&SoldTo="+soldto,window.self,"center=yes;dialogHeight=25;dialogWidth=40;help=no;titlebar=no;status=no;minimize:yes")	
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

function showStatusWindow(colRfqNo,netPr,loginType)
{
	window.showModalDialog("ezShowQcfStatus.jsp?COLNO="+colRfqNo+"&NETPR="+netPr+"&loginType="+loginType,window.self,"center=yes;dialogHeight=30;dialogWidth=35;help=no;titlebar=no;status=no;resizable=no")
}

function openGraphWin(rptValue,type)
{
	var rptData = "";
	if(type == 'RQPA')
		rptData = "CollectiveRfq="+rptValue
	if(type == 'MPA')	
		rptData = "Material="+rptValue
	var obj = window.open('ezNewLineReportChart.jsp?'+rptData+'&Report='+type,"material","resizable=yes,left=0,top=10,height=500,width=795,status=no,toolbar=no,menubar=no,location=no,scrollbars=yes");
	
}
function showConfirmAlert(chkObj,vendor,rank,flg)
{
	if(chkObj.checked)
	{
		if(flg=="Y")
		{
			if(!confirm("Are you sure about proposing the Vendor: "+ vendor +" with Rank: "+rank+ " and current quoted price is greater than previously ordered price?"))
			{
				chkObj.checked=false;
			}
		}else if(flg=="O")
		{
			if(!confirm("Are you sure about proposing the vendor other than L1?"))
			{
				chkObj.checked=false;
			}
		}
	}
}
function funOpenFile()
{
	var dbClickOnFlNm = document.myForm.attachs.value
	/*var filePaths =  document.myForm.filePaths.value;
	var viewFnmPath = "";
	var fileWithPaths = filePaths.split("##");
	for(var i=0;i<fileWithPaths.length;i++)
	{
		viewFile = fileWithPaths[i].split("$$");
		fileName = viewFile[1];
		if(dbClickOnFlNm == fileName)
		{
			viewFnmPath =  viewFile[0];
			break;
		}  
	}
	if(viewFnmPath!= null || viewFnmPath!= "")
	{
		if(viewFnmPath.length > 0)
		{
		
			window.open("ezViewFile.jsp?filePath="+dbClickOnFlNm,"newwin","width=800,height=550,left=100,top=30,resizable=yes,scrollbars=yes,toolbar=no,menubar=no,minimize=yes,status=no,location=yes");		
		}	
	}
	*/
	if(dbClickOnFlNm!= null && dbClickOnFlNm!= "")
	{
		var winHandle = window.open("ezViewFile.jsp?CLOSEWIN=N&filePath="+dbClickOnFlNm,"newwin","width=800,height=550,left=100,top=30,resizable=yes,scrollbars=yes,toolbar=no,menubar=no,minimize=yes,status=no,location=yes");		
		//closeAttachWindow(winHandle,'N')
	}	
}
function closeAttachWindow(winHandle,checkVal)
{
	if(checkVal == 'Y')
	{
		winHandle.close();
	}
	else
	{
		setTimeout("closeAttachWindow("+winHandle+",'Y')",5000);
	}
}
function goBack(type)
{
	if(type == 'RFQLINK')
		location.href='ezRFQLinkageReport.jsp'
	else
		history.go(-1)
}
function setDimensions()
{
	if(screen.height == 600)
	{
		tabHeight="50%"
		var byPassDiv = document.getElementById("byPassDiv");
		var commentsDiv = document.getElementById("commentsDiv");
		var InnerBox1Div = document.getElementById("InnerBox1Div");
		if(byPassDiv != null)
		byPassDiv.style.top = "30%"

		if(commentsDiv != null)
		{
			commentsDiv.style.top = "22%";
			commentsDiv.style.height = "50%"
		}	

		if(InnerBox1Div != null)
		{
			InnerBox1Div.style.top = "22%";
			InnerBox1Div.style.height = "50%";
		}	
	}
	else
	{
		tabHeight="65%"
		var byPassDiv = document.getElementById("byPassDiv")
		if(byPassDiv != null)
			byPassDiv.style.top = "50%"
	}
}
function openWin(num)
{
	var url="ezQCFPrint.jsp?qcfNumber="+num;
	var sapWindow=window.open(url,"newwin","width=800,height=650,left=0,top=0,resizable=no,scrollbars=yes,toolbar=no,menubar=no,minimize=no,status=yes");
}
function SAPView(num)
{
	var url="ezQCFSAPPrint.jsp?qcfNumber="+num;
	var sapWindow=window.open(url,"newwin","width=850,height=650,left=20,resizable=no,scrollbars=yes,toolbar=no,menubar=no,minimize=no,status=yes");
}
function lastPODtlsWin(matNum)
{
	var url="ezGetLastPODetails.jsp?matNumber="+matNum;
	var poDtlWin=window.open(url,"powin","width=850,height=350,left=100,top=120,resizable=no,scrollbars=yes,toolbar=no,menubar=no,minimize=no,status=yes");
}
function commentsSpace()
{
	var retValue = window.showModalDialog("ezQCFCommentSpace.jsp",window.self,"center=yes;dialogHeight=25;dialogWidth=40;help=no;titlebar=no;status=no;minimize:yes")	
	if ((retValue=='Canceld~~')||(retValue==null))
	{
		return;
	}
	else
	{
		document.myForm.qcfComments.value = retValue;
	}
	
}
