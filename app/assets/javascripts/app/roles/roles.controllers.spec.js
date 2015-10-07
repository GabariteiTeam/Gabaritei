'use strict';

describe('unit: RolesController', function() {

    var scope, ctrl, $httpBackend, $location, $ModalService;
    var createController;
    var location;
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
    var expectedRole = {
        "id": 1,
        "name": "Admin",
        "description": "This is a role",
        "permissions": [{id: 1}]
    };
    var expectedPermissionsResponse = [{
        "id": 1,
        "name": "Permission 1"
    }, {
        "id": 2,
        "name": "Permission 2"
    }];
    var expectedPermissions = [{
        "id": 1,
        "name": "Permission 1",
        "allowed": false
    }, {
        "id": 2,
        "name": "Permission 2",
        "allowed": false
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
        $httpBackend.expectGET('permissions.json').respond(expectedPermissionsResponse);


        ctrl = $controller('RolesController', {
            $scope: scope,
            MessageService: $MessageService,
            ModalService: $ModalService
        });

        createController = function() {
            scope = $rootScope.$new();
            ctrl = $controller('RolesController', {
                $scope: scope,
                $routeParams: {
                    id: "1"
                }
            });
            $httpBackend.expectGET('roles/1.json').respond(expectedRole);
        }

    }));


    it('Should get roles list', function() {
        expect(ctrl.roles).toEqual([]);
        expect(ctrl.permissions).toEqual([]);
        $httpBackend.flush();
        expect(ctrl.roles).toEqualData(expectedRoles);
        expect(ctrl.permissions).toEqualData(expectedPermissions);
    });

    it('Should get a specific role', function() {
        $httpBackend.flush();
        createController();
        $httpBackend.expectGET('permissions.json').respond(expectedPermissions);
        $httpBackend.flush();
        expect(ctrl.role.name).toEqual(expectedRole.name);
        expect(ctrl.role.id).toEqual(expectedRole.id);
        expect(ctrl.role.description).toEqual(expectedRole.description);
        expect(ctrl.permissions[0].allowed).toBe(true);
    });

    it('Should send update request', function() {
        $httpBackend.flush();
        $httpBackend.expectPUT('roles.json').respond({});
        spyOn($MessageService, "sendMessage");
        ctrl.updateRole();
        $httpBackend.flush();
        expect($MessageService.sendMessage).toHaveBeenCalledWith('role.updated.success');

    });

    it('Should send update request and fail', function() {
        $httpBackend.flush();
        $httpBackend.expectPUT('roles.json').respond(500);
        spyOn($MessageService, "sendMessage");
        ctrl.updateRole();
        $httpBackend.flush();
        expect($MessageService.sendMessage).toHaveBeenCalledWith('role.updated.error');
    });

    it('Should send delete request', function() {
        $httpBackend.flush();
        $httpBackend.expectDELETE('roles/1.json').respond({});
        spyOn($MessageService, "sendMessage");
        ctrl.c_delete(1);
        $httpBackend.flush();
        expect($MessageService.sendMessage).toHaveBeenCalledWith('role.deleted.success');
    });

    it('Should send delete request and fail', function() {
        $httpBackend.flush();
        $httpBackend.expectDELETE('roles/1.json').respond(500);
        spyOn($MessageService, "sendMessage");
        ctrl.c_delete(1);
        $httpBackend.flush();
        expect($MessageService.sendMessage).toHaveBeenCalledWith('role.deleted.error');
    });

    it('Should send create request', function() {
        $httpBackend.flush();
        $httpBackend.expectPOST('roles.json').respond({});
        spyOn($MessageService, "sendMessage");
        ctrl.createRole();
        $httpBackend.flush();
        expect($MessageService.sendMessage).toHaveBeenCalledWith('role.created.success');
    });

    it('Should send create request and fail', function() {
        $httpBackend.flush();
        $httpBackend.expectPOST('roles.json').respond(500);
        spyOn($MessageService, "sendMessage");
        ctrl.createRole(1);
        $httpBackend.flush();
        expect($MessageService.sendMessage).toHaveBeenCalledWith('role.created.error');
    });

});
