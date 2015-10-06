(function() {

    'use strict';

    angular
        .module(APP_NAME)
        .controller('CoursesController', CoursesController)
        .controller('CourseParticipantsController', CourseParticipantsController);

    CoursesController
        .$inject = [
            '$location',
            '$routeParams',
            '$route',
            'Course',
            'Subject',
            'MessageService',
            'RedirectService',
            'ModalService'
        ];

    function CoursesController($location, $routeParams, $route, Course, Subject, MessageService, RedirectService, ModalService) {
        
        var vm = this;

        vm.createCourse = createCourse;
        vm.updateCourse = updateCourse;
        vm.deleteCourse = deleteCourse;
        vm.c_delete = c_delete;
        vm.retrieveSubject = retrieveSubject;

        vm.courses = [];
        vm.subjects = [];
        vm.fields = [];
        
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

        function createCourse() {
            vm.course.$save(function() {
                MessageService.sendMessage("Created!", "Course was created with success!", "success");
                RedirectService.redirect("/courses");
            },
            function(err) {
                MessageService.sendMessage("Fail!", "Course was NOT created with success!", "error");
                RedirectService.redirect("/courses");
            });
        };

        function updateCourse() {
            vm.course.$update(function() {
                MessageService.sendMessage("Updated!", "Course was updated with success!", "success");
                RedirectService.redirect("/courses");
            },
            function(err) {
                MessageService.sendMessage("Fail!", "Course was NOT updated with success!", "error");
                RedirectService.redirect("/courses");
            });
        }

        function deleteCourse(course_id) {
            var modal = new Modal();
            modal.title = "Confirmation";
            modal.body = "Are you sure you want to delete?";
            modal.confirmCallback = c_delete;
            modal.pack = course_id;
            ModalService.alert(modal);
        }

        function c_delete(id) {
            Course.delete({
                id: id
            }, function() {
                MessageService.sendMessage("Deleted!", "Course was deleted with success!", "success");
                RedirectService.redirect("/courses");
            },
            function(err) {
                MessageService.sendMessage("Fail!", "Course was NOT deleted with success!", "error");
                RedirectService.redirect("/courses");
            });
        }

        function retrieveSubject() {
            vm.subject = Subject.get({id: vm.course.subject_id});
        }

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

        function searchUsers(id, role) {
            Course.searchUsers({id: id, role_id: role.id, search_string: role.searchString}, function(data) {
                role.users = data;
            });
        }

        function clearSearch(role) {
            role.searchString = "";
            role.users = [];
        }

        function selectUser(user) {
            user.selected = !user.selected;
        }

        function selectAllUsers(role, selection) {
            for (var i = 0; i < role.users.length; i++) role.users[i].selected = selection;
        }

        function removeParticipant(user_id) {

        }

    }

})();
