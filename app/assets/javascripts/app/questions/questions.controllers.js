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
        vm.c_delete = c_delete;
        vm.questions = Question.query();
        vm.delete_modal_id = 'confirmDeleteQuestion';


        function c_delete(id) {
            Question.destroy({
                    id: id
                }, function() {
                    MessageService.sendMessage("question.deleted.success");
                    RedirectService.redirect("/questions");
                },
                function(err) {
                    MessageService.sendMessage('question.deleted.error');
                    RedirectService.redirect("/questions");
            });
        }
    }

    NewQuestionController.$inject = ['$routeParams', 'MessageService', 'Question', 'RedirectService', 'Subject', 'lodash'];

    function NewQuestionController($routeParams, MessageService, Question, RedirectService, Subject, lodash) {
        var vm = this;
        vm.question = new Question();
        vm.createQuestion = createQuestion;
        vm.addField = addField;
        vm.removeField = removeField;
        vm.multiple_choices = {
        };

        vm.options =  {
            validation: {
                enabled: false,
                showMessages: false
            },
            layout: {
                type: 'horizontal',
                labelSize: 3,
                inputSize: 9
            },
        };

        vm.standardAlternativeField = {
                            label:'', 
                            property: 'alternativeText', 
                            type: 'text', 
                            attr: {class: 'form-control', 
                            // Well, could be better, but.. Lack of time to think of something...
                            placeholder:"{{'crud.questions.form.alternatives.placeholder' | translate}}"},
                    };
        vm.schemaProperty = 'alternativeText';
        vm.schema = [];
        Subject.query({}, function(data){
            vm.subjectsTags = [];
            vm.subjects = data;
            for(var i = 0; i < data.length; i++)
                vm.subjectsTags.push(data[i].name);
        });

        function removeField() {
            if(vm.schema.length > 1) {
                vm.schema.pop();
            }
        }
        function assemblyProperty() {
            return vm.schemaProperty + (vm.schema.length - 1);
        }
        function addField() {
            var propertyName = assemblyProperty();
            if(!lodash.isEmpty(vm.multiple_choices[propertyName]) || vm.schema.length == 0) {
                    var alternative = {label:'', property: ('alternativeText' + vm.schema.length ), type: 'text', attr: {class: 'form-control', placeholder:'Alternative for your question'}};
                    vm.schema.push(alternative);
            }
        }
        vm.addField();

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
            vm.question.choices = [];
            for(var key in vm.multiple_choices) {
                if (!lodash.isEmpty(vm.multiple_choices[key]))
                    vm.question.choices.push(vm.multiple_choices[key]);
            }
            if(vm.question.style == "choice") {
                vm.question.answer = vm.keyAnswer;
            }
            vm.question.$save({'subjects[]': vm.question.subjects, 'choices[]': vm.question.choices},function(){
                MessageService.sendMessage('question.created.success');
                    RedirectService.redirect("/questions");
                },
                function(err) {
                    MessageService.sendMessage('question.created.error');
                    RedirectService.redirect("/questions");
                });
        }
    }

    UpdateQuestionController.$inject =  ['$routeParams', 'MessageService', 'Question', 'RedirectService', 'Subject', 'lodash'];
    function UpdateQuestionController($routeParams, MessageService, Question, RedirectService, Subject, lodash) {
        var vm = this;
        vm.schema = [];
        vm.multiple_choices = {
        };
        vm.schemaProperty = 'alternativeText';
        vm.removeField = removeField;
        vm.addField = addField;
        vm.keyAnswer = 1;
        
        vm.questionModel = Question.show({id: $routeParams.id}, function(data){
            vm.question = data.question;
            vm.subjectInput = [];
            for(var i = 0; i < data.subjects.length; i++)
                vm.subjectInput.push({text: data.subjects[i].name});
            for(var i = 0; i < data.choices.length; i++) {
                vm.multiple_choices[vm.schemaProperty + i] = data.choices[i].text;
                vm.schema.push({
                            label:'', 
                            property: 'alternativeText' + i, 
                            type: 'text', 
                            attr: {class: 'form-control', 
                            // Well, could be better, but.. Lack of time to think of something...
                            placeholder:"{{'crud.questions.form.alternatives.placeholder' | translate}}"},
                    })
            }
            if(vm.schema.length == 0)
                addField();
            if(vm.question.style == "choice") {
                vm.keyAnswer = vm.question.answer;
            }
        });

        function removeField() {
            if(vm.schema.length > 1) {
                var name = assemblyProperty();
                vm.schema.pop();
                vm.multiple_choices[name] = undefined;
            }
        }
        function assemblyProperty() {
            return vm.schemaProperty + (vm.schema.length - 1);
        }
        function addField() {
            var propertyName = assemblyProperty();
            if(!lodash.isEmpty(vm.multiple_choices[propertyName]) || vm.schema.length == 0) {
                    var alternative = {label:'', property: ('alternativeText' + vm.schema.length ), type: 'text', attr: {class: 'form-control', placeholder:'Alternative for your question'}};
                    vm.schema.push(alternative);
            }
        }

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
            vm.choices = [];
            for(var key in vm.multiple_choices) {
                if (!lodash.isEmpty(vm.multiple_choices[key]))
                    vm.choices.push(vm.multiple_choices[key]);
            }
            if(vm.question.style == "choice") {
                vm.question.answer = vm.keyAnswer;
            }
            vm.questionModel.$update({"choices[]": vm.choices, "key": vm.keyAnswer}, function() {
                    MessageService.sendMessage('question.updated.success');
                    RedirectService.redirect("/questions");
                },
                function() {
                    MessageService.sendMessage('question.updated.error');
                    RedirectService.redirect("/questions");
            });
        }
    }
})();
