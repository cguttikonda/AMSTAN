<%@ include file="../../../Includes/Lib/BusinessPartner.jsp"%>
<%@ include file="../../../Includes/Lib/BussPartnerBean.jsp"%>
<%@ page import="java.util.*" %>
<%
// Get the input parameters
String BusPartner = null;
String websyskey=null;
String Area=null;

BusPartner = request.getParameter("BusinessPartner");
websyskey = request.getParameter("WebSysKey");
Area = request.getParameter("Area");
String checkBox[]=request.getParameterValues("CheckBox");
String AuthKeys[]=request.getParameterValues("AuthKey");


Hashtable oldAuth=new Hashtable();

if(AuthKeys!=null)
{
	for(int i=0;i<AuthKeys.length;i++)
	{
		StringTokenizer tokens=new StringTokenizer(AuthKeys[i],"#");
		oldAuth.put(tokens.nextToken(),tokens.nextToken());
	}
}


if(checkBox!=null)
{
	for ( int i=0; i < checkBox.length; i++ )
	{
		StringTokenizer st=new StringTokenizer(checkBox[i],"#");
		String pAuthKey =st.nextToken();

		if(oldAuth.containsKey(pAuthKey.trim()))
		{
			oldAuth.remove(pAuthKey);
			continue;
		}
		String pAuthDesc=st.nextToken();
		EzKeyValueStructure in = new EzKeyValueStructure();
		in.setPKey(BusPartner.trim());
		in.setKey(pAuthKey.trim());
		in.setValue(pAuthDesc.trim());
		EzcBussPartnerParams bparams = new EzcBussPartnerParams();
		EzcBussPartnerNKParams bnkparams = new EzcBussPartnerNKParams();
		bnkparams.setLanguage("EN");
		bnkparams.setEzKeyValueStructure(in);
		bparams.setObject(bnkparams);
		Session.prepareParams(bparams);
		BPManager.setBussPartnerMasterAuth(bparams);
	  }
}


Enumeration enum1=oldAuth.keys();

while(enum1.hasMoreElements())
{

	String myKey=(String)enum1.nextElement();
	String myDesc=(String)oldAuth.get(myKey);
	
	EzKeyValueStructure in = new EzKeyValueStructure();
	in.setPKey(BusPartner.trim());
	in.setKey(myKey.trim());
	in.setValue(myDesc.trim());
	EzcBussPartnerParams bparams = new EzcBussPartnerParams();
	EzcBussPartnerNKParams bnkparams = new EzcBussPartnerNKParams();
	bnkparams.setLanguage("EN");
	bnkparams.setEzKeyValueStructure(in);
	bparams.setObject(bnkparams);
	Session.prepareParams(bparams);
	BPManager.setBussPartnerMasterAuth(bparams);
}	


response.sendRedirect("ezBPEzcAuthListBySysKey.jsp?saved=Y&BusinessPartner=" + BusPartner +"&Area="+Area +"&WebSysKey="+websyskey);

%>