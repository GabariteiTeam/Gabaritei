(function() {

    'use strict';

    angular
        .module(APP_NAME)
        .controller('TestsController', TestsController)
        .controller('TestQuestionsController', TestQuestionsController);

    TestsController
        .$inject = [
            '$location',
            '$routeParams',
            '$route',
            'Test',
            'Course',
            'MessageService',
            'RedirectService',
            'ModalService'
        ];

    function TestsController($location, $routeParams, $route, Test, Course, MessageService, RedirectService, ModalService) {
        
        var vm = this;

        vm.createTest      = createTest;
        vm.updateTest      = updateTest;
        vm.retrieveCourse  = retrieveCourse;
        vm.c_delete        = c_delete;
        vm.delete_modal_id = "confirmDeleteTest";

        vm.courses  = [];

        activate();

        function activate() {
            if (!($routeParams.id === undefined)) {
                vm.test = Test.get({
                    id: $routeParams.id
                }, function() { 
                    Course.query(function(data) {
                        vm.courses = data;
                        retrieveCourse();
                    });
                    console.log("edit");
                });

            } else {
                vm.test = new Test();
                Test.query(function(data) {
                    vm.tests = data;
                    Course.query(function(data) {
                        vm.courses = data;
                    });
                });
                console.log("view");
            }            
        }

        function createTest() {
            vm.test.$save(function() {
                MessageService.sendMessage('test.created.success');
                RedirectService.redirect("/tests");
            },
            function(err) {
                MessageService.sendMessage('test.created.error');
                RedirectService.redirect("/tests");
            });
        };

        function updateTest() {
            vm.test.$update(function() {
                MessageService.sendMessage('test.updated.success');
                RedirectService.redirect("/tests");
            },
            function(err) {
                MessageService.sendMessage('test.updated.error');
                RedirectService.redirect("/tests");
            });
        }

        function c_delete(id) {
            Test.delete({
                id: id
            }, function() {
                MessageService.sendMessage('test.deleted.success');
                RedirectService.redirect("/tests");
            },
            function(err) {
                MessageService.sendMessage('test.deleted.error');
                RedirectService.redirect("/tests");
            });
        }

        function retrieveCourse() {
            vm.course = Course.get({id: vm.test.course_id});
        }
    };

    TestQuestionsController
        .$inject = [
            '$location',
            '$routeParams',
            '$route',
            'Test',
            'Course',
            'Question',
            'MessageService',
            'RedirectService',
            'ModalService'
        ];

    function TestQuestionsController($location, $routeParams, $route, Test, 
                        Course, Question, MessageService, RedirectService, ModalService) {
        
        var vm = this;

        vm.removeQuestion = removeQuestion;
        vm.searchQuestions = searchQuestions;
        vm.clearSearch = clearSearch;
        vm.selectQuestion = selectQuestion;
        vm.selectAllQuestions = selectAllQuestions;
        vm.addSelected = addSelected;

        vm.questions = [];
        vm.test = Test.get({id: $routeParams.id});

        initialize();

        function initialize() {
            vm.test = Test.get({ id: $routeParams.id });   
        }

        function searchQuestions() {
            Test.searchQuestions({id: vm.test.id, search_string: vm.searchString}, function(data) {
                vm.questions = data;
            }); 
        }

        function clearSearch() {
            vm.searchString = "";
            vm.questions = [];
        }

        function selectQuestion(question) {
            question.selected = !question.selected;
        }

        function selectAllQuestions(selection) {
            for (var i = 0; i < vm.questions.length; i++) {
                vm.questions[i].selected = selection;
            }
        }

        function addSelected() {
            var newQuestions = vm.questions.filter(function(value) {
                return value.selected;
            });
            Test.addQuestions({id: vm.test.id}, {questions: newQuestions}, function(data) {
                MessageService.sendMessage('test.questions.added.success');
                initialize();
            }, function(data) {
                MessageService.sendMessage('test.questions.added.error');
            });
        }

        function removeQuestion(question_id) {
            vm.test.$removeQuestion({question_id: question_id}, function(data) {
                MessageService.sendMessage('test.questions.removed.success');
                vm.test = Test.get({id: $routeParams.id});
            }, function(data) {
                MessageService.sendMessage('test.questions.removed.error');
            });
        }

    }

})();
