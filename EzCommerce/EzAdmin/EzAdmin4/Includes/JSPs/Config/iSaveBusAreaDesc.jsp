<%@ page import = "ezc.ezparam.EzDescStructure" %>
<%@ include file="../../../Includes/Lib/AdminConfig.jsp"%>
<jsp:useBean id="esManager" class="ezc.client.EzSystemConfigManager" scope="session">
</jsp:useBean>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session">
</jsp:useBean>
<%

String areaFlag = request.getParameter("Area");

// Get the input parameters from the User Entry screen
String lang = request.getParameter("Lang");
String SystemNumber = request.getParameter("SystemNumber");
String Code = request.getParameter("Code");


String SyncFlag = null;
String SyncFlagY = request.getParameter("syncFlag");

if ( SyncFlagY.equals("Yes") ) 
{
	SyncFlag = "Y";
}
else
{
	SyncFlag = "N";
}


if ( SystemNumber != null )
{
     SystemNumber = SystemNumber.toUpperCase();
     SystemNumber = SystemNumber.trim();
}

if(Code!= null)
{
      Code = Code.toUpperCase();
	Code = Code.trim();
}

String key = SystemNumber + Code;
String desc = request.getParameter("Desc");

// Transfer Structure for the Descriptions
EzDescStructure in = new EzDescStructure();

// Set the Structer Values
in.setExtInfo(SystemNumber);
in.setKey(key);
in.setLang(lang);
in.setDesc(desc);
in.setAreaFlag(areaFlag);
in.setSysNum(SystemNumber); //Added by Venkat on 4/20/2001
in.setSyncFlag(SyncFlag);  //Added by Venkat on 4/20/2001

EzKeyValueStructure in1 = new EzKeyValueStructure();
in1.setKey("203");
in1.setValue(key);


EzcSysConfigParams sparams = new EzcSysConfigParams();
EzcSysConfigNKParams snkparams = new EzcSysConfigNKParams();
snkparams.setLanguage("EN");
snkparams.setEzDescStructure(in);
sparams.setObject(snkparams);
Session.prepareParams(sparams);

/******* Added by Venkat on 4/3/2001 ***********/
ReturnObjFromRetrieve retC = null;
int catAreas = 0;

if ( areaFlag.equals("V") )
{
	retC = (ReturnObjFromRetrieve) esManager.getPurchaseAreas(sparams);
	catAreas = retC.getRowCount();
}
else if ( areaFlag.equals("C") )
{
	retC = (ReturnObjFromRetrieve) esManager.getCatalogAreas(sparams);
	catAreas = retC.getRowCount();
}
else if ( areaFlag.equals("S") )
{
	retC = (ReturnObjFromRetrieve) esManager.getBusinessAreas(sparams);
	for(int i =0; i < retC.getRowCount(); i++)
	{
		String busArea = retC.getFieldValueString(i,"ESKD_SYS_KEY");
		busArea = busArea.trim();
		if ( busArea.equals(key) )
		{
			catAreas = 1;
			break;
		}
		else
		{
			catAreas = 0;
		}
	}
}

if ( catAreas > 0 )
{
	response.sendRedirect("../Config/ezAddBusAreaDesc.jsp?code="+Code+"&desc="+desc+"&sysno="+SystemNumber+"&syncflag="+SyncFlag+"&Area="+areaFlag);
	return;
}


if ( areaFlag.equals("C") )
{
	esManager.addCatalogArea(sparams);
}
else if ( areaFlag.equals("V") )
{
	esManager.addPurchaseArea(sparams);
}
else
{
	esManager.addBusinessArea(sparams); //To be changed to addArea when call is added to Manager,CSB & SSB
}


//Commented by Venkat on 6/4/2001 to redirect to the defaults page
//response.sendRedirect("../Config/ezListBusAreas.jsp?Area="+areaFlag);
response.sendRedirect("../Config/ezSetBusAreaDefaults.jsp?Area="+areaFlag+"&SystemKey="+key);
%>