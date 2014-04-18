<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ page import ="ezc.ezparam.*"%>
<%@ page import="ezc.ezutil.csb.*" %>
<%@ page import="java.util.*" %>
<%@ include file="../../Library/Globals/ezCacheControl.jsp"%>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezWorkFlow.jsp"%>

<%
		String template=(String)session.getValue("Templet");

		//out.println("******template****"+template);
		String group=(String)session.getValue("UserGroup");
		String userRole = (String)session.getValue("UserRole");
		String catalog_area=(String)session.getValue("SalesAreaCode");

		Hashtable allUsers=new Hashtable();


		String participant="";
		ArrayList desiredStep=new ArrayList();
		desiredStep.add("-1");
		desiredStep.add("-2");
		desiredStep.add("-3");
		desiredStep.add("1");
		desiredStep.add("2");
		desiredStep.add("3");


		ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(false);
		ezc.ezworkflow.params.EziWFParams params= new ezc.ezworkflow.params.EziWFParams();
		params.setTemplate(template);
		params.setSyskey(catalog_area);
		params.setParticipant((String)session.getValue("Participant"));

		//for(int i=0;i<desiredStep.size();i++)
		//{
			//params.setDesiredStep((String)desiredStep.get(i));
			params.setDesiredSteps(desiredStep);

			mainParams.setObject(params);

			Session.prepareParams(mainParams);

			ezc.ezparam.ReturnObjFromRetrieve retsoldto=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlow.getWorkFlowUsers(mainParams);

			if(retsoldto!=null)
			{
				for(int j=0;j<retsoldto.getRowCount();j++)
				{			
					allUsers.put(retsoldto.getFieldValueString(j,"EU_ID"),retsoldto.getFieldValueString(j,"EU_FIRST_NAME")+"^"+retsoldto.getFieldValueString(j,"EU_LAST_NAME"));
				}
			}
		//}


%>


<script language="javascript">

function CheckSelect() {
	var selCount=0;

	for (var i = 0; i < document.myForm.elements.length; i++)
	{
		var e = document.myForm.elements[i];
		if (e.name == 'to' && e.checked)
		{
			selCount = selCount + 1;
		}
	}

	if(selCount<1){
		alert("Select User(s) Before Submitting");
		return false;
	}else{

		Update();
	}

}

</script>

<Title>List of Users</Title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
</head>

<body scroll="auto">

<form name=myForm method=post">


     <%
java.util.Enumeration enum1=allUsers.keys();
int userRows = allUsers.size();
String userName = null;
String firstName=null;
String secondName=null;
String All="";
if ( userRows > 0 )
{
%>
      <Table  width="90%" align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
          <Tr align="center" valign="middle">
            <Th width="19%">Select</Th>
            <Th width="81%">User </Th>
    </Tr>
<%
    while(enum1.hasMoreElements())
    {
    	userName=(String)enum1.nextElement();


	All = (String)allUsers.get(userName);



	firstName=All.substring(0,All.indexOf('^'));
	secondName =All.substring((All.indexOf('^')+1),All.length());

%>
     <Tr align="center">
        <Td width="19%">
	   <input type="checkbox" name= "to" value=<%=userName%> >
	</Td>
        <Td width="81%" align="left">
<%
	    out.println(firstName+" "+secondName);
%>
        </Td>
     </Tr>
<%

    }//End for
%>
      </Table>
  <input type="hidden" name="userStr" value="">
  <br>
  <div align="center">
<%
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();
	buttonName.add("Ok");
	buttonMethod.add("CheckSelect();return document.returnValue");
	buttonName.add("Close");
	buttonMethod.add("window.close()");
		
	out.println(getButtonStr(buttonName,buttonMethod));	
%>

  </div>
<%
 }//End if
 else
 {
 %><br><br><br>
     <Table  align=center border=0>
       <Tr align="center">
          <Td class=displayalert align=center>No Users To List</Td>
       </Tr>
     </Table>
       <br><br><center>
<%
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();
	buttonName.add("Close");
	buttonMethod.add("window.close()");
		
	out.println(getButtonStr(buttonName,buttonMethod));	
%>
       
     </center>
       
 <%
 }
%>


<script language="JavaScript">
<!--
function Update()
{
	var e2 = document.myForm.userStr.value;
	for (var i = 0; i < document.myForm.elements.length; i++)
	{
		var e = document.myForm.elements[i];
		if (e.name == 'to' && e.checked)
		{
			if (e2)
				e2 += ",";
			e2 += e.value;
		}
	}
	e2 += ",";
	window.opener.document.myForm.toUser.value = e2.substring(0,e2.length-1);
	window.close();

}
//-->
</script>
</form>
<Div id="MenuSol"></Div>
</body>
</html>
