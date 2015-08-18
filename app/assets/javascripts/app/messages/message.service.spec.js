'use strict';

describe('unit: MessageService', function() {

    beforeEach(function() {
        this.addMatchers({
            toEqualData: function(expected) {
                return angular.equals(this.actual, expected);
            }
        });
    });
    beforeEach(module('gabariteiApp'));
    beforeEach(module('htmltemplates'));

    var $MessageService;
    beforeEach(inject(function(MessageService) {
        $MessageService = MessageService;
    }));

    it("Should send and get a message", function() {
        var common = {
            callback: function(message) {
                $MessageService.getMessage();
            }
        };
        $MessageService.addObserver(common.callback);
        spyOn(common, "callback");
        $MessageService.sendMessage("Message Title", "Message content", "success");

    });

});
