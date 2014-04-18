var sessionAgent ="<%= sessionAgentCode %>"
var selSelect    = new Array();

if((UserRole == "CU")&& (shipRowCount != 1))
{
	selselect("shipTo,<%= ShipTo %>")
	setShipName();
}
else if( (UserRole != "CU")&& (SoldTo =="" )&&(sessionAgent != SoldTo) &&  (RefDocType =="S" ))
{
	selselect("soldTo,<%= SoldTo %>");
	setSoldName();
}
else if((UserRole != "CU")&& (SoldTo !="" ))
{
	if((shipRowCount != 1)  && (RefDocType !="S" ) && (sessionAgent != SoldTo))
	{
		selselect("shipTo,<%= ShipTo %>");
		setShipName()
		selselect("soldTo,<%= SoldTo %>");
		setSoldName()
	}
	else if((shipRowCount != 1) && (RefDocType =="S" ))
	{
		selselect("shipTo,<%= ShipTo %>");
		setShipName()
	}
	else if((shipRowCount == 1) && (RefDocType !="S" ) && (sessionAgent != SoldTo))
	{
		selselect("soldTo,<%= SoldTo %>");
		setSoldName()
	}else if((shipRowCount != 1))
	{
		selselect("shipTo,<%= ShipTo %>");
		setShipName()
	}
}