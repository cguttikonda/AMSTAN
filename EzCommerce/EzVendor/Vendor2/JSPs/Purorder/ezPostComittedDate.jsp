<%@ page import="java.util.*,ezc.ezpurchase.params.*" %>
<%@ page import = "ezc.ezutil.FormatDate,ezc.ezparam.*"%>
<jsp:useBean id="AppManager" class="ezc.ezvendorapp.client.EzVendorAppManager" scope="session"></jsp:useBean>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<%
	String po = request.getParameter("poNum");	
    
    	String[] lines = request.getParameterValues("line1");	
	String[] date = request.getParameterValues("date1");	
        String[] scheduleLines = request.getParameterValues("scheduleLine1");

	int Count = Integer.parseInt(request.getParameter("newcnt"));
        String cdate="";


	 //SAP call Params    
	EzBapiekkocStructure header= new EzBapiekkocStructure();
	header.setDocType("F");
	header.setPoNumber(po);

   	EzBapieketTable shTable= new EzBapieketTable();
	EzBapieketTableRow shTableRow= null ;
	int rCount=0;
	for(int i=0;i<Count;i++)
        {
       	        cdate = request.getParameter("newComittedDate_"+i);
	        Date fromDate = new Date();
		fromDate.setDate(Integer.parseInt(cdate.substring(0,2)));
		fromDate.setMonth(Integer.parseInt(cdate.substring(3,5))-1);
		fromDate.setYear(Integer.parseInt(cdate.substring(6,10))-1900);

		// For Sap Call
				
		shTableRow= new EzBapieketTableRow();
		shTableRow.setDelivDate(fromDate);
		shTableRow.setPoItem(new java.math.BigInteger(lines[i]));
		shTableRow.setSerialNo(new java.math.BigInteger(scheduleLines[i]));
		shTable.insertRow(rCount,shTableRow);
		rCount++;
        }
	
        EzcParams params=new EzcParams(false);
        params.setObject(header);
        params.setObject(shTable);
        Session.prepareParams(params);
        ReturnObjFromRetrieve retObj=null;;
        String retMsg = null;

           try	
           {
		retObj = (ReturnObjFromRetrieve) AppManager.ezPostPODeliveryDates(params);
		
    		for ( int i=0;i<retObj.getRowCount();i++){
			String Msg = retObj.getFieldValueString(i,"MSG");
			String Type = retObj.getFieldValueString(i,"TYPE");
			//String Code = retObj.getFieldValueString(i,"CODE");
			//String MsgNo = retObj.getFieldValueString(i,"MSGNO");
			if ("E".equalsIgnoreCase(Type.trim())){
				retMsg= "ERROR : "+Msg;
				out.println(retMsg);
				break;
			}
			else if ("S".equalsIgnoreCase(Type.trim())){
				retMsg= Msg;
				out.println(retMsg);
				break;
			}
		}
	    }catch (Exception ex)
	    {
		retObj = null;
	    }	

%>

