
<%@ include file="../../Library/Globals/ezCacheControl.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@  page import ="ezc.ezparam.*" %>
<%@ page import = "ezc.ezutil.FormatDate,java.util.*" %>
<%
String ind = request.getParameter("ind");
String status = request.getParameter("status");
String unitQty = request.getParameter("unitQty");
String itemNumber=request.getParameter("itemNo");
String totQty=request.getParameter("totQty");
String  fkey=(String)session.getValue("formatKey");
ReturnObjFromRetrieve ret=(ReturnObjFromRetrieve) session.getValue("EzDeliveryLines");
String matdesc = request.getParameter("matdesc");
String[] reqQty = new String[10];
String[] reqDate = new String[10];
int z=0;
for(int i=0;i<ret.getRowCount();i++)
{
	if(ret.getFieldValueString(i,"EZDS_ITM_NUMBER").equals(itemNumber))
	{
	 reqQty[z] =ret.getFieldValueString(i,"EZDS_REQ_QTY");
	 reqDate[z] = ret.getFieldValueString(i,"EZDS_REQ_DATE");
	 z++;
	}
}
double totReqQty=0;
for(int i=0;i<10;i++)
{
		reqQty[i] = ( (reqQty[i] == null) || (reqQty[i].trim().length() ==0) )?"0":reqQty[i];
		reqDate[i] = ( (reqDate[i] == null) || ("null".equals(reqDate[i]) ) )?"":reqDate[i];
		totReqQty=totReqQty+Double.parseDouble(reqQty[i]);
}
%>
<%@ include file="../../../Includes/JSPs/Lables/iAddDatesEntry_Lables.jsp"%>
<html>
<head>
<title>Required Quantites and  Dates.</title>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<%// @ include file="../../../Includes/JSPs/Misc/iShowCal_EZC.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iShowCal.jsp"%>
<script src="../../Library/JavaScript/Misc/ezTrim.js">
</script>
<script>
function verifyField(theField,ind)
{
	
	theField.value = funTrim(theField.value)
	var fValue=theField.value
	val="<%=unitQty%>"
	prd="<%=matdesc%>"
/*
	if((val!="")&&(!isNaN(val)))
	{
		if((fValue%val)!=0)
		{
			alert("Shipper quantity of "+ prd +" is  : " + val  +"\nSolution :Please enter multiple of "+ val)
			theField.focus();
			return false;
		}

	}
*/
	theField.value = funTrim(theField.value)
	datField = eval("document.f1.dat"+ind)
	if(theField.value == "")
	{
		theField.value="0"
		datField.value=""
	}
	else 
	{
		if(theField.value < 0)
		{
			alert("<%=qtyNotZero_A%>");

			theField.value="";
			theField.focus();
			return false;
		}
		else if(isNaN(theField.value))
		{
			alert("<%=plzEntValiQty_A%>");

			theField.value="";
			theField.focus();
			return false;
		}else if(theField.value == 0)
		{
			datField.value=""
		}
	}
	return true;
	
}

var today ="<%= FormatDate.getStringFromDate(new Date(),fkey,FormatDate.MMDDYYYY) %>"


function setReqDateValue()
{
	var reqdat = new Array();
	var reqQty = new Array();

	for(t=0;t<10;t++)
	{
	   	obj = eval("document.f1.dat"+t)
		obj1 = eval("document.f1.Qty["+t+"]")

		reqdat[t]=funTrim(obj.value)
		reqQty[t] = funTrim(obj1.value)
	
		reqdat[t]=( (reqdat [t] == null) || (reqdat[t]=="") || (reqdat[t] == "undefined") || (reqdat[t] == null) )?0:reqdat[t];
		reqQty[t] =( (reqQty[t] == null) || (reqQty[t] =="") || (reqQty[t] == "undefined") || (reqQty[t] == null) )?0:reqQty[t];

		if( ( (reqQty[t] != 0) && (reqQty[t] != "") ) || ((reqdat[t] != 0) && (reqdat[t] != "") ) )
		{
			if( (reqQty[t] != 0) && (reqQty[t] != "") )	
			{
				if( (reqdat[t] == 0) || (reqdat[t] == "") )
				{
					alert("<%=plzEntReqDate_A%>")
					obj1.focus()
					return false
				}
				
			}
		
			if((reqdat[t] != 0) && (reqdat[t] != ""))
			{
				if( (reqQty[t] == 0) || (reqQty[t] == "") )
				{
					alert("<%=plzEntQty_A%>")
					obj1.focus()
					return false
				}else
				{
					if(reqQty[t] < 0)
					{
						alert("<%=qtyNotZero_A%>");
						obj1.focus()
						return false;
					}
					else if(isNaN( parseInt(reqQty[t]) ))
					{
						alert("<%=plzEntValiQty_A%>");
						obj1.focus()
						return false;
					}
				}
				

				a=reqdat[t].split("<%=fkey%>");
				b=(today).split("<%=fkey%>");

				d1=new Date(a[2],a[0]-1,a[1])
				d2=new Date(b[2],b[0]-1,b[1])
			
				if( d1 < d2)
				{
					alert("<%=reqDateGreatEqlToday_A%>");
					obj1.focus()
					return false;
				}
			}
		}
	}
		
totalQty =0;
for(i=0;i<10;i++)
{
	if( (reqQty[i] != 0) && (reqQty[i] != "") )
	{
		totalQty = parseFloat(totalQty) + parseFloat(reqQty[i]);
	
		if( (reqdat[i] !=0) && (reqdat[i] != "" ) )
		{
			
			for(j=0;j<10;j++)
			{
				if( (reqdat[j] != 0) && (reqdat[j] != "" ) )
				{
					if(i != j)
					{
						if(reqdat[i] == reqdat[j])
						{
						alert("<%=noTwoReqDateSame_A%>")
						return false;
						}
					}//end of if i != j
					
					
				}
			}//end of for
		}//end of if dat
	}//end of if qty
}//end of for

var schvalue="<%=totQty%>"
schvalue=parseFloat(schvalue)

	if(totalQty != schvalue)
	{
		alert("Please check Quantity.There is discrepancy in Quantity entered \n Solution :Enter Total Quantity: " +schvalue);
		document.f1.Qty[0].focus();
		return false;
	}
	

	if(parseFloat(totalQty) ==0)
	{
	   alert(" <%=qtyNotZero_A%>")
	   return false;
	}
	eval("opener.document.generalForm.changeFlag_<%=ind%>.value=true")
	document.forms[0].status.value="U"; 
	document.f1.submit()
}
function setWindowClose()
{

	if(parseFloat(<%=totReqQty%>) != parseFloat(<%=totQty%>))
	{
		
		retVal=eval("opener.document.generalForm")
		if(isNaN(retVal.desiredQty.length))
		{
			retVal.desiredQty.value ="<%=totReqQty%>"
		}else{
			retVal.desiredQty[<%=ind%>].value ="<%=totReqQty%>"
		}
		
	}
	eval("opener.document.generalForm.changeFlag_<%=ind%>.value=true")
	window.close()	
}
</script>

</head>
<body>
<form name="f1" action="ezSaveEditDatesEntry.jsp?itemNo=<%=itemNumber%>&ind=<%= ind%>" method="post">
<input type="hidden" name="status">
<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
<Tr>
<Th align="center">
<%=plzEnterQtyReqDatesForMat_L%>&nbsp;&nbsp;<%= matdesc %>[Unit Qty:<%=unitQty%>]
</Th></Tr></table>
<table width="50%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
<tr>
	<th nowrap><%=reqQty_L%></th>
	<th nowrap><%=reqDate_L %></th>
</tr>
<%
	int rows=1;
	for(int i=0;i<10;i++)
	{
%>	
		<tr>
		<td nowrap><input type="Text" class=InputBox size="15" maxlength="7" STYLE="text-align:right" onBlur='verifyField(this,"<%=i%>")' tabIndex ="<%=rows%>" name="Qty"  value="<%=reqQty[i]%>"></td>
		<td nowrap>
		<%--<input type="text" class=InputBox name="dat" size="11" readonly onFocus="blur()"  value="<%=reqDate[i]%>"><img src="../../Images/Buttons/<%= ButtonDir%>/calender.gif" style="cursor:hand" onClick='showCal("document.f1.dat[<%=i%>]",20,150,"<%= cDate%>","<%= cMonth%>","<%= cYear%>")'  height="20" border="none" valign="center" >--%>
		<input type=text name="dat<%=i%>" class=InputBox value="<%=reqDate[i]%>"  size=12 maxlength="10" readonly><%=getDateImage("dat"+i)%>
		</td>
		</tr>
<%	rows++;}
%>

</table>
<Table align="center">
<tr>
<td align="center" colspan="2" class="blankcell">
<%
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();
	buttonName.add("Ok");
	buttonMethod.add("setReqDateValue()");
	buttonName.add("Cancel");
	buttonMethod.add("setWindowClose()");
	out.println(getButtonStr(buttonName,buttonMethod));
%>
</td></tr>
</Table>
</form>
<Div id="MenuSol"></Div>
</body>
</html>
