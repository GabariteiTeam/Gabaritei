(function(){
angular
        .module(APP_NAME)
        .factory('TagInputUtils', TagInputUtils);


    function TagInputUtils() {
    	
    	function isInArray(inputArray, key) {
    		for(var i in inputArray)
    			if(inputArray[i].text === key)
    				return true;
    		return false;
    	}

    	function popKey(inputArray, key) {
    		for(var i in inputArray)
    			if(inputArray[i].text === key)
    				return inputArray.splice(i, 1);
    	}

    	return {
    		isInArray: isInArray,
    		popKey: popKey
    	}
    }
})();