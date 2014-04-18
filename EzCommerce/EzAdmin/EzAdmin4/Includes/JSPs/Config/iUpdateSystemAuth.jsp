<%@ page import = "ezc.ezparam.EzKeyValueStructure" %>
<%@ page import = "java.util.*" %>
<%@ include file="../../../Includes/Lib/AdminConfig.jsp"%>
<jsp:useBean id="sysManager" class="ezc.client.EzSystemConfigManager" scope="session"/>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"/>


<%
String pAuthKey=null;
String pAuthDesc=null;
String SystemNumber =  request.getParameter("SystemNumber");
String Check[]=request.getParameterValues("Check");
String Stat[]=request.getParameterValues("Stat");
String AuthKey[]=request.getParameterValues("AuthKey");
String AuthDesc[]=request.getParameterValues("AuthDesc");
Hashtable oldAuth=new Hashtable();
if(Stat!=null)
{
	for(int i=0;i<Stat.length;i++)
	{
		StringTokenizer tokens=new StringTokenizer(Stat[i],"#");
		oldAuth.put(tokens.nextToken(),tokens.nextToken());
	}
}

if(Check!=null)
{
	for ( int i = 0 ; i < Check.length; i++ )
	{
		StringTokenizer st=new StringTokenizer(Check[i],"#");
		pAuthKey=st.nextToken();
		pAuthDesc=st.nextToken();

		if(oldAuth.containsKey(pAuthKey))
		{
			oldAuth.remove(pAuthKey);
			continue;
		}
		
		EzKeyValueStructure in = new EzKeyValueStructure();
		in.setPKey(SystemNumber.trim());
		in.setKey(pAuthKey.trim());
		in.setValue(pAuthDesc.trim());
		EzcSysConfigParams sparams = new EzcSysConfigParams();
		EzcSysConfigNKParams snkparams = new EzcSysConfigNKParams();
		snkparams.setLanguage("EN");
		snkparams.setEzKeyValueStructure(in);
		sparams.setObject(snkparams);
		Session.prepareParams(sparams);
		sysManager.setSystemAuth(sparams);
	}
}

Enumeration enum=oldAuth.keys();
while(enum.hasMoreElements())
{
	String oldAuthKey = (String)enum.nextElement();
	if(AuthKey!=null)
	{
		for(int j=0;j<AuthKey.length;j++)
		{
			if((AuthKey[j].trim()).equals(oldAuthKey.trim()))
			{
				EzKeyValueStructure in = new EzKeyValueStructure();
				in.setPKey(SystemNumber.trim());
				in.setKey(AuthKey[j].trim());
				in.setValue(AuthDesc[j].trim());
				EzcSysConfigParams sparams = new EzcSysConfigParams();
				EzcSysConfigNKParams snkparams = new EzcSysConfigNKParams();
				snkparams.setLanguage("EN");
				snkparams.setEzKeyValueStructure(in);
				sparams.setObject(snkparams);
				Session.prepareParams(sparams);
				sysManager.setSystemAuth(sparams);
			}
		}
	}
}
/*if(AuthKey!=null)
{
	for(int j=0;j<AuthKey.length;j++)
	{
		if(Stat!=null)
		{
			for(int k=0;k<Stat.length;k++)
			{

				StringTokenizer st=new StringTokenizer(Stat[k],"#");
				pAuthKey=st.nextToken();
				pAuthDesc=st.nextToken();
				if((AuthKey[j].trim()).equals(pAuthKey))
				{
					EzKeyValueStructure in = new EzKeyValueStructure();
					in.setPKey(SystemNumber.trim());
					in.setKey(pAuthKey.trim());
					in.setValue(pAuthDesc.trim());
					EzcSysConfigParams sparams = new EzcSysConfigParams();
					EzcSysConfigNKParams snkparams = new EzcSysConfigNKParams();
					snkparams.setLanguage("EN");
					snkparams.setEzKeyValueStructure(in);
					sparams.setObject(snkparams);
					Session.prepareParams(sparams);
					sysManager.setSystemAuth(sparams);
				}
			}
		}
	}
}*/

// Added by Srinivas To Add WorkFlow Defaults


ezc.client.CEzBussPartnerManager cbpm= new ezc.client.CEzBussPartnerManager();
EzcSysConfigParams sparams = new EzcSysConfigParams();
EzcSysConfigNKParams snkparams = new EzcSysConfigNKParams();
snkparams.setSystemNumber(SystemNumber.trim());
sparams.setObject(snkparams);
Session.prepareParams(sparams);

cbpm.updateWFDefaults(sparams);
response.sendRedirect("../Config/ezListSystemAuth.jsp?saved=Y&sysnum=" + SystemNumber);
%>