(function(){
	"use strict";
  	angular
  		.module(APP_NAME)
	  	.filter('htmlToPlaintext', htmlToPlaintext);
	function htmlToPlaintext() {
	    return function(text) {
	      return  text ? String(text).replace(/<[^>]+>/gm, '') : '';
	    };
	  }
  })();