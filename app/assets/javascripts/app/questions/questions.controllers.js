(function() {
    'use strict';

    angular
        .module(APP_NAME)
        .controller('QuestionsController', QuestionsController)
        .controller('NewQuestionController', NewQuestionController)
        .controller('UpdateQuestionController', UpdateQuestionController);

    QuestionsController.$inject = ['$routeParams', 'MessageService', 'Question', 'RedirectService', 'ModalService'];

    function QuestionsController($routeParams, MessageService, Question, RedirectService, ModalService) {
        var vm = this;
        vm.deleteQuestion = deleteQuestion;
        vm.c_delete = c_delete;
        vm.questions = Question.query();
        vm.delete_modal_id = 'confirmDeleteQuestion';


        function deleteQuestion(id) {
            ModalService.registerCallback(c_delete);
            ModalService.setArgs(id);
            $("#" + vm.delete_modal_id).modal();
        }

        function c_delete(id) {
            ModalService.hideModal();
            Question.destroy({
                    id: id
                }, function() {
                    MessageService.sendMessage("question.deleted.sucess");
                    RedirectService.redirect("/questions");
                },
                function(err) {
                    MessageService.sendMessage('question.deleted.error');
                    RedirectService.redirect("/questions");
            });
        }
    }

    NewQuestionController.$inject = ['$routeParams', 'MessageService', 'Question', 'RedirectService', 'Subject'];

    function NewQuestionController($routeParams, MessageService, Question, RedirectService, Subject) {
        var vm = this;
        vm.question = new Question();
        vm.createQuestion = createQuestion;
        Subject.query({}, function(data){
            vm.subjectsTags = [];
            vm.subjects = data;
            for(var i = 0; i < data.length; i++)
                vm.subjectsTags.push(data[i].name);
        });


        function createQuestion() {
            vm.question.subjects = [];
            if(vm.subjectInput !== undefined)
            {
                for(var i = 0; i < vm.subjectInput.length; i++) {
                    var subjectName = vm.subjectInput[i].text;
                    for(var j = 0; j < vm.subjects.length; j++) {
                        if(vm.subjects[j].name == subjectName){
                            vm.question.subjects.push(vm.subjects[j].id);
                        }
                    }
                }
            }
            
            vm.question.$save({'subjects[]': vm.question.subjects},function(){
                MessageService.sendMessage('question.created.sucess');
                    RedirectService.redirect("/questions");
                },
                function(err) {
                    MessageService.sendMessage('question.created.error');
                    RedirectService.redirect("/questions");
                });
        }
    }

    UpdateQuestionController.$inject =  ['$routeParams', 'MessageService', 'Question', 'RedirectService', 'Subject'];
    function UpdateQuestionController($routeParams, MessageService, Question, RedirectService, Subject) {
        var vm = this;
        
        vm.questionModel = Question.get({id: $routeParams.id}, function(data){
            vm.question = data.question;
            vm.subjectInput = [];
            for(var i = 0; i < data.subjects.length; i++)
                vm.subjectInput.push({text: data.subjects[i].name});
        });

        Subject.query({}, function(data){
            vm.subjectsTags = [];
            vm.subjects = data;
            for(var i = 0; i < data.length; i++)
                vm.subjectsTags.push(data[i].name);
        });

        vm.updateQuestion = updateQuestion;

        function updateQuestion() {
            vm.questionModel.question = vm.question

            vm.question.subjects = [];
            for(var i = 0; i < vm.subjectInput.length; i++)
            {
                var subjectName = vm.subjectInput[i].text;
                for(var j = 0; j < vm.subjects.length; j++)
                    if(vm.subjects[j].name == subjectName)
                        vm.question.subjects.push(vm.subjects[j].id);
            }

            vm.questionModel.$update(function() {
                    MessageService.sendMessage('question.updated.sucess');
                    RedirectService.redirect("/questions");
                },
                function() {
                    MessageService.sendMessage('question.deleted.error');
                    RedirectService.redirect("/questions");
            });
        }
    }
})();
