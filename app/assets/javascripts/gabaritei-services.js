app.factory('MessageService',['Message', function(Message) {
    var messages = {
    	"ok": " with success!",
    	"error": " with success!"	
    }

    var alertStatus = {
        "ok": "success",
        "error": "error"
    }

    function get(statusCode, target, action) {
        var message = new Message();
        
        
        if(alertStatus[statusCode] == alertStatus.ok)
        {
            message.content = target + ' ' + action + messages[statusCode];
            message.isSuccess = true;
        }
        if(alertStatus[statusCode] == alertStatus.error)
        {
            message.content = target + ' not ' + action + messages[statusCode];
            message.isError = true;
        }
        message.type = alertStatus[statusCode];
        message.showMessage = true;

        return message;
    }



    return {
        get: get
    }

}]);