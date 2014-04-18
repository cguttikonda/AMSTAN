<%@ page import="ezc.ezwebstats.params.*,ezc.ezparam.*,java.util.*" %>
<jsp:useBean id="WebStatsManager" class="ezc.ezwebstats.client.EzWebStatsManager" />
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<jsp:useBean id="EzGlobal" class="ezc.ezbasicutil.EzGlobal" scope="session" />
<%
	EzGlobal.setDateFormat("MM/dd/yyyy HH:mm:ss");
	HashMap myMap= new HashMap();
	myMap.put("SALES","'21','22','23','24'");
	myMap.put("STOCK","25");
	myMap.put("PROJECTIONS","26");
	myMap.put("SELF","27");
	myMap.put("CATALOG","31");
	myMap.put("DISPATCH","29");
	myMap.put("CUSTOMER","28");
	myMap.put("ALL","21,22,23,24,25,26,27,28,29,31");
	HashMap myDesc= new HashMap();
	myDesc.put("SALES","Sales Order");
	myDesc.put("STOCK","Secondary Sales");
	myDesc.put("PROJECTIONS","Projections");
	myDesc.put("SELF","Self Service");
	myDesc.put("CATALOG","Catalog");
	myDesc.put("DISPATCH","Dispatch");
	myDesc.put("CUSTOMER","Customer Details");
	myDesc.put("ALL","All");
	String cat=request.getParameter("cat");
	String fromDate =request.getParameter("fromDate");
	String toDate =request.getParameter("toDate");
	cat=cat.toUpperCase();
	ReturnObjFromRetrieve ret=null;
	ReturnObjFromRetrieve retGlobal=null;
	int len=0;

	String userTypes[]=request.getParameterValues("chk1");
	if(fromDate != null && toDate != null)
	{
		EzcParams mainParams = new EzcParams(false);
		EziEyeBallParams params = new EziEyeBallParams();
		params.setGroup((String)myMap.get(cat));
		params.setGroupBy(new String[]{"USERID","DATE"});

		if(userTypes!=null && !"A".equals(userTypes[0]))
			params.setValue3(userTypes[0]);

		int ffy=Integer.parseInt(fromDate.substring(6,10))-1900;
		int ffm=Integer.parseInt(fromDate.substring(3,5))-1;
		int ffd=Integer.parseInt(fromDate.substring(0,2));
		int tty=Integer.parseInt(toDate.substring(6,10))-1900;
		int ttm=Integer.parseInt(toDate.substring(3,5))-1;
		int ttd=Integer.parseInt(toDate.substring(0,2));
		Date tempFrom = new Date(ffy,ffm,ffd);
		Date tempTo = new Date(tty,ttm,ttd);

		java.text.SimpleDateFormat sdf =new java.text.SimpleDateFormat("MM/dd/yyyy");
		params.setDate(sdf.format(tempFrom));
		params.setDate1(sdf.format(tempTo));
		mainParams.setObject(params);
		Session.prepareParams(mainParams);
		ret=(ReturnObjFromRetrieve)WebStatsManager.ezViewEyeBallTrackInfo(mainParams);
		len=ret.getRowCount();
		String sort [] =new String[]{"EZCOUNT" };
		if(ret!=null)
		{
			if(len > 0)
				ret.sort(sort,false);
			Vector types = new Vector();
			types.addElement("date");
			EzGlobal.setColTypes(types);

			Vector names = new Vector();
			names.addElement("EZDATE");
			EzGlobal.setColNames(names);
			retGlobal = EzGlobal.getGlobal(ret);
		}
	}
%>
<html>
<head>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iShowCal.jsp"%>
<script src="../../Library/JavaScript/ezTabScroll.js"></Script>
<script>
function printSubmit(obj1)
{
	document.EyeBall.action=obj1;
	document.EyeBall.submit();
}
function funSubmit()
{
	obj =document.EyeBall
	fd =obj.fromDate.value;
	td=obj.toDate.value;
	y=true
	if(fd=="")
	{
		alert("Please Enter From Date");
		y=false
	}
	if(y)
	{
		if(td=="")
		{
			alert("Please Enter to Date");
			y=false
		}
	}
	if(y)
	{
		a=fd.split(".");
		b=td.split(".");
		fd1=new Date(a[2],a[1]-1,a[0])
		td1=new Date(b[2],b[1]-1,b[0])
		if(fd1 > td1)
		{
			alert("From Date Cannot be less than To Date");
			y=false
		}
	}
	if(y)
	{
		obj.action="ezViewEyeBallInfoByCategory.jsp";
		obj.submit();
	}
}
</script>
</Head>
<Body onLoad="scrollInit();" onresize='scrollInit()' >
<Form name="EyeBall" action="ezViewEyeBallInfoByCategory.jsp">
<input type="hidden" name="cat" value="<%=cat%>">
<br>
<Table align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 width = "60%">
	<Tr>
		<Td align = "center" class="displayheader"  width="60%">EzEyeBall Track Information for <%=myDesc.get(cat)%></td>
	</Tr>
</Table>
<%
boolean datesFlag=true;
if(fromDate == null && toDate == null)
{
		datesFlag=false;
		String DateStr="";
		String Monthstr ="";
		if(cDate < 10)
			DateStr = "0"+cDate;
		else
			DateStr = ""+cDate;
		if((cMonth+1)<10)
			Monthstr="0"+(cMonth+1);
		else
			Monthstr=""+(cMonth+1);
		fromDate =DateStr+"."+Monthstr+"."+cYear;
		toDate = DateStr+"."+Monthstr+"."+cYear;
}
%>
<Table align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 width = "60%">
	<Tr>
		<Th>From</Th>
		<Td><input type="text" class=inputBox size="12" name="fromDate" readonly value="<%=fromDate%>"><a href='javascript:showCal("document.EyeBall.fromDate",50,275,"<%= cDate%>","<%= cMonth%>","<%= cYear%>")'><img src="../../Library/JavaScript/calender.gif"  title="click here to enter From Date" border="none"></a></Td>
		<Th>To</Th>
		<Td><input type="text" class=inputBox size="12" name="toDate" readonly  value="<%=toDate%>"><a href='javascript:showCal("document.EyeBall.toDate",50,400,"<%= cDate%>","<%= cMonth%>","<%= cYear%>")'><img src="../../Library/JavaScript/calender.gif" title="Click Here to enter to date" border="none"></a> </Td>
	</Tr>
	<Tr>
		<Td><input type=radio name=chk1 value='I'>Internal Users</Td>
		<Td><input type=radio name=chk1 value='B'>Business Users</Td>
		<Td><input type=radio name=chk1 value='A' checked>All Users</Td>
		<Td class="blankcell" align = "center"><a href="JavaScript:funSubmit()"><img src="../../Images/Buttons/<%= ButtonDir%>/show.gif" border=none></a></td>
	</Tr>
</Table>
<%
if(datesFlag)
{
	if(len == 0)
	{
%>
		<Br><Br><Br><Br>
		<Table width=80% border=1 align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
		<Tr>
			<Th>No Info found as per your selection.</Th>
		</Tr>
		</Table>
<%
	}
	else
	{
%>
		<Div id="theads" >
		<Table  id="tabHead" border=1 align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
		<Tr>
				<Th width="35%">Date</Th>
				<Th width="35%">UserId</Th>
				<Th width="30%">Count</Th>
		</Tr>
		</Table>
		</Div>
		<Div id="InnerBox1Div">
		<Table align="center" id="InnerBox1Tab" border=1 borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0>
<%		for(int i=0;i<len;i++)
		{
%>			<Tr>
				<Td width="35%" align=left><%=retGlobal.getFieldValue(i,"EZDATE")%></Td>
				<Td width="35%" align=left><%=ret.getFieldValueString(i,"EZUSER")%></Td>
				<Td width="30%" align=right><%=ret.getFieldValueString(i,"EZCOUNT")%></Td>
			</Tr>
<%		}
%>		</Table>
		</Div>
<%	}
}
else{
%>		<Br><Br><Br>
		<Table width=80% border=1 align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
		<Tr>
			<Th >Please select dates and click on show.</Th>
		</Tr>
		</Table>
<%}%>

<%

if(ret!=null)              
	session.putValue("WebStatReturnObject",ret);
else
	System.out.println("<<<<<<WebStats Return Object is null>>>>>>");


%>


	<Div id="ButtonDiv" align="center" style="position:absolute;top:90%;width:100%">

		<%
			if(ret != null)
			       {
					if (ret.getRowCount()>0)
					{
					%>
						<a href="Javascript:printSubmit('ezWebStatExSheet.jsp')"><img src="../../Images/Buttons/<%= ButtonDir%>/downloadinexcel.gif"   title="" alt="" border="none"></a>
					<%
					}
				}
		%>

		<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
	</Div>
</Body>
</Html>
