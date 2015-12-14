(function() {

    'use strict';

    angular
        .module(APP_NAME)
        .controller('CoursesController', CoursesController)
        .controller('CourseParticipantsController', CourseParticipantsController)
        .controller('CourseShowController', CourseShowController)
        .controller('LessonsController', LessonsController);

    CoursesController.$inject = ['$routeParams', 'Course', 'Subject', 'MessageService', 'RedirectService', 'ModalService', 'PermissionsService'];

    function CoursesController($routeParams, Course, Subject, MessageService, RedirectService, ModalService, PermissionsService) {
     
        var vm = this;

        vm.createCourse = createCourse;
        vm.updateCourse = updateCourse;
        vm.c_delete = c_delete;
        vm.retrieveSubject = retrieveSubject;
        vm.clearAvatar = clearAvatar;
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
                    if (!vm.course.has_avatar) vm.course.avatar = null;
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
                        PermissionsService.verifyPermissions(['permission.courses.globally_manipulate', 'permission.courses.manipulate', 'permission.courses.teach', 'permission.courses.take_part'], function(permissions) {
                            vm.permissions = permissions;
                        });
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

        function clearAvatar() {
            vm.course.avatar = null;
            jQuery('#avatar').wrap('<form>').closest('form').get(0).reset();
            jQuery('#avatar').unwrap();
        }

    };

    CourseParticipantsController.$inject = ['$routeParams', 'Course', 'User', 'Role', 'MessageService', 'RedirectService', 'ModalService'];

    function CourseParticipantsController($routeParams, Course, User, Role, MessageService, RedirectService, ModalService) {
        
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
            vm.course = Course.get({id: $routeParams.id});
            Role.rolesForCourses(function(data) {
                for (var i = 0; i < data.length; i++) data[i].users = [];
                vm.roles = data;
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

    CourseShowController.$inject = ['$routeParams', 'Course', 'MessageService', 'RedirectService', 'PermissionsService'];

    function CourseShowController($routeParams, Course, MessageService, RedirectService, PermissionsService) {

        var vm = this;

        vm.deleteLesson = deleteLesson;

        activate();

        function activate() {
            Course.showEverything({id: $routeParams.id}, function(course) {
                vm.course = course;
                vm.course_category = course.category_type == "Field" ? course.field + " (" + course.subject + ")" : course.subject
                PermissionsService.verifyPermissions(['permission.courses.globally_manipulate', 'permission.courses.manipulate', 'permission.courses.teach', 'permission.courses.take_part'], function(permissions) {
                    vm.permissions = permissions;
                });
            });
        }

        function deleteLesson(lesson_id) {
            Course.deleteLesson({id: vm.course.id, lesson_id: lesson_id}, function(success) {
                MessageService.sendMessage('course.lessons.deleted.success');
                RedirectService.redirect("/courses/" + vm.course.id);
            }, function(error) {
                MessageService.sendMessage('course.lessons.deleted.error');
            });
        }
    }

    LessonsController.$inject = ['$routeParams', 'Course', 'Content', 'Question', 'MessageService', 'RedirectService'];

    function LessonsController($routeParams, Course, Content, Question, MessageService, RedirectService) {

        var vm = this;

        vm.createLesson = createLesson;
        vm.editLesson = editLesson;

        activate();

        function activate() {
            vm.course = Course.get({id: $routeParams.id}, function() {
               Content.contentsForLesson({course_id: $routeParams.id, lesson_id: $routeParams.lesson_id}, function(contents) {
                    vm.contents = contents;
                    Question.questionsForLesson({course_id: $routeParams.id, lesson_id: $routeParams.lesson_id}, function(questions) {
                        vm.questions = questions;
                        if ($routeParams.lesson_id !== undefined) {
                            Course.getLesson({id: $routeParams.id, lesson_id: $routeParams.lesson_id}, function(lesson) {
                                vm.lesson = lesson;
                            });
                        }
                    });
                }); 
            });
        }

        function beforeSave() {
            vm.lesson.contents = [];
            vm.lesson.questions = [];
            for (var i = 0; i < vm.contents.length; i++) {
                if (vm.contents[i].in_lesson == true) {
                    vm.lesson.contents.push(vm.contents[i].id);
                }
            }
            for (var i = 0; i < vm.questions.length; i++) {
                if (vm.questions[i].in_lesson == true) {
                    vm.lesson.questions.push(vm.questions[i].id);
                }
            }
        }

        function createLesson() {
            beforeSave();
            Course.addLesson({id: vm.course.id, lesson: vm.lesson}, function(success) {
                MessageService.sendMessage('course.lessons.added.success');
                RedirectService.redirect("/courses/" + vm.course.id);
            }, function(error) {
                MessageService.sendMessage('course.lessons.added.error');
                vm.lesson.contents = [];
                vm.lesson.questions = [];
            });
        }

        function editLesson() {
            beforeSave();
            Course.editLesson({id: vm.course.id, lesson: vm.lesson}, function(success) {
                MessageService.sendMessage('course.lessons.updated.success');
                RedirectService.redirect("/courses/" + vm.course.id);
            }, function(error) {
                MessageService.sendMessage('course.lessons.updated.error');
                vm.lesson.contents = [];
                vm.lesson.questions = [];
            });
        }

    }

})();
