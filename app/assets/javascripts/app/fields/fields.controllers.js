/* global APP_NAME */
(function() {

    'use strict';

    angular
        .module(APP_NAME)
        .controller('FieldsController', FieldsController)
        .controller('FieldsCreateController', FieldsCreateController)
        .controller('FieldsUpdateController', FieldsUpdateController);

    FieldsController
        .$inject = [
            '$location',
            '$routeParams',
            '$route',
			'Field',
            'Subject',
            'Modal',
            'ModalService',
            'RedirectService',
            'MessageService'
        ];

    function FieldsController($location, $routeParams, $route, Field, Subject, Modal, ModalService, RedirectService, MessageService) {
       var vm = this;
       vm.subject_id    = $routeParams.id;
       vm.confirmDelete = confirmDelete;
       vm.confirmed_delete = confirmed_delete;
       vm.fields        = Field.get({id: vm.subject_id});
       vm.subject       = Subject.get({id: vm.subject_id});
       
       function confirmDelete(id) {
            var modal               = new Modal();
            modal.title             = "Confirmation";
            modal.body              = "Are you sure you want to delete?";
            modal.confirmCallback   = confirmed_delete;
            modal.pack              = id;
            ModalService.alert(modal);
       }
       
       function confirmed_delete(id) {
           var field    = new Field();
           field.id     = id;
           Field.destroy({id:id}, function(data){
               MessageService.sendMessage("Deleted!", "Field was deleted with success!", "success");
               RedirectService.redirect("/fields/" + vm.subject_id);
           }, function(err){
               MessageService.sendMessage("Fail!", "Field was NOT deleted with success!", "error");
               RedirectService.redirect("/fields/" + vm.subject_id);
           })
       }
              
    };
    
    FieldsCreateController
        .$inject = [
            '$location',
            '$routeParams',
            '$route',
            'Field',
            'Subject',
            'MessageService',
            'RedirectService'
        ];
    
    function FieldsCreateController($location, $routeParams, $route, Field, Subject, MessageService, RedirectService) {
        var vm          = this;
        vm.field        = new Field();
        vm.subject_id   = $routeParams.subject_id;
        vm.createField  = createField;
        
        function createField() {
            vm.field.subject_id = vm.subject_id;
            vm.field.$save({}, function(data){
                MessageService.sendMessage("Created!", "Field was created with success!", "success");
                RedirectService.redirect("/fields/" + vm.subject_id);
            }, function(err) {
                MessageService.sendMessage("Fail!", "Field was NOT created with success!", "error");
                RedirectService.redirect("/fields/" + vm.subject_id);
            })
        }
        
    };
    
    FieldsUpdateController
        .$inject = [
            '$location',
            '$routeParams',
            '$route',
            'Field',
            'Subject',
            'MessageService',
            'RedirectService'
        ];
     
     function FieldsUpdateController($location, $routeParams, $route, Field, Subject, MessageService, RedirectService) {
        var vm          = this;
        vm.subject_id   = $routeParams.subject_id;
        vm.field        = Field.query({id: $routeParams.id});
        vm.updateField  = updateField;
        
        function updateField() {
            vm.field.$update({}, function(data){
                MessageService.sendMessage("Edited!", "Field was Edited with success!", "success");
                RedirectService.redirect("/fields/" + vm.subject_id);
            }, function(err){
                MessageService.sendMessage("Edited!", "Field was NOT Edited with success!", "error");
                RedirectService.redirect("/fields/" + vm.subject_id);
            });
        }
    };

})();
