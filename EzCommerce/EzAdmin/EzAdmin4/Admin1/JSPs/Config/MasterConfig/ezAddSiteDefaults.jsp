<%@ include file="../../../Includes/Lib/AdminConfig.jsp"%>

<html>
<head>

<script language = "javascript">
function CheckValue() {

	Key = document.forms[0].key.value;
	Desc = document.forms[0].Desc.value;

	if((Key == "")||(Desc == "")){
		alert("Please Enter Defaults Key and Description to Continue");
		document.returnValue = false;
	}else{
		//document.forms[0].submit();
		document.returnValue = true;
	}
}
</script>

<%!
// Start Declarations

final String SYSTEM_KEY = "ESKD_SYS_KEY";
final String SYSTEM_KEY_DESC_LANGUAGE = "ESKD_LANG";
final String SYSTEM_KEY_DESCRIPTION = "ESKD_SYS_KEY_DESC";

final String SYSTEM_NO = "ESD_SYS_NO";
final String SYSTEM_NO_DESC_LANGUAGE = "ESD_LANG";
final String SYSTEM_NO_DESCRIPTION = "ESD_SYS_DESC";

final String LANG_KEY = "ELK_LANG";       
final String LANG_ISO = "ELK_ISO_LANG";
final String LANG_DESC = "ELK_LANG_DESC";

final String DEFAULT_TYPE = "EDTD_DEFAULT_TYPE";
final String DEFAULT_TYPE_DESC = "EDTD_DESC";

final String SYSTEM_TYPE = "EST_SYS_TYPE";
final String SYSTEM_TYPE_LANG = "EST_LANG";
final String SYSTEM_TYPE_DESC = "EST_DESC";

//End Declarations
%>

<%
// Key Variables
ReturnObjFromRetrieve ret = null;
ReturnObjFromRetrieve retsystype = null;
ReturnObjFromRetrieve retdeftype = null;

// System Configuration Class
EzSystemConfig ezsc = new EzSystemConfig();

//Get All Languages
ret = ezc.getLangKeys();

//Get Defaults Type
retdeftype = ezc.getDefTypeDesc();
retdeftype.check();

//Get System Type
retsystype = ezc.getAllSysTypes();
retsystype.check();
%>


<Title>Add Site Defaults</Title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body bgcolor="#FFFFF7" link="#FFFFFF" vlink="#FFFFFF" alink="#FFFFFF">
<Table  width="40%" border="0" align="center">
  <Tr align="center" > 
    <Td>Add New Site Defaults</Td>
  </Tr>
</Table>
<form name=myForm method=post action="ezSaveSiteDefaultsDesc.jsp">

  <Table  width="85%" border="2" cellpadding="5" cellspacing="1" align="center" bordercolor="#610A61">
    <Tr bgcolor="#0066CC" bordercolor="#FFFFF7"> 
      <Td colspan="2" height="17"><For adding 
        a new site default enter the following information. To 
        add defaults from the ERP Table <a href="../../../../Config/MasterConfig/ezListStandardDefaults.jsp">Click 
        Here</a></Td>
    </Tr>
    <Tr bordercolor="#FFFFF7">
      <Td bgcolor="#D7D7D7" width="35%">System 
        Type :</Td>
      <Td width="65%"><%
int typeRows = retsystype.getRowCount();
	if ( typeRows > 0 ) {
        out.println("<select name=\"SysType\">"); 
		for ( int i = 0 ; i < typeRows ; i++ ){		
	        out.println("<option selected value="+(retsystype.getFieldValue(i,SYSTEM_TYPE))+">"); 
	        out.println(retsystype.getFieldValue(i,SYSTEM_TYPE_DESC)); 
	        out.println("</option>"); 
		}//End for
        out.println("</select>"); 
	}
%></Td>
    </Tr>
    <Tr > 
      <Td  width="35%">Default 
        Type:</Td>
      <Td width="65%"><%
typeRows = 0;
typeRows = retdeftype.getRowCount();
	if ( typeRows > 0 ) {
        out.println("<select name=\"DefType\">"); 
		for ( int i = 0 ; i < typeRows ; i++ ){		
	        out.println("<option selected value="+(retdeftype.getFieldValue(i,DEFAULT_TYPE))+">"); 
	        out.println(retdeftype.getFieldValue(i,DEFAULT_TYPE_DESC)); 
	        out.println("</option>"); 
		}//End for
        out.println("</select>"); 
	}
%></Td>
    </Tr>
    <Tr bordercolor="#FFFFF7"> 
      <Td  width="35%">Language:</Td>
      <Td width="65%"><%
int langRows = ret.getRowCount();
	if ( langRows > 0 ) {
        out.println("<select name=\"Lang\">"); 
		for ( int i = 0 ; i < langRows ; i++ ){		
		String val = (String)ret.getFieldValue(i,LANG_KEY);		
		if(val.equals("EN")){
	        out.println("<option selected value="+(ret.getFieldValue(i,LANG_KEY))+">"); 
	        out.println(ret.getFieldValue(i,LANG_DESC)); 
	        out.println("</option>"); 
		}else{
	        out.println("<option value="+(ret.getFieldValue(i,LANG_KEY))+">"); 
	        out.println(ret.getFieldValue(i,LANG_DESC)); 
	        out.println("</option>"); 
		}// End if
		}//End for
        out.println("</select>"); 
	}
%> </Td>
    </Tr>
    <Tr bordercolor="#FFFFF7"> 
      <Td bgcolor="#D7D7D7" width="35%">Defaults:</Td>
      <Td width="65%">  
        <input type=text class = "InputBox" name=key >
        </Td>
    </Tr>
    <Tr bordercolor="#FFFFF7"> 
      <Td bgcolor="#D7D7D7" width="35%">Description:</Td>
      <Td width="65%">  
        <input type=text class = "InputBox" name=Desc >
        </Td>
    </Tr>
    <Tr align="center" bgcolor="#FFFFF7" bordercolor="#FFFFF7"> 
      <Td colspan="2">
        <input type="submit" name="Submit" value="Add Defaults" onClick="CheckValue();return document.returnValue">
        </Td>
    </Tr>
  </Table>
</form>
</body>
</html>
