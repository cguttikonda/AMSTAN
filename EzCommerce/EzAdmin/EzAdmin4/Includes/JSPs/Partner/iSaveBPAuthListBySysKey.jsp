<%@ include file="../../../Includes/Lib/BusinessPartner.jsp"%>
<%@ include file="../../../Includes/Lib/BussPartnerBean.jsp"%>
<%@ page import="java.util.*" %>
<%
// Get the input parameters
String BusPartner = null;
String SysNum = null;

String pAuthCount  = null;

String Check = null;
String pCheck = null;
String Stat = null;
String pStat = null;
String pAuthKey = null;
String pAuthDesc = null;
String websyskey=null;
String Area=null;

Hashtable oldAuth=new Hashtable();


	BusPartner = request.getParameter("BusinessPartner");
	websyskey = request.getParameter("WebSysKey");
	Area = request.getParameter("Area");
	String pSysNum[] = request.getParameterValues("SysNum");
	if(pSysNum!=null)
	{
		
		for ( int i = 0  ; i < pSysNum.length; i++ )
		{
			Hashtable myTable=new Hashtable();
			String AuthKey[]=request.getParameterValues("AuthKey"+pSysNum[i]);
			if(AuthKey!=null)
			{	
				for ( int j = 0  ; j < AuthKey.length; j++ )
				{
					StringTokenizer tokens=new StringTokenizer(AuthKey[j],"#");
					myTable.put(tokens.nextToken(),tokens.nextToken());
				}
			
			}
			oldAuth.put(pSysNum[i],myTable);
		 }
	
		
		for ( int j = 0  ; j < pSysNum.length; j++ )
		{
			
			

			String checkBox[]=request.getParameterValues("chk"+pSysNum[j]);

			if(checkBox!=null)
			{
				for ( int i = 0  ; i < checkBox.length; i++ )
				{
					Hashtable myTable=(Hashtable)oldAuth.get(pSysNum[j]);
					// Transfer Structure for the Descriptions
					EzKeyValueStructure in = new EzKeyValueStructure();
					StringTokenizer st=new StringTokenizer(checkBox[i],"#");
					String AuthKey=st.nextToken();
					
					if(myTable.containsKey(AuthKey))
					{
							myTable.remove(AuthKey);
							continue;
					}
				
						
					String AuthDesc=st.nextToken();
					// Set the Structure Values
					in.setPKey(BusPartner.trim());
					in.setKey(AuthKey.trim());
					in.setValue(AuthDesc.trim());
                    			EzcBussPartnerParams bparams = new EzcBussPartnerParams();
					EzcBussPartnerNKParams bnkparams = new EzcBussPartnerNKParams();
					bnkparams.setLanguage("EN");
					bnkparams.setSys_no(pSysNum[j]);
                    			bnkparams.setEzKeyValueStructure(in);
					bparams.setObject(bnkparams);
					Session.prepareParams(bparams);
					// Add Business Partner Authorizations
					BPManager.setBussPartnerAuth(bparams);

				}

			}
	}
 }


Enumeration enum1=oldAuth.keys();
while(enum1.hasMoreElements())
{
	String sysNum=(String)enum1.nextElement();
	Hashtable myTable=(Hashtable)oldAuth.get(sysNum);
	
	Enumeration enum11= myTable.keys();
	
	while(enum11.hasMoreElements())
	{
	
		String AuthKey1=(String)enum11.nextElement();
		
		EzKeyValueStructure in = new EzKeyValueStructure();
		in.setPKey(BusPartner.trim());
		in.setKey(AuthKey1.trim());
		in.setValue((String)myTable.get(AuthKey1));
		EzcBussPartnerParams bparams = new EzcBussPartnerParams();
		EzcBussPartnerNKParams bnkparams = new EzcBussPartnerNKParams();
		bnkparams.setLanguage("EN");
		bnkparams.setSys_no(sysNum);
		bnkparams.setEzKeyValueStructure(in);
		bparams.setObject(bnkparams);
		Session.prepareParams(bparams);
		// Add Business Partner Authorizations
		BPManager.setBussPartnerAuth(bparams);
	}
		
}
response.sendRedirect("ezBPAuthListBySysKey.jsp?saved=Y&BusinessPartner=" + BusPartner+"&Area="+Area+"&WebSysKey="+websyskey);
%>