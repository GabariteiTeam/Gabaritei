'use strict';

describe('unit: UsersController', function() {

    var scope, ctrl, $httpBackend, $location, $ModalService;
    var createController;
    var location;
    var expectedUsers = [{
        "id": 1,
        "first_name": "User1",
        "last_name": "User1",
        "email": "user1@user1.com",
        "birthdate": "01/01/1970",
        "about": "About user 1"
    }, {
        "id": 2,
        "first_name": "User2",
        "last_name": "User2",
        "email": "user2@user2.com",
        "birthdate": "01/01/1970",
        "about": "About user 2"
    }];
    var expectedUser = {
        "id": 1,
        "first_name": "User1",
        "last_name": "User1",
        "email": "user1@user1.com",
        "birthdate": "01/01/1970",
        "about": "About user 1"
    };

    var $MessageService = {
        sendMessage: function(title, content, type) {}
    };

    beforeEach(inject(function(_$httpBackend_, $rootScope, $controller, _$location_, ModalService) {
        $httpBackend = _$httpBackend_;
        $location = _$location_;

        $ModalService = ModalService;
        scope = $rootScope.$new();
        $httpBackend.expectGET('translations/en.json').respond({});
        $httpBackend.expectGET('users.json').respond(expectedUsers);

        ctrl = $controller('UsersController', {
            $scope: scope,
            MessageService: $MessageService,
            ModalService: $ModalService
        });

        createController = function() {
            scope = $rootScope.$new();
            ctrl = $controller('UsersController', {
                $scope: scope,
                $routeParams: {id: "1"}
            });
            $httpBackend.expectGET('users/1.json').respond(expectedUser);
        }

    }));


    it('Should get users list', function() {
        expect(ctrl.users).toEqual([]);
        $httpBackend.flush();
        expect(ctrl.users).toEqualData(expectedUsers);
    });

    it('Should get a specific user', function() {
        $httpBackend.flush();
        createController();
        $httpBackend.flush();
        expect(ctrl.user.id).toEqual(expectedUser.id);
        expect(ctrl.user.first_name).toEqual(expectedUser.first_name);
        expect(ctrl.user.last_name).toEqual(expectedUser.last_name);
        expect(ctrl.user.birthdate).toEqual(expectedUser.birthdate);
        expect(ctrl.user.email).toEqual(expectedUser.email);
        expect(ctrl.user.about).toEqual(expectedUser.about);
    });

    it('Should send delete request', function() {
        $httpBackend.flush();
        $httpBackend.expectDELETE('users/1.json').respond({});
        spyOn($MessageService, "sendMessage");
        spyOn($ModalService, "alert");
        ctrl.deleteUser(1);
        ctrl.c_delete(1);
        $httpBackend.flush();
        expect($MessageService.sendMessage).toHaveBeenCalledWith("Deleted!", "User was deleted with success!", "success");
        expect($ModalService.alert).toHaveBeenCalled();
    });

    it('Should send delete request and fail', function() {
        $httpBackend.flush();
        $httpBackend.expectDELETE('users/1.json').respond(500);
        spyOn($ModalService, "alert");
        spyOn($MessageService, "sendMessage");
        ctrl.deleteUser(1);
        ctrl.c_delete(1);
        $httpBackend.flush();
        expect($ModalService.alert).toHaveBeenCalled();
        expect($MessageService.sendMessage).toHaveBeenCalledWith("Fail!", "User was NOT deleted with success!", "error");
    });

});

describe('unit: EditUserController', function() {

    var scope, ctrl, $httpBackend, $location, $ModalService;
    var createController;
    var location;
    var expectedUser = {
        "id": 1,
        "first_name": "User1",
        "last_name": "User1"
    };
    var expectedRoles = [{
        "id": 1,
        "name": "Admin",
        "description": "This is a role"
    }, {
        "id": 2,
        "name": "Teacher",
        "description": "This is a role"
    }, {
        "id": 3,
        "name": "Student",
        "description": "This is a role"
    }];
    var $MessageService = {
        sendMessage: function(title, content, type) {}
    };

    beforeEach(inject(function(_$httpBackend_, $rootScope, $controller, _$location_, ModalService) {
        $httpBackend = _$httpBackend_;
        $location = _$location_;

        $ModalService = ModalService;
        scope = $rootScope.$new();
        $httpBackend.expectGET('translations/en.json').respond({});
        $httpBackend.expectGET('roles.json').respond(expectedRoles);

        ctrl = $controller('EditUserController', {
            $scope: scope,
            MessageService: $MessageService,
            ModalService: $ModalService,
            $routeParams: {id: "1"}
        });

        $httpBackend.expectGET('users/1.json').respond(expectedUser);

    }));

    it('Should send update request', function() {
        $httpBackend.flush();
        $httpBackend.expectPUT('users/1').respond({});
        spyOn($MessageService, "sendMessage");
        ctrl.updateUser();
        $httpBackend.flush();
        expect($MessageService.sendMessage).toHaveBeenCalledWith("Updated!", "User was updated with success!", "success");

    });

    it('Should send update request and fail', function() {
        $httpBackend.flush();
        $httpBackend.expectPUT('users/1').respond(500);
        spyOn($MessageService, "sendMessage");
        ctrl.updateUser();
        $httpBackend.flush();
        expect($MessageService.sendMessage).toHaveBeenCalledWith("Fail!", "User was NOT updated with success!", "error");
    });

    it('Should send create request', function() {
        $httpBackend.flush();
        $httpBackend.expectPOST('users/').respond({});
        spyOn($MessageService, "sendMessage");
        ctrl.createUser();
        $httpBackend.flush();
        expect($MessageService.sendMessage).toHaveBeenCalledWith("Created!", "User was created with success!", "success");
    });

    it('Should send create request and fail', function() {
        $httpBackend.flush();
        $httpBackend.expectPOST('users/').respond(500);
        spyOn($MessageService, "sendMessage");
        ctrl.createUser(1);
        $httpBackend.flush();
        expect($MessageService.sendMessage).toHaveBeenCalledWith("Fail!", "User was NOT created with success!", "error");
    });

});
