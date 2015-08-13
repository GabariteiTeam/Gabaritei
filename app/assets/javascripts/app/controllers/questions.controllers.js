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

    NewQuestionController.$inject = ['$routeParams', 'MessageService', 'Question'];

    function NewQuestionController($routeParams, MessageService, Question) {
        var vm = this;
        vm.question = new Question();
        vm.createQuestion = createQuestion;
        function createQuestion() {
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

    UpdateQuestionController.$inject =  ['$routeParams', 'MessageService', 'Question', 'RedirectService']

    function UpdateQuestionController($routeParams, MessageService, Question, RedirectService) {
        var vm = this;
        vm.question = Question.get({id: $routeParams.id})
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