<%@ page import = "ezc.ezparam.*,ezc.ezmisc.params.*" %>
<%
	String userId	= Session.getUserId();
	String frDate 	= request.getParameter("fromDate");
	String tDate	= request.getParameter("toDate");
	String subShipTos = "";
	
				
	String serachQ = "SELECT ESDH_PO_NO,ESDH_CREATE_ON,ESDH_DOC_NUMBER,ESDH_SYS_KEY,ESDH_MODIFIED_ON,ESDH_SOLD_TO,ESDH_STATUS FROM EZC_SALES_DOC_HEADER WHERE ESDH_STATUS IN ('REJECTED','CLOSED') AND ESDH_CREATED_BY ='"+userId+"'";
	
	if(frDate!=null && tDate!=null && !"null".equals(frDate) && !"null".equals(tDate))
		serachQ	= serachQ+" AND ESDH_ORDER_DATE BETWEEN  convert(DATETIME,'"+frDate+"',110)  and  convert(DATETIME,'"+tDate+"',110)";

	String allSolds = (String)session.getValue("SOLDTO_SUPER");
	String soldTs	="";
	String shipTs	="";
	String subShip ="";
	if("".equals(request.getParameter("selSoldTo")))
	{
		String[] soldsToken	= allSolds.split("¥");
		if(soldsToken.length>1)
		{
			for(int i=0;i<soldsToken.length;i++)
			{
				if(i==0)
					soldTs=soldsToken[i];	
				else
					soldTs=soldTs+"','"+soldsToken[i];
			}
			serachQ = serachQ+" AND ESDH_SOLD_TO IN('"+soldTs+"')";
		}
	}
	//else if(request.getParameter("selSoldTo")!=null && !"".equals(request.getParameter("selSoldTo")) && !"null".equals(request.getParameter("selSoldTo")))
	else
	{
		soldTs = request.getParameter("selSoldTo");
		serachQ = serachQ+" AND ESDH_SOLD_TO IN('"+soldTs+"')";
	}

	if("A".equals(request.getParameter("shipTo")))
	{
		Vector delShips = (Vector)getSubUserShips(Session.getUserId(),Session);
		for(int i=0;i<delShips.size();i++)
		{
			if(subShip=="" || "".equals(subShip))
				subShip = (String)delShips.get(i);
			else
				subShip = subShip +"','"+(String)delShips.get(i);
		}
		serachQ = serachQ + " AND ESDH_SHIP_TO IN ('"+subShip+"')";
	}
	//else if(request.getParameter("shipTo")!=null && !"".equals(request.getParameter("shipTo")) && !"null".equals(request.getParameter("shipTo")))
	else
	{
		shipTs = request.getParameter("shipTo");
		serachQ = serachQ+" AND ESDH_SOLD_TO IN('"+shipTs+"')";
	}
	
	ezc.ezparam.EzcParams mainParams_R =null;
	ezc.ezmisc.params.EziMiscParams miscParams_R = new ezc.ezmisc.params.EziMiscParams();
	ezc.ezparam.ReturnObjFromRetrieve rejInqObj=null;
	mainParams_R=new ezc.ezparam.EzcParams(true);
	miscParams_R.setIdenKey("MISC_SELECT");
	miscParams_R.setQuery(serachQ);
	mainParams_R.setLocalStore("Y");
	mainParams_R.setObject(miscParams_R);
	Session.prepareParams(mainParams_R);

	try
	{
		rejInqObj = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParams_R);
	}
	catch(Exception e)
	{
		System.out.println("ERROR::::::::::::::::::::"+e);
	}	
%>
	