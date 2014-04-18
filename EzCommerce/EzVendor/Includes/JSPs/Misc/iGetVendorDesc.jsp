<%@ page import="java.util.*"%>
<%
	java.util.Hashtable venodorsHT = (java.util.Hashtable)session.getValue("VENDORHT");

    	/*
    	ezc.ezpreprocurement.client.EzPreProcurementManager preManager = new  ezc.ezpreprocurement.client.EzPreProcurementManager();	
       ezc.ezparam.EzcParams vendMainParams = new ezc.ezparam.EzcParams(false);
       ezc.ezworkflow.params.EziWFParams vendParams= new ezc.ezworkflow.params.EziWFParams();
       
       ArrayList dsrdSteps=new ArrayList();
       dsrdSteps.add("2");
       
       vendParams.setTemplate("100009");
       vendParams.setSyskey("999327");
       vendParams.setParticipant("MANAGER353");
       vendParams.setDesiredSteps(dsrdSteps);
       vendParams.setPartnerFunction("VN");
       vendMainParams.setObject(vendParams);

       String vendPurGrp = "353";
	     java.util.Hashtable venodorsHT = (java.util.Hashtable)preManager.getVendorsHash(Session,vendMainParams,vendPurGrp);
  
  
    	out.println(venodorsHT.size());  
    
	java.io.FileOutputStream fos = new java.io.FileOutputStream("D:\\t.txt");
	java.io.ObjectOutputStream oos = new java.io.ObjectOutputStream(fos);

	oos.writeObject(venodorsHT);

	oos.close();
	*/

    
%>