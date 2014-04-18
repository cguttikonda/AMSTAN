<%@ page language="java" errorPage="../Misc/ezErrorDisplay.jsp"%>
<%@ include file="../../../Includes/JSPs/NewUser/iGetSalesAreas.jsp"%>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<Html>
<Head>

<script src="../../Library/JavaScript/ezTabScroll.js"></script>
<script src="../../Library/JavaScript/ezTrim.js"></script>
<script>
/*function qucikAddUser()
{
	document.myForm.action="ezQuickAddUserSave.jsp"
	document.myForm.submit();
} 
function userExtend()
{
	document.myForm.action="ezExtendUser.jsp"
	document.myForm.submit();
}*/
function qucikAddUser()
{
	
	if(chk())
	{
		
		document.myForm.action="ezQuickAddUserSave.jsp"
		document.myForm.submit();
	}
	
}
 
var MValues = new Array();
MValues[0] =new EzMList("userId","User ID");
MValues[1] =new EzMList("userName","User Name");
MValues[2] =new EzMList("email","E Mail");
MValues[3] =new EzMList("catnum","Catalog");

function EzMList(fldname,flddesc)
{
	this.fldname=fldname;
	this.flddesc=flddesc;
}
function chk()
{
	for(c=0;c<MValues.length;c++)
	{
		if(funTrim(eval("document.myForm."+MValues[c].fldname+".value")) == "")
		{
			if(c=="3")
			{
				alert("Please Select"+MValues[c].flddesc);
				eval("document.myForm."+MValues[c].fldname+".focus()")
			}	
			else			
			{
				alert("Please enter"+MValues[c].flddesc);
				eval("document.myForm."+MValues[c].fldname+".focus()")
			}	
			return false;
		}
	}
	if(document.myForm.syskey !=null)
	{
		var chkbox = document.myForm.syskey.length;
		chkcount=0;
		if(isNaN(chkbox))
		{
			if(document.myForm.syskey.checked)
			{
				chkcount++;
			}
		}
		else
		{
			for(a=0;a<chkbox;a++)
			{
				if(document.myForm.syskey[a].checked)
				{
					chkcount++;
					break;
				}
			}
			if(chkcount == 0)
			{
				alert("Please check atleast one check box");
				return false;
			}
		}
	}
	return true;
}
	
	
	
	
function userExtend()
{
	document.myForm.action="ezExtendUser.jsp"
	document.myForm.submit();
} 
</script>
</Head>
<Body  onLoad="scrollInit();" onResize="scrollInit()" scroll="no" >
<Form name=myForm method=post">	
<%	if(salesArea==null || "null".equals(salesArea) || "".equals(salesArea))
	{
%>		<br><br><br><br>
		<Table width=75% align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
			<Tr>
				<Th>There is no Sales Area with given Defaults.Please contact System Administrator.</Th>			
			</Tr>
		</Table>
		<Div id="ButtonDiv" align="center" style="position:absolute;top:90%;width:100%">
			<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%=ButtonDir%>/back.gif" border=none></a>
		</Div>

<%	}
	else if(syncSucess)
	{
%>		<br><br><br><br>
		<Table width=50% align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
			<Tr>
				<Th>This Customer is already Synchronized in System.</Th>

			</Tr>
		</Table>
		<Div id="ButtonDiv" align="center" style="position:absolute;top:90%;width:100%">
			<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%=ButtonDir%>/back.gif" border=none></a>
		</Div>
<%	}
	else if(retUserCustCount==0)
	{
%>		<%--Quick Add User--%>
		<%@ include file="ezQuickAddUserAdd.jsp"%>
		<Div id="ButtonDiv" align="center" style="position:absolute;top:90%;width:100%">
		<Table>
		<Tr>
		<Td class=blankcell>
			<a href="javascript:qucikAddUser()"><img src="../../Images/Buttons/<%= ButtonDir%>/go.gif" border="none"></a>
		</Td>			
		<Td class=blankcell>
			<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%=ButtonDir%>/back.gif" border=none></a>
		</Td>
		</Tr>
		</Table>
		</Div>
<%	}
	else 
	{	
%>		<%--User Extend--%>
		<%@ include file="ezQuickAddUserExtend.jsp"%>
		<Div id="ButtonDiv" align="center" style="position:absolute;top:90%;width:100%">
		<Table>
		<Tr>
		<Td class=blankcell>
			<a href="javascript:userExtend()"><img src="../../Images/Buttons/<%= ButtonDir%>/go.gif" border="none"></a>
		</Td>			
		<Td class=blankcell>
			<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%=ButtonDir%>/back.gif" border=none></a>
		</Td>
		</Tr>
		</Table>		
		</Div>
<%	}
%>		
	
</Form>
</Body>
</Html>  