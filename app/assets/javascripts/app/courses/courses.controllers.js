(function() {

    'use strict';

    angular
        .module(APP_NAME)
        .controller('CoursesController', CoursesController)
        .controller('CourseParticipantsController', CourseParticipantsController);

    CoursesController
        .$inject = [
            '$scope',
            '$location',
            '$routeParams',
            '$route',
            'Course',
            'Subject',
            'MessageService',
            'RedirectService',
            'ModalService'
        ];

    function CoursesController($scope, $location, $routeParams, $route, Course, Subject, MessageService, RedirectService, ModalService) {
        
        var vm = this;

        vm.createCourse = createCourse;
        vm.updateCourse = updateCourse;
        vm.c_delete = c_delete;
        vm.retrieveSubject = retrieveSubject;
        vm.delete_modal_id  = "confirmDeleteCourse";

        vm.courses = [];
        vm.subjects = [];
        vm.fields = [];
        
        activate();

        function activate() {
            if (!($routeParams.id === undefined)) {
                vm.course = Course.get({
                    id: $routeParams.id
                }, function() {
                    Subject.query(function(data) {
                        vm.subjects = data;
                        if (vm.course.category_type == "Subject") {
                            vm.course.subject_id = vm.course.category.id;
                        } else if (vm.course.category_type == "Field") {
                            vm.course.subject_id = vm.course.category.subject_id;
                            vm.course.field_id = vm.course.category.id;
                        }
                        retrieveSubject();
                    });
                });
            } else {
                vm.course = new Course();
                Course.query(function(data) {
                    vm.courses = data;
                    Subject.query(function(data) {
                        vm.subjects = data;
                    });
                });
            }            
        }

        function createCourse() {
            vm.course.$save(function() {
                MessageService.sendMessage('course.created.success');
                RedirectService.redirect("/courses");
            },
            function(err) {
                MessageService.sendMessage('course.created.error');
                RedirectService.redirect("/courses");
            });
        };

        function updateCourse() {
            vm.course.$update(function() {
                MessageService.sendMessage('course.updated.success');
                RedirectService.redirect("/courses");
            },
            function(err) {
                MessageService.sendMessage('course.updated.error');
                RedirectService.redirect("/courses");
            });
        }

        function c_delete(id) {
            Course.delete({id: id}, function() {
                MessageService.sendMessage('course.deleted.success');
                RedirectService.redirect("/courses");
            },
            function(err) {
                MessageService.sendMessage('course.deleted.error');
                RedirectService.redirect("/courses");
            });
        }

        function retrieveSubject() {
            vm.subject = Subject.get({id: vm.course.subject_id});
        }

        $scope.$on('devise:unauthorized', function(event, xhr, deferred) {
            RedirectService.redirect("/users/login");
        });

    };

    CourseParticipantsController
        .$inject = [
            '$location',
            '$routeParams',
            '$route',
            'Course',
            'User',
            'Role',
            'MessageService',
            'RedirectService',
            'ModalService'
        ];

    function CourseParticipantsController($location, $routeParams, $route, Course, User, Role, MessageService, RedirectService, ModalService) {
        
        var vm = this;

        vm.removeParticipant = removeParticipant;
        vm.searchUsers = searchUsers;
        vm.clearSearch = clearSearch;
        vm.selectUser = selectUser;
        vm.selectAllUsers = selectAllUsers;
        vm.addSelected = addSelected;

        vm.roles = [];

        initialize();

        function initialize() {
            vm.course = Course.get({
                id: $routeParams.id
            }, function() {
                Role.query({take_part_in_courses: true}, function(data) {
                    for (var i = 0; i < data.length; i++) data[i].users = [];
                    vm.roles = data;
                });
            });   
        }

        function searchUsers(role) {
            Course.searchUsers({id: vm.course.id, role_id: role.id, search_string: role.searchString}, function(data) {
                role.users = data;
                role.countSelectedUsers = 0;
            });
        }

        function clearSearch(role) {
            role.searchString = "";
            role.users = [];
            role.countSelectedUsers = 0;
        }

        function selectUser(role, user) {
            user.selected = !user.selected;
            role.countSelectedUsers = user.selected ? role.countSelectedUsers + 1 : role.countSelectedUsers - 1;
        }

        function selectAllUsers(role, selection) {
            role.countSelectedUsers = selection ? role.users.length : 0;
            for (var i = 0; i < role.users.length; i++) role.users[i].selected = selection;
        }

        function addSelected(role) {
            var newParticipants = role.users.filter(function(value) {
                return value.selected;
            });
            Course.addParticipants({id: vm.course.id}, {participants: newParticipants}, function(data) {
                MessageService.sendMessage('course.participants.added.success');
                initialize();
            }, function(data) {
                MessageService.sendMessage('course.participants.added.error');
            });
        }

        function removeParticipant(user_id) {
            vm.course.$removeParticipant({user_id: user_id}, function(data) {
                MessageService.sendMessage('course.participants.removed.success');
                vm.course = Course.get({id: $routeParams.id});
            }, function(data) {
                MessageService.sendMessage('course.participants.removed.error');
            });
        }

    }

})();
