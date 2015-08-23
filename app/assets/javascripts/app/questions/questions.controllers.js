(function(){
    'use strict';

    angular
        .module(APP_NAME)
        .controller('QuestionsController', QuestionsController)
        .controller('NewQuestionController', NewQuestionController)
        .controller('UpdateQuestionController', UpdateQuestionController);

    QuestionsController.$inject = ['$routeParams', 'MessageService', 'Question', 'RedirectService'];

    function QuestionsController($routeParams, MessageService, Question, RedirectService) {
        var vm = this;
        vm.deleteQuestion = deleteQuestion;
        vm.questions = Question.query();

        function deleteQuestion(id) {
            Question.destroy({id: id}, function(){
                MessageService.sendMessage("Deleted!", "Question was deleted with success!", "success");
                RedirectService.redirect("/questions");
            },
            function(err){
                MessageService.sendMessage("Fail!", "Question was NOT deleted with success!", "error");
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
            for(var i = 0; i < vm.subjectInput.length; i++)
            {
                var subjectName = vm.subjectInput[i].text;
                for(var j = 0; j < vm.subjects.length; j++)
                    if(vm.subjects[j].name == subjectName)
                        vm.question.subjects.push(vm.subjects[j].id);
            }

            vm.question.$save(function(){
                MessageService.sendMessage("Created!", "Question was created with success!", "success");

                RedirectService.redirect("/questions");
            },
            function(err){
                MessageService.sendMessage("Fail!", "Question was NOT created with success!", "error");
                RedirectService.redirect("/questions");
            });
        }
    }

    UpdateQuestionController.$inject =  ['$routeParams', 'MessageService', 'Question', 'RedirectService', 'Subject']

    function UpdateQuestionController($routeParams, MessageService, Question, RedirectService, Subject) {
        var vm = this;
        
        Question.get({id: $routeParams.id}, function(data){
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

        function updateQuestion () {
            vm.question.$update(function(){
                MessageService.sendMessage("Updated!", "Question was updated with success!", "success");
                RedirectService.redirect("/questions");
            },
            function(){
                MessageService.sendMessage("Fail!", "Question was NOT updated with success!", "success");
                RedirectService.redirect("/questions");
            });
        }
    }
})();