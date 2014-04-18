// Library for credit card validations 
/*  ================================================================
	// Removes all characters which do NOT appear in string bag 
	// from string s.
================================================================ */
function stripCharsNotInBag (s,bag)
{   
	var i;
	var returnString = "";

	// Search through string's characters one by one.
	// If character is in bag, append to returnString.

	for (i = 0; i < s.length; i++){   
		// Check that current character isn't whitespace.
		var c = s.charAt(i);
		if (bag.indexOf(c) != -1) returnString += c;
	}

	return returnString;
}

/*  ================================================================
	    FUNCTION:  isCreditCard(st)
	    INPUT:     st - a string representing a credit card number
	    RETURNS:  true, if the credit card number passes the Luhn Mod-10
			    test.
		      false, otherwise
================================================================ */
function isCreditCard(st) 
{
	  // Encoding only works on cards with less than 19 digits
	  if (st.length > 19)
	    return (false);

	  sum = 0; mul = 1; l = st.length;
	  for (i = 0; i < l; i++) {
	    digit = st.substring(l-i-1,l-i);
	    tproduct = parseInt(digit ,10)*mul;
	    if (tproduct >= 10)
	      sum += (tproduct % 10) + 1;
	    else
	      sum += tproduct;
	    if (mul == 1)
	      mul++;
	    else
	      mul--;
	}
	// Uncomment the following line to help create credit card numbers
	// 1. Create a dummy number with a 0 as the last digit
	// 2. Examine the sum written out
	// 3. Replace the last digit with the difference between the sum and
	//    the next multiple of 10.

	//  document.writeln("<BR>Sum      = ",sum,"<BR>");
	// alert("Sum      = " + sum);

	  if ((sum % 10) == 0)
	    return (true);
	  else
	    return (false);

} // END FUNCTION isCreditCard()

/*  ================================================================
	    FUNCTION:  isVisa()
	    INPUT:     cc - a string representing a credit card number
	    RETURNS:  true, if the credit card number is a valid VISA number.
		      false, otherwise
	    Sample number: 4111 1111 1111 1111 (16 digits)
================================================================ */
function isVisa(cc)
{
	  if (((cc.length == 16) || (cc.length == 13)) &&
	      (cc.substring(0,1) == 4))
	    return isCreditCard(cc);
	  return false;
}  // END FUNCTION isVisa()

/*  ================================================================
	    FUNCTION:  isMasterCard()
	    INPUT:     cc - a string representing a credit card number
	    RETURNS:  true, if the credit card number is a valid MasterCard
			    number.
		      false, otherwise
	    Sample number: 5500 0000 0000 0004 (16 digits)
================================================================ */

function isMasterCard(cc)
{
	  firstdig = cc.substring(0,1);
	  seconddig = cc.substring(1,2);
	  if ((cc.length == 16) && (firstdig == 5) &&
	      ((seconddig >= 1) && (seconddig <= 5)))
	    return isCreditCard(cc);
	  return false;

} // END FUNCTION isMasterCard()

/*  ================================================================
	    FUNCTION:  isAmericanExpress()
	    INPUT:     cc - a string representing a credit card number
	    RETURNS:  true, if the credit card number is a valid American
			    Express number.
		      false, otherwise
	    Sample number: 340000000000009 (15 digits)
================================================================ */
function isAmericanExpress(cc)
{
	  firstdig = cc.substring(0,1);
	  seconddig = cc.substring(1,2);
	  if ((cc.length == 15) && (firstdig == 3) &&
	      ((seconddig == 4) || (seconddig == 7)))
	    return isCreditCard(cc);
	  return false;

} // END FUNCTION isAmericanExpress()

/*  ================================================================
	    FUNCTION:  isDinersClub()
	    INPUT:     cc - a string representing a credit card number
	    RETURNS:  true, if the credit card number is a valid Diner's
			    Club number.
		      false, otherwise
	    Sample number: 30000000000004 (14 digits)
================================================================ */

function isDinersClub(cc)
{
	  firstdig = cc.substring(0,1);
	  seconddig = cc.substring(1,2);
	  if ((cc.length == 14) && (firstdig == 3) &&
	      ((seconddig == 0) || (seconddig == 6) || (seconddig == 8)))
	    return isCreditCard(cc);
	  return false;
}

/*  ================================================================
	    FUNCTION:  isCarteBlanche()
	    INPUT:     cc - a string representing a credit card number
	    RETURNS:  true, if the credit card number is a valid Carte
			    Blanche number.
		      false, otherwise
================================================================ */

function isCarteBlanche(cc)
{
	  return isDinersClub(cc);
}

/*  ================================================================
	    FUNCTION:  isDiscover()
	    INPUT:     cc - a string representing a credit card number
	    RETURNS:  true, if the credit card number is a valid Discover
			    card number.
		      false, otherwise
	    Sample number: 6011000000000004 (16 digits)
================================================================ */

function isDiscover(cc)
{
	  first4digs = cc.substring(0,4);
	  if ((cc.length == 16) && (first4digs == "6011"))
	    return isCreditCard(cc);
	  return false;

} // END FUNCTION isDiscover()

/*  ================================================================
	    FUNCTION:  isEnRoute()
	    INPUT:     cc - a string representing a credit card number
	    RETURNS:  true, if the credit card number is a valid enRoute
			    card number.
		      false, otherwise
	    Sample number: 201400000000009 (15 digits)
================================================================ */
function isEnRoute(cc)
{
	  first4digs = cc.substring(0,4);
	  if ((cc.length == 15) &&
	      ((first4digs == "2014") ||
	       (first4digs == "2149")))
	    return isCreditCard(cc);
	  return false;
}

/*  ================================================================
		FUNCTION:  isJCB()
	    INPUT:     cc - a string representing a credit card number
	    RETURNS:  true, if the credit card number is a valid JCB
			    card number.
		      false, otherwise
================================================================ */

function isJCB(cc)
{
	  first4digs = cc.substring(0,4);
	  if ((cc.length == 16) &&
	      ((first4digs == "3088") ||
	       (first4digs == "3096") ||
	       (first4digs == "3112") ||
	       (first4digs == "3158") ||
	       (first4digs == "3337") ||
	       (first4digs == "3528")))
	    return isCreditCard(cc);
	  return false;

} // END FUNCTION isJCB()

/*  ================================================================
	    FUNCTION:  isAnyCard()
	    INPUT:     cc - a string representing a credit card number
	    RETURNS:  true, if the credit card number is any valid credit
			    card number for any of the accepted card types.
		      false, otherwise
================================================================ */

function isAnyCard(cc)
{
	  if (!isCreditCard(cc))
	    return false;
//	  if (!isMasterCard(cc) && !isVisa(cc) && !isAmericanExpress(cc) && !isDinersClub(cc) && !isDiscover(cc) && !isEnRoute(cc) && !isJCB(cc)) {
	  if (!isMasterCard(cc) && !isVisa(cc) && !isAmericanExpress(cc) && !isEnRoute(cc) && !isJCB(cc)) {
	    return false;
	  }
	  return true;

} // END FUNCTION isAnyCard()

/*  ================================================================
	    FUNCTION:  isCardMatch()
	    INPUT:    cardType - a string representing the credit card type
		      cardNumber - a string representing a credit card number
	    RETURNS:  true, if the credit card number is valid for the particular
		      credit card type given in "cardType".
		      false, otherwise
================================================================ */

function isCardMatch (cardType, cardNumber)
{
		cardType = cardType.toUpperCase();
		var doesMatch = true;

		if ((cardType == "VISA") && (!isVisa(cardNumber)))
			doesMatch = false;
		if ((cardType == "MASTERCARD") && (!isMasterCard(cardNumber)))
			doesMatch = false;
		if ( ( (cardType == "AMERICANEXPRESS") || (cardType == "AMEX") )
	                && (!isAmericanExpress(cardNumber))) doesMatch = false;
		if ((cardType == "DISCOVER") && (!isDiscover(cardNumber)))
			doesMatch = false;
		if ((cardType == "JCB") && (!isJCB(cardNumber)))
			doesMatch = false;
		if ((cardType == "DINERS") && (!isDinersClub(cardNumber)))
			doesMatch = false;
		if ((cardType == "CARTEBLANCHE") && (!isCarteBlanche(cardNumber)))
			doesMatch = false;
		if ((cardType == "ENROUTE") && (!isEnRoute(cardNumber)))
			doesMatch = false;
		return doesMatch;

}  // END FUNCTION CardMatch()

//****************************************************
//Actual checking takes place here calling all the functions
function ValidateCreditCard(tCardNumber,tCardType)
{
	if(isEmpty(tCardNumber ))
		{
			alert("Please Enter A Credit Card Number")
			return false
		}else{
				
			tCardNumber = stripCharsNotInBag(tCardNumber,"0123456789")

			if(isAnyCard(tCardNumber) == true)
			{
				if(!(isCardMatch (tCardType,tCardNumber)))
				{
					alert("Please enter a valid card number")
					return false
				}
			}else{
				alert("Please enter a valid card number")
				return false
		     	         }
		          }
	return true
}//end function