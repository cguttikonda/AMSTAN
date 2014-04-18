/*
 * jQuery validate.password plug-in 1.0
 *
 * http://bassistance.de/jquery-plugins/jquery-plugin-validate.password/
 *
 * Copyright (c) 2009 Jörn Zaefferer
 *
 * $Id$
 *
 * Dual licensed under the MIT and GPL licenses:
 *   http://www.opensource.org/licenses/mit-license.php
 *   http://www.gnu.org/licenses/gpl.html
 */
(function($) {
	
	var LOWER = /[a-z]/,
		UPPER = /[A-Z]/,
		DIGIT = /[0-9]/,
		DIGITS = /[0-9].*[0-9]/,
		SPECIAL = /[^a-zA-Z0-9]/,
		SAME = /^(.)\1+$/;
		
	function rating(rate, message) {
		return {
			rate: rate,
			messageKey: message
		};
	}
	
	function uncapitalize(str) {
		return str.substring(0, 1).toLowerCase() + str.substring(1);
	}
	
	$.validator.passwordRating = function(newPassword, oldPassword) { 
		if (!newPassword || newPassword.length < 8)
			return rating(0, "too-short");
		if (oldPassword && newPassword.toLowerCase().match(oldPassword.toLowerCase()))
			return rating(0, "similar-to-oldPassword");
		if (SAME.test(newPassword))
			return rating(1, "very-weak");
		
		var lower = LOWER.test(newPassword),
			upper = UPPER.test(uncapitalize(newPassword)),
			digit = DIGIT.test(newPassword),
			digits = DIGITS.test(newPassword),
			special = SPECIAL.test(newPassword);
		
		if (lower && upper && digit || lower && digits || upper && digits || special)
			return rating(4, "strong");
		if (lower && upper || lower && digit || upper && digit)
			return rating(3, "good");
		return rating(2, "weak");
	}
	
	$.validator.passwordRating.messages = {
		alert("hi")
		"similar-to-oldPassword": "Too similar to oldPassword",
		"too-short": "Too short",
		"very-weak": "Very weak",
		"weak": "Weak",
		"good": "Good",
		"strong": "Strong"
	}
	
	$.validator.addMethod("newPassword", function(value, element, usernameField) {
		// use untrimmed value
		var newPassword = element.value,
		// get username for comparison, if specified
			oldPassword = $(typeof usernameField != "boolean" ? usernameField : []);
			
		var rating = $.validator.passwordRating(newPassword, oldPassword.val());
		// update message for this field
		
		var meter = $(".password-meter", element.form);
		
		meter.find(".password-meter-bar").removeClass().addClass("password-meter-bar").addClass("password-meter-" + rating.messageKey);
		meter.find(".password-meter-message")
		.removeClass()
		.addClass("password-meter-message")
		.addClass("password-meter-message-" + rating.messageKey)
		.text($.validator.passwordRating.messages[rating.messageKey]);
		// display process bar instead of error message
		
		return rating.rate > 2;
	}, "&nbsp;");
	// manually add class rule, to make username param optional
	$.validator.classRuleSettings.newPassword = { newPassword: true };
	
})(jQuery);
