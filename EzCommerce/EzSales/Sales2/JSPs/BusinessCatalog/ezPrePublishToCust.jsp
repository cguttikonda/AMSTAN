<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ include file="../../../Includes/JSPs/Lables/iAddGroup_Lables.jsp"%>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<jsp:useBean id="EzWorkFlowManager" class="ezc.ezworkflow.client.EzWorkFlowManager" scope="session" />

<%

	String [] products = null;
	String [] venCatalogs = null;
	String [] matIds = null;
	String [] types = null;

	String strTcount =  request.getParameter("TotalCount");

	if ( strTcount != null )
	{
		int totCount = (new Integer(strTcount)).intValue();

		if ( totCount > 0 )
		{
			products = new String[totCount];
			venCatalogs =new String[totCount];
			matIds =new String[totCount];
			types =new String[totCount];

			for ( int i = 0 ; i < totCount; i++ )
			{
				products[i] = request.getParameter("Product_"+i);
				venCatalogs[i] = request.getParameter("VendCatalog_"+i);
				matIds[i] = request.getParameter("matId_"+i);
				types[i] = request.getParameter("mmFlag_"+i);


			}
			session.setAttribute("productspc",products);
			session.setAttribute("prodCatalogspc",venCatalogs);
			session.setAttribute("matidspc",matIds);
			session.setAttribute("typespc",types);
		}
	}

	int soldToCnt=0;
	ArrayList desiredSteps=new ArrayList();
	desiredSteps.add("1");
	ezc.ezparam.EzcParams mainParamsu = new ezc.ezparam.EzcParams(false);
	ezc.ezworkflow.params.EziWFParams paramsu= new ezc.ezworkflow.params.EziWFParams();
	paramsu.setTemplate((String)session.getValue("Templet"));
	paramsu.setSyskey((String)session.getValue("SalesAreaCode"));
	paramsu.setPartnerFunction("AG");
	paramsu.setParticipant((String)session.getValue("UserGroup"));
	paramsu.setDesiredSteps(desiredSteps);
	mainParamsu.setObject(paramsu);
	Session.prepareParams(mainParamsu);
	ezc.ezparam.ReturnObjFromRetrieve retSoldTo =(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.getWorkFlowUsers(mainParamsu);
	if(retSoldTo!=null && retSoldTo.getRowCount()>0)
		soldToCnt = retSoldTo.getRowCount();

%>

<html>
<head>
<title>ezAdd Group</title>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<script LANGUAGE="JavaScript">

<%
	String fd	= request.getParameter("fd");
	String fwd 	= request.getParameter("fwd");
	if ( fd != null )
	{
%>
		alert("<%=group_L%>  <%= fd %> <%=alExist_A%>");
<%
	} //end if fd !=null
%>


function setFocus()
{
	document.forms[0].FavGroupDesc.focus();
}
function trim( inputStringTrim) {
fixedTrim = "";
lastCh = " ";
for( x=0;x < inputStringTrim.length; x++)
{
   ch = inputStringTrim.charAt(x);
 if ((ch != " ") || (lastCh != " ")) { fixedTrim += ch; }
lastCh = ch;
}
if (fixedTrim.charAt(fixedTrim.length - 1) == " ") {
fixedTrim = fixedTrim.substring(0, fixedTrim.length - 1); }
return fixedTrim
}
function isValidChar (c)
{   return ( ((c >= "A") && (c <= "Z")) || ((c >= "a") && (c <= "z")) || ((c >= "0") && (c <= "9")) ||(c==" ")||(c=="_")||(c=="-"))
}
function checkFolder(s)
{
    var i;
    // Search through string's characters one by one
    // until we find a non-numeric character.
    // When we do, return false; if we don't, return true.

    for (i = 0; i < s.length; i++)
    {   
        // Check that current character is number.
        var c = s.charAt(i);
        if (!isValidChar(c)) return false;
    }

    	// All characters are numbers or alphabets.
    	return true;

}
var req;
var stat="";
function Initialize()
{
	try
	{
		req = new ActiveXObject("Msxml2.XMLHTTP");
	}
	catch(e)
	{
		try
		{
			req = new ActiveXObject("Microsoft.XMLHTTP"); 
		}
		catch(oc)
		{
			req = null;
		}
	}
	if(! req&&typeof XMLHttpRequest != "undefined")
	{
		req = new XMLHttpRequest();
	}

}

function SendQuery(obj)
{
	stat=obj
	try
	{
		req = new ActiveXObject("Msxml2.XMLHTTP");
	}
	catch(e)
	{
		try
		{
			req = new ActiveXObject("Microsoft.XMLHTTP");
		}
		catch(oc)
		{
			req = null;
		}
	}



	if(!req&&typeof XMLHttpRequest!="undefined")
	{
		req = new XMLHttpRequest();
	}



	var url=""
	if(stat=='LIST')
		url=location.protocol+"//<%=request.getServerName()%>/CRI/EzCommerce/EzSales/Sales2/JSPs/BusinessCatalog/ezAjaxGetCustCatalogs.jsp?soldTo="+document.catgroup.soldTo.value+"&type="+stat+"&mydate="+ new Date();
	else if(stat=='CHECK')
		url=location.protocol+"//<%=request.getServerName()%>/CRI/EzCommerce/EzSales/Sales2/JSPs/BusinessCatalog/ezAjaxGetCustCatalogs.jsp?soldTo="+document.catgroup.soldTo1.value+"&type="+stat+"&favGrp="+document.catgroup.FavGroupDesc.value+"&mydate="+ new Date();
	//document.write(url)


	if(req!=null)
	{
		req.onreadystatechange = Process;
		req.open("GET", url, true);
		req.send(null);
	}


}

function Process() 
{
	if (req.readyState == 4)
	{
		var resText     = req.responseText;	 	        	

		if (req.status == 200)
		{
			if(stat=='LIST')
			{
				if(resText.indexOf('$$NODATA$$')!=-1)
				{
					document.getElementById('catalog').length = 0
					addOption(document.catgroup.catalog,"Select Catalog","sel");
					document.catgroup.status.value="No catalogs present for the selected customer"
				}
				else
				{
					var catDetArr = resText.split('¥')
					for(var i=0;i<catDetArr.length;i++)
					{
						var catArr = catDetArr[i].split('§')
						addOption(document.catgroup.catalog,catArr[1],catArr[0]);
					}
					document.catgroup.status.value="Please select catalog"
				}
			}
			else if(stat=='CHECK')
			{
				if(resText.indexOf('$$FOUND$$')!=-1)
				{
					document.catgroup.status.value="Catalog with name "+document.catgroup.FavGroupDesc.value+" already present for the selected customer"
				}
				else
				{
					document.body.style.cursor="wait"
					document.forms[0].submit();
				}
			}
		}
		else
		{
			if(req.status == 500)	 
			alert("Error");
		}
	}
}
function addOption(selectbox,text,value )
{
var optn = document.createElement("OPTION");
optn.text = text;
optn.value = value;
selectbox.options.add(optn);
}

function goBack(){
	document.forms[0].action = "../ShoppingCart/ezViewCart.jsp?fromMenu=Y";
	document.forms[0].submit();

}
function VerifyEmptyFields() 
{

	if(document.forms[0].type[0].checked)
	{
	
		if(document.forms[0].soldTo1.value == "sel")
		{
			alert("Please select customer");
			document.forms[0].soldTo1.focus()
			document.returnValue = false;

		}
		else if(trim(document.forms[0].FavGroupDesc.value) == "")
		{ 
			alert("Please Enter Group Name");
			document.forms[0].FavGroupDesc.focus()
			document.returnValue = false;
		}
		else if(trim(document.forms[0].FavWebDesc.value )== "" )
		{
			alert("Please Enter Description");
			document.forms[0].FavWebDesc.focus()
			document.returnValue = false;
		}
		else
		{
			document.returnValue = true;
			if ( document.returnValue )
			{
				if ( !checkFolder(document.forms[0].FavGroupDesc.value) )
				{
					alert('Group  can be alphabets , numbers ,"_","-" and space');
					document.returnValue = false;
					document.forms[0].FavGroupDesc.focus();
				}
				else if( !checkFolder(document.forms[0].FavWebDesc.value) )
				{
					alert('Group Description  can be alphabets , numbers ,"_","-" and space');
					document.returnValue = false;
					document.forms[0].FavWebDesc.focus();
				}
				else
				{
					document.returnValue = true;
				}
			}		
		}
		if(document.returnValue)
		{
			SendQuery('CHECK')
		}
	}
	else if(document.forms[0].type[1].checked)
	{
		if(document.forms[0].soldTo.value == "sel")
		{
			alert("Please select customer");
			document.forms[0].soldTo.focus()
			document.returnValue = false;

		}
		else if(document.forms[0].catalog.value == "sel")
		{
			alert("Please select catalog");
			document.forms[0].catalog.focus()
			document.returnValue = false;

		}
		else
		{
			document.returnValue = true;
			document.body.style.cursor="wait"
			document.forms[0].submit();
			
		}
	
	}
}


function selCustomer()
{
	if(document.catgroup.soldTo.value!='sel')
	{
	
		SendQuery('LIST')
	}


}
function selOpt(type)
{
	if(type=='CCP')
	{
		document.catgroup.type[0].checked=true
		document.catgroup.soldTo.selectedIndex=0
		document.catgroup.catalog.length=0
		addOption(document.catgroup.catalog,"Select Catalog","sel");
		document.catgroup.status.value=""
	
	}
	else if(type=='ACP')
	{
		document.catgroup.type[1].checked=true
		document.catgroup.soldTo1.selectedIndex=0
		document.catgroup.FavGroupDesc.value=''
		document.catgroup.FavWebDesc.value=''
		document.catgroup.status.value=""
	
	}
}
</script>
</head>
<body onLoad="setFocus()" scroll=no>
<form method="post" action="ezPublishToCust.jsp" name="catgroup">

<%
  String display_header = "Publish To Customer"; 
%>
<%@ include file="../Misc/ezDisplayHeader.jsp"%>

<br>
  <table width="70%"  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
    
    <tr>
    	<th width="100%" align="left" colspan=2 height="27"><input type="radio" name="type" value="CCP">Create New Catalog</td>
    
    </tr>
    <tr>
      <th width="30%" height="27" align="left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Customer</th>
      <td width="70%" height="27">
	<select name='soldTo1' id="soldTo1" tabIndex=2 style="border:1px solid" onFocus="selOpt('CCP')">
	<option value="sel">Select Customer</option>
<%				
	for(int i = 0;i < soldToCnt;i++)
	{
%>						
		<option value="<%=retSoldTo.getFieldValueString(i,"EC_ERP_CUST_NO")%>"><%=retSoldTo.getFieldValueString(i,"ECA_NAME")%>[<%=retSoldTo.getFieldValueString(i,"EC_ERP_CUST_NO")%>]</option>
<%
	}
%>				
	</select>
      </td>
    </tr>
    <tr>
    
    <tr>
      <th width="30%" height="27" align="left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Catalog</th>
      <td width="70%" height="27"><input type="text" class=InputBox name="FavGroupDesc" size="50" maxlength="50" onFocus="selOpt('CCP')"></td>
    </tr>
    <tr>
      <th width="30%" height="27" align="left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=desc_L%></th>
      <td width="70%" height="27"><input type="text" class=InputBox name="FavWebDesc" size="50" maxlength="50" onFocus="selOpt('CCP')"></td>
    </tr>

    <tr>
    	<th width="100%" align="left" colspan=2 height="27"><input type="radio" name="type" value="ACP">Select Existing Catalog</td>
    
    </tr>
    <tr>
      <th width="30%" height="27" align="left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Customer</th>
      <td width="70%" height="27">
	<select name='soldTo' id="soldTo" tabIndex=2 style="border:1px solid" onChange= 'selCustomer()' onFocus="selOpt('ACP')">
	<option value="sel">Select Customer</option>
<%				
	for(int i = 0;i < soldToCnt;i++)
	{
%>						
		<option value="<%=retSoldTo.getFieldValueString(i,"EC_ERP_CUST_NO")%>"><%=retSoldTo.getFieldValueString(i,"ECA_NAME")%>[<%=retSoldTo.getFieldValueString(i,"EC_ERP_CUST_NO")%>]</option>
<%
	}
%>				
	</select>
      </td>
    </tr>
    <tr>
      <th width="30%" height="27" align="left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Catalog</th>
      <td width="70%" height="27">
      <select name='catalog' id="catalog" tabIndex=2 style="border:1px solid">
      <option value="sel">Select Catalog</option>
      </select>
      </td>
    </tr>

    <tr>
      <td width="100%" height="27" colspan=2 align="left">STATUS:<input type=text name=status class=tx readonly size=130 value="">
      </td>
    </tr>


  </table>
  <div align="center"><br>
<%
  		buttonName = new java.util.ArrayList();
  		buttonMethod = new java.util.ArrayList();
  		buttonName.add("Publish");
  		buttonMethod.add("VerifyEmptyFields()");
  		buttonName.add("Back");
  		buttonMethod.add("goBack()");
  		out.println(getButtonStr(buttonName,buttonMethod));
%>
  </div>
</form>
<Div id="MenuSol"></Div>
</body>
</html>
