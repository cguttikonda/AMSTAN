<%@ include file="../../Library/Globals/ezCacheControl.jsp"%>
<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ page import = "ezc.ezutil.FormatDate,java.util.*" %>

<%@ include file="../../../Includes/JSPs/Lables/iAddDatesEntry_Lables.jsp" %>
<%
 String ind = request.getParameter("ind");
 String status = request.getParameter("status");
 String unitQty = request.getParameter("unitQty");
%>

<html>
<head>
<title>Required Quantites and Dates </title>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iShowCal.jsp"%>

<script src="../../Library/JavaScript/Misc/ezTrim.js">
</script>
<script>
var docPath=""

if (document.all)
	docPath=eval("parent.opener.document")
else
	docPath=opener.document


function chkQty(theField,ind)
{
	var fValue=theField.value
	val="<%=unitQty%>"
	
	if((val!="")&&(!isNaN(val)))
	{
		if((fValue%val)!=0)
		{
			alert("Shipper quantity of "+ document.f1.matdesc.value +" is  : " + val  +"\nSolution :Please enter multiple of "+ val)
			theField.focus();
			return false;
		}
		
	}
	return true;

}
function verifyField(theField,ind)
{
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
<%
	String  fkey=(String)session.getValue("formatKey");
	if(fkey==null)
	fkey="/";
%>
var today ="<%= FormatDate.getStringFromDate(new Date(),fkey,FormatDate.MMDDYYYY) %>"

function setReqDateValue()
{
	var reqdat = new Array();
	var reqQty = new Array();
	
	for(t=0;t<10;t++)
	{
	   	obj = eval("document.f1.dat"+t)
		obj1 = eval("document.f1.Qty["+t+"]")
		
		reqdat[t]= funTrim(obj.value)
		reqQty[t] = funTrim(obj1.value)
	
		reqdat[t]=( (reqdat [t] == null) || (reqdat[t]=="") || (reqdat[t] == "undefined") || (reqdat[t] == null) )?0:reqdat[t];
		reqQty[t]=( (reqQty[t] == null) || (reqQty[t] =="") || (reqQty[t] == "undefined") || (reqQty[t] == null) )?0:reqQty[t];


		if( ( reqQty[t] != 0  ) || (reqdat[t] != 0)  )
		{
			if( (reqQty[t] != 0) )	
			{
				if( reqdat[t] == 0)
				{
					alert("<%=plzEntReqDate_A%>")
					obj1.focus()
					return false
				}
				
			}
			if(reqdat[t] != 0)
			{
				if(reqQty[t] == 0)
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
		
		if(t==0)
		{
			full = reqdat[0]
			fullQty=reqQty[0]
		}
		else
		{
			full=full+"@@"+reqdat[t]
			fullQty=fullQty+"@@"+reqQty[t]
		}
	}
		fullOrderQty = parseFloat(reqQty[0] )+parseFloat(reqQty[1] ) + parseFloat(reqQty[2] ) + parseFloat(reqQty[3]) + parseFloat(reqQty[4]) + parseFloat(reqQty[5]) + parseFloat(reqQty[6])+ parseFloat(reqQty[7])+ parseFloat(reqQty[8]) + parseFloat(reqQty[9]) 


for(i=0;i<10;i++)
{
	if( reqQty[i] != 0)
	{  
		if( reqdat[i] !=0 )
		{
			
			for(j=0;j<10;j++)
			{  
				if( reqdat[j] != 0 )
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


	x=docPath.generalForm.del_sch_qty.length
	if(x>1)
	{
		schqtyobj = docPath.generalForm.del_sch_qty[<%= ind%>].value
	}else{
		schqtyobj = docPath.generalForm.del_sch_qty.value
	}
	schqty = schqtyobj.split('@@');
	schvalue =0
	tot =0;
	for(k=0;k<10;k++)
	{
		temp = eval("document.f1.Qty["+k+"]");
		tempvalue = funTrim(temp.value)
		if(tempvalue =="")
			tempvalue = 0

		tot = parseFloat(tot)+parseFloat(tempvalue)
	}
	for(c=0;c<schqty.length;c++)
	{
		if(funTrim(schqty[c]) == "")
			schqty[c]=0
		schvalue=schvalue+parseFloat(schqty[c])
	}
	if(tot != schvalue)
	{
		alert("<%=checkQtyForAnyDiscrepancy_A%>");
		return false;
	}

	Tcount = docPath.generalForm.total.value

	// this is to set date for del schedule
	if(x>1)
	{
		sddate= docPath.generalForm.del_sch_date[<%= ind%>]
	}else{
		sddate= docPath.generalForm.del_sch_date
	}
        sddate.value=full

	if(<%= ind%> == parseInt(0) )
	{
		for(a=1;a<Tcount;a++)
		{
			objdat = eval("docPath.generalForm.del_sch_date["+a+"]")
			if( (objdat.value != "") ||(objdat.value != null) )
			{
				fulldat = objdat.value.split('@@');
				if( (fulldat[0] == null) || (fulldat[0] == "") || (fulldat[0] == "undefined") || (fulldat[0] == "0") )
				{
					objdat.value = reqdat[0]
					reqall = eval("docPath.generalForm.desiredDate["+a+"]");
					reqall.value=reqdat[0]
					docPath.getElementById("DD_"+a).innerHTML=reqdat[0]

				}

			}
		}

		if(docPath.getElementById("selectG") != null)
			docPath.getElementById("selectG").style.display="None";
		if(reqdat[1] != 0)
			docPath.getElementById("DD_0").innerHTML="Multiple"
		else
			docPath.getElementById("DD_0").innerHTML=reqdat[0]

	}else
	{	if(reqdat[1] != 0)
		docPath.getElementById("DD_<%= ind %>").innerHTML="Multiple"
		else
		docPath.getElementById("DD_<%= ind %>").innerHTML=reqdat[0]
	}
	// this is to set value to req date
	if(x>1)
	{
		reqdate = docPath.generalForm.desiredDate[<%= ind%>]
	}else{
		reqdate = docPath.generalForm.desiredDate
	}
		reqdate.value=reqdat[0]

	//This is to set quantity to ddel schedule
	if(x>1)
	{
		sdqty = docPath.generalForm.del_sch_qty[<%= ind%>]
	}else{
		sdqty = docPath.generalForm.del_sch_qty
	}
		sdqty.value=fullQty

	// this is to set value to commited Qty because desired qty has two values like value+bonus
	if(x>1)
	{
		desqty=docPath.generalForm.commitedQty[<%= ind%>]
	}else{
		desqty=docPath.generalForm.commitedQty
	}
		desqty.value=fullOrderQty

	if(x>1)
	{
		docPath.getElementById("DesiredDate[<%=ind%>]").className=""
	}else{
		docPath.getElementById("DesiredDate").className=""
	}
	window.close()
}

function calValue(obj,ind1)
{

	y=chkQty(obj,ind1)
	if(eval(y))
	{
		// this part to get actual quantity
		x=docPath.generalForm.del_sch_qty.length
		if(x>0)
		{
			schqtyarr = docPath.generalForm.del_sch_qty[<%= ind%>].value
		}else{
			schqtyarr = docPath.generalForm.del_sch_qty.value
		}
		schqty = schqtyarr.split('@@');
		schvalue=0
		for(c=0;c<schqty.length;c++)
		{
			if(funTrim(schqty[c]) =="")
				schqty[c] =0
			schvalue=parseFloat(schvalue) +parseFloat(schqty[c])
		}
		// end to get totalValue

		Qty = funTrim(obj.value)
		ind2=ind1+1
		if( (Qty != 0) && (Qty !="") )
		{
			tot=0;
			for(k=0;k<ind2;k++)
			{
				temp = eval("document.f1.Qty["+k+"]");
				tempvalue = funTrim(temp.value)

				if(tempvalue =="")
					tempvalue = 0
				tot = parseFloat(tot)+parseFloat(tempvalue)

			}
			diff = parseFloat(schvalue) - parseFloat(tot);

			if(diff<0)
			{
				diff=0
				alert("<%=checkForExcessQty_A%>")
				obj.value=0
				tot=0
				for(k=0;k<ind2;k++)
				{
					temp = eval("document.f1.Qty["+k+"]");
					tempvalue = funTrim(temp.value)
					if(tempvalue =="")
						tempvalue = 0

					tot = parseFloat(tot)+parseFloat(tempvalue)
				}

				diff = parseFloat(schvalue) - parseFloat(tot);
				ind2 = ind2 - 1
				obj.value=diff

			}

			obj1 = eval("document.f1.Qty["+ind2+"]");
			if(obj1 != null)
			{
				if(isNaN( parseInt(diff)))
					obj1.value = 0
				else
					obj1.value = diff
			}

			for(k=ind2+1; k<10;k++)
			{

				obj2 = eval("document.f1.Qty["+k+"]");
				obj3 = eval("document.f1.dat"+k);
				obj2.value=0
				obj3.value=""
			}
		}else
		{
				tot=0
				for(k=0;k<10;k++)
				{
					temp = eval("document.f1.Qty["+k+"]");
					tempvalue = funTrim(temp.value)
					if(tempvalue =="")
						tempvalue = 0

					tot = parseFloat(tot)+parseFloat(tempvalue)
				}
				diffreal = parseFloat(schvalue) - parseFloat(tot);
				obj.value=diffreal
		}
		oldValue=obj1.value;
		
	}else{
		obj.value=oldValue;
		
	}
}
var oldValue=0;
function getReqDateValue()
{
	x = docPath.generalForm.prodDesc.length
	if(x>1)
	{
        	document.f1.matdesc.value  = docPath.generalForm.prodDesc[<%= ind%>].value	
        	schdate = docPath.generalForm.del_sch_date[<%= ind%>]
		schqty = docPath.generalForm.del_sch_qty[<%= ind%>]
	}else{
		document.f1.matdesc.value  = docPath.generalForm.prodDesc.value	
		schdate = docPath.generalForm.del_sch_date
		schqty = docPath.generalForm.del_sch_qty
	}
	full=schdate.value

//alert("schdate.value"+schdate.value)
	fullQty=schqty.value
	oldValue=fullQty;
//alert("schqty.value"+schqty.value)

if( (full != "") ||(full != null) )
{
	one=full.split('@@');
	
	for(t=0;t<10;t++)
	{
               
	   	obj = eval("document.f1.dat"+t)
		
		if( (one[t] != null) && (one[t] != "") && (one[t] != "undefined") && (one[t] != "0") )
			obj.value =  one[t]
		else
			obj.value =  ""			
	}
	
}
if( (fullQty != "") || (fullQty != null) )
{
	
	oneQty=fullQty.split('@@');

	for(t=0;t<10;t++)
	{
		obj = eval("document.f1.Qty["+t+"]")
		if( (oneQty[t] != null) && (oneQty[t] != "") && (oneQty[t] != "undefined"))
		{
			obj.value =  oneQty[t]
		}else
		{
			obj.value =  "0"
		}
	}

}

}

function removeDat(obj,ind)
{
	req =funTrim(obj.value)
	if(req=="" || req==0)
	{
		a=eval("document.f1.dat"+ind)
		a.value="";
	}
}
</script>
</head>

<body onLoad="getReqDateValue()" scroll="auto">
<form name="f1">
<table  align=center cellPadding=2 cellSpacing=0 >
 <tr>
    <td align="center">
	<%=plzEnterQtyReqDatesForMat_L%> <input type="text" name="matdesc" STYLE="text-align:center" readonly size="41" class="tx">
    </td>
</tr>
</table>


<table  width="50%" align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
<tr>
	<th><%=reqQty_L%></th>
	<th><%=reqDate_L%></th>
</tr>
<%
	int rows=1;
	for(int z=0;z<10;z++)
	{
%>
		<tr>
		<td nowrap><input type="Text" class=InputBox size="10" maxlength="15" STYLE="text-align:right" onBlur='verifyField(this,"<%=z%>")' tabIndex ="<%=rows%>" name="Qty" ></td>
		<td nowrap>
			<input type=text name="dat<%=z%>" class=InputBox value=""  size=12 maxlength="10" readonly><%=getDateImage("dat"+z)%>
		</td>
        </tr>
 <%  rows++;
    }
 %>

</table>

<Table align="center">
<tr>
<td align="center" colspan="2" class="blankcell">
<%
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();
	buttonName.add("OK");
	buttonMethod.add("setReqDateValue()");
	buttonName.add("Cancel");
	buttonMethod.add("window.close()");	
	out.println(getButtonStr(buttonName,buttonMethod));
%>
</td>
</tr>
</Table>
</form>
<Div id="MenuSol"></Div>
</body>
</html>
