(function() {

    'use strict';

    angular
        .module(APP_NAME)
        .controller('TestsController', TestsController)
        .controller('TestQuestionsController', TestQuestionsController)
        .controller('TestsStartController', TestsStartController);

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
            vm.questions = Test.searchQuestions({id: vm.test.id, search_string: vm.searchString}); 
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
            var questionsFiltered = [];
            // check to see if questions are allready added
            if(vm.test.questions.length > 0) {
                for(var i = 0; i < vm.questions.length; i++) {
                    for(var j = 0; j < vm.test.questions.length; j++) {
                        if(vm.test.questions[j].id == vm.questions[i].id) {
                            MessageService.sendMessage('test.questions.added.error.duplicate');
                        }
                        else {
                            questionsFiltered.push(vm.questions[i]);
                        }
                        vm.questions[i].selected = false;
                    }
                }
            } else {
                questionsFiltered = vm.questions;
            }
            
            // only do the request if questions are not added!
            if(questionsFiltered.length > 0) {
                Test.addQuestions({id: vm.test.id}, {questions: vm.questions}, function(data) {
                    MessageService.sendMessage('test.questions.added.success');
                    initialize();
                }, function(data) {
                    MessageService.sendMessage('test.questions.added.error');
                });
            }
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

    TestsStartController.$inject = ['$timeout', '$routeParams', 'Test', 'Question', 'Response', '$scope', 'lodash']
    function TestsStartController($timeout, $routeParams, Test, Question, Response, $scope,lodash) {
        var vm = this;
        vm.responses = [];
        vm.next_question = next_question;
        vm.response = new Response();

        // yes, this could be a directive..
        // could be... :)
        vm.tickInterval = 1000;
        vm.clock = 0;
        vm.counter = 0;
        var tick = function() {
            vm.counter = vm.counter + 1;
            formatTime();
            $timeout(tick, vm.tickInterval); 
        }
        function formatTime() {
            if(vm.counter < 60) {
                vm.clock = vm.counter + " seconds";
            }
            if(vm.counter > 60) {
                var time = Math.floor(vm.counter / 60);
                vm.clock = time + " minute(s)";
            }
        }
        //end of directive ;)

        // Start the timer
        $timeout(tick, vm.tickInterval);

        function intialize() {
            Test.get({id: $routeParams.id}, function(data) { 
                vm.test = data;
                vm.question_tracker = 0;
                vm.question = vm.test.questions[vm.question_tracker];
                set_current(vm.question.id);
            });
        } 

        function set_current(question_id) {
            Question.show({id: question_id}, function(data){
                vm.choices = data.choices;
                if(vm.responses[vm.question_tracker] === undefined) {
                    vm.keys = lodash.fill(Array(vm.choices.length), false);
                } else {
                    vm.keys = m.responses[vm.question_tracker].keys;
                }
            });
        }

        function next_question(next) {
            vm.responses[vm.question_tracker] = {
                keys: vm.keys,
                question_id: vm.question.id,
                response: vm.response.text
            }
            if(vm.question_tracker != vm.test.questions.length) {
                vm.question_tracker = vm.question_tracker + next;
                vm.question = vm.test.questions[vm.question_tracker];
                set_current(vm.question.id);
                if(vm.responses[vm.question_tracker] === undefined) {
                    vm.response = new Response();
                } else {
                    vm.response.text = vm.responses[vm.question_tracker].response;
                }
            }
            if ($scope.$root.$$phase != '$apply' && $scope.$root.$$phase != '$digest') {
                $scope.$apply();
            }
        }
        intialize();
    }

})();
