(function() {

    'use strict';

    angular
        .module(APP_NAME)
        .controller('RequestsController', RequestsController)
        .controller('ManagementRequestsController', ManagementRequestsController)
        .controller('ConfirmationRequestsController', ConfirmationRequestsController);

    RequestsController.$inject = ['$routeParams', 'RegistrationRequest', 'CourseRegistrationRequest', 'MessageService', 'RedirectService', 'ModalService'];

    function RequestsController($routeParams, RegistrationRequest, CourseRegistrationRequest, MessageService, RedirectService, ModalService) {

        var vm = this;
        vm.deleteRegistrationRequest = deleteRegistrationRequest;
        vm.deleteCourseRegistrationRequest = deleteCourseRegistrationRequest;

        activate();

        function activate() {
            vm.registration_requests = RegistrationRequest.query();
            vm.course_registration_requests = CourseRegistrationRequest.query();
        }

        function deleteRegistrationRequest(id) {
            RegistrationRequest.delete({id: id}, function(success) {
                MessageService.sendMessage('request.deleted.success');
                RedirectService.redirect("/requests");
            }, function(error) {
                MessageService.sendMessage('request.deleted.error');
            });
        }

        function deleteCourseRegistrationRequest(id) {
            CourseRegistrationRequest.delete({id: id}, function(success) {
                MessageService.sendMessage('request.deleted.success');
                RedirectService.redirect("/requests");
            }, function(error) {
                MessageService.sendMessage('request.deleted.error');
            });
        }

    }

    ManagementRequestsController.$inject = ['$routeParams', 'request', 'RegistrationRequest', 'CourseRegistrationRequest', 'Course', 'MessageService', 'RedirectService', 'ModalService'];

    function ManagementRequestsController($routeParams, request, RegistrationRequest, CourseRegistrationRequest, Course, MessageService, RedirectService, ModalService) {

        var vm = this;
        vm.sendRequest = sendRequest;
        vm.sendAssessment = sendAssessment;

        activate();

        function activate() {
            if ($routeParams.id !== undefined) {
                vm.request = request;
                vm.assessment = true;
            } else {
                if (request instanceof RegistrationRequest) {
                    vm.request = request;
                    vm.requestType = "registration";
                } else {
                    vm.request = new CourseRegistrationRequest();
                    vm.request.requirer = request;
                    vm.assessment = false;
                    vm.requestType = "course";
                    vm.request.course = Course.get({id: $routeParams.course_id});
                }
            }
        }
        
        function sendRequest() {
            vm.request.$save(function(data) {
                MessageService.sendMessage('request.created.success');
                RedirectService.redirect("/requests/" + vm.requestType + "/sent/" + data.id);
            }, function(error) {
                MessageService.sendMessage('request.created.error');
            });
        }

        function sendAssessment() {
            vm.request.$assess(function(data) {
                MessageService.sendMessage('request.assessed.success');
                RedirectService.redirect("/requests");
            }, function(error) {
                MessageService.sendMessage('request.assessed.error');
            });
        }

    }

    ConfirmationRequestsController.$inject = ['request'];

    function ConfirmationRequestsController(request) {
        var vm = this;
        vm.request = request;
    }
    
})();