(function() {

    'use strict';

    angular
        .module(APP_NAME)
        .controller('SubjectsController', SubjectsController);

    SubjectsController
        .$inject = [
            '$location',
            '$routeParams',
            '$route',
            'Subject',
            'MessageService',
            'RedirectService',
            'ModalService',
            'Modal',
            'TagInputUtils'
        ];

    function SubjectsController($location, $routeParams, $route, Subject, MessageService, RedirectService, ModalService, Modal, TagInputUtils) {
        var vm = this;
        vm.createSubject = createSubject;
        vm.updateSubject = updateSubject;
        vm.deleteSubject = deleteSubject;
        vm.c_delete      = c_delete;
        vm.addField      = addField;

        vm.subjects = [];

        if (!($routeParams.id === undefined)) {
            vm.subject = Subject.get({
                id: $routeParams.id
            });

        } else {
            vm.subject = new Subject();
            Subject.query(function(data) {
                vm.subjects = data;
            });
        }

        function addField() {
            if(vm.fields === undefined) {
                vm.fields = new Array();
            }
            if(vm.fieldsInput === undefined) {
                vm.fieldsInput = new Array();
            }
            if(TagInputUtils.isInArray(vm.fieldsInput, vm.field.name)) {
                for(var i in vm.fields)
                    if(vm.fields[i].name === vm.field.name)
                        vm.fields.splice(i, 1);
                var fieldUpdate = {name: "", description: ""};
                fieldUpdate.name = vm.field.name;
                fieldUpdate.description = vm.field.description;
                vm.fields.push(fieldUpdate);
                
            } else {
                vm.fields.push({name: vm.field.name, description: vm.field.description});
                vm.fieldsInput.push({text: vm.field.name});
                vm.field.name        = "";
                vm.field.description = "";
            }
            $("#FieldModal").modal('hide');
        }

        function createSubject() {
            vm.subject.$save(function() {
                    MessageService.sendMessage("Created!", "Subject was created with success!", "success");
                    RedirectService.redirect("/subjects");
                },
                function(err) {
                    MessageService.sendMessage("Fail!", "Subject was NOT created with success!", "error");
                    RedirectService.redirect("/subjects");
                });
        };

        function updateSubject() {
            vm.subject.$update(function() {
                    MessageService.sendMessage("Updated!", "Subject was updated with success!", "success");
                    RedirectService.redirect("/subjects");

                },
                function(err) {
                    MessageService.sendMessage("Fail!", "Subject was NOT updated with success!", "error");
                    RedirectService.redirect("/subjects");
                });
        }

        function deleteSubject(id) {

            Subject.validateDestroy({id: id}, function(data) {
                if(data.model_bind) {
                    var modal = new Modal();
                    modal.title = 'Confirmation';
                    modal.body = "Deleting this Subject will delete all questions associated with it. Want to continue?\n"
                                  + "Questions related: " + data.count;
                    modal.pack = id;
                    modal.confirmCallback = c_delete;
                    ModalService.alert(modal);
                } else {
                    var modal = new Modal();
                    modal.title = "Confirmation";
                    modal.body = "Are you sure you want to delete?";
                    modal.confirmCallback = c_delete;
                    modal.pack = id;
                    ModalService.alert(modal);
                }
            });
        }

        function c_delete(id) {
            Subject.destroy({
                    id: id
                }, function() {
                    MessageService.sendMessage("Deleted!", "Subject was deleted with success!", "success");
                    RedirectService.redirect("/subjects");
                },
                function(err) {
                    MessageService.sendMessage("Fail!", "Subject was NOT deleted with success!", "error");
                    RedirectService.redirect("/subjects");
                });
        }
    };

})();
