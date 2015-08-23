'use strict';

describe('unit: MessagesController', function() {

    beforeEach(function() {
        this.addMatchers({
            toEqualData: function(expected) {
                return angular.equals(this.actual, expected);
            }
        });
    });
    beforeEach(module('gabariteiApp'));
    beforeEach(module('htmltemplates'));

    var scope, ctrl;
    var $MessageService = {
        addObserver: function(callback) {}
    };
    var createController;
    var $Message;

    beforeEach(inject(function($rootScope, $controller, Message) {
        createController = function createController() {
            $Message = Message;
            scope = $rootScope.$new();
            ctrl = $controller('MessagesController', {
                $scope: scope,
                MessageService: $MessageService
            });
        }
    }));

    it('Should register an observer', function() {
        spyOn($MessageService, "addObserver");
        createController();
        expect($MessageService.addObserver).toHaveBeenCalledWith(ctrl.receiveMessage);
    });

    it('Should receive a message', function() {
        createController();
        //On the service, it should be a Message object, not a string
        var message = new $Message();
        message.title = "Hello World!";
        message.content = "Hello Gabaritei!";
        message.type = "success";
        ctrl.receiveMessage(message);
        expect(ctrl.message).toEqual(message);
    });


});
