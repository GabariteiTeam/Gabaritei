// We place here all the controllers

(function() {

    'use strict';

    //-----------------------------------------//
    //  Controllers declaration                //
    //-----------------------------------------//

    angular
        .module(APP_NAME)
        .controller('HomeController', HomeController)
        .controller('MessageController', MessageController)
        .controller('SubjectController', SubjectController)
        .controller('DataImportController', DataImportController);

    //-----------------------------------------//
    //  HomeController                         //
    //-----------------------------------------//

    HomeController.$inject = ['MessageService'];

    function HomeController(MessageService) {
    
    };

    //-----------------------------------------//
    //  MessageController                      //
    //-----------------------------------------//

    MessageController.$inject = ['$interval', '$alert', 'Message', 'MessageService'];

    function MessageController($interval, $alert, Message, MessageService) {
        var vm = this;
        vm.receiveMessage = receiveMessage;
        vm.message = new Message();

        function receiveMessage(message) {
            vm.message = message;
            vm.alert = $alert({container: "#messageContainer", duration: 5, title: vm.message.title, content: vm.message.content, placement: 'top', type: vm.message.type, show: true});
        }

        MessageService.addObserver(vm.receiveMessage);
    }

    //-----------------------------------------//
    //  SubjectController                      //
    //-----------------------------------------//

    SubjectController.$inject =['$location', '$routeParams', '$route', 'Subject', 'MessageService', 'RedirectService'];

    function SubjectController($location, $routeParams, $route, Subject, MessageService, RedirectService) {
        var vm = this;
        vm.createSubject = createSubject;
        vm.updateSubject = updateSubject;
        vm.deleteSubject = deleteSubject;

        vm.subjects = [];
        vm.subject = new Subject();

        if (!($routeParams.id === undefined)) {
            vm.subject = Subject.get({
                id: $routeParams.id
            });

        } else {
            Subject.query(function(data) {
                vm.subjects = data;
            });
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
            Subject.destroy({id: id}, function() {
                MessageService.sendMessage("Deleted!", "Subject was deleted with success!", "success");
                RedirectService.redirect("/subjects");
            },
            function(err) {
                MessageService.sendMessage("Fail!", "Subject was NOT deleted with success!", "error");
                RedirectService.redirect("/subjects");
            });
        }
    };

    //-----------------------------------------//
    //  DataImportController                   //
    //-----------------------------------------//

    DataImportController.$inject = ['$timeout', 'DataImport'];
    
    function DataImportController($timeout, DataImport) {
    
        var vm = this;
        var pollingPeriod = 3000;

        vm.refresh = refresh;
        vm.uploadFile = uploadFile;
        vm.importData = importData;
        vm.deleteFile = deleteFile;
        vm.selectFile = selectFile;
        vm.show_file_parameters = false;
        vm.data_imports = [];
        vm.models = [];
        vm.data_import = {};
    
        DataImport.models(function (data) {
            vm.models = data;
            vm.data_import = {model: "0"}
        });
       
        refresh();
        
        function refresh() {
            DataImport.query(function (data) {
                vm.data_imports = data;
                var statusProduct = 1;
                for (var i = 0; i < data.length; i++) statusProduct *= data[i].status;
                if (statusProduct == 0) $timeout(refresh, pollingPeriod);
            });
        }

        function uploadFile() {
            if (vm.data_import.file && vm.data_import.file.length && vm.data_import.model) {
                DataImport.upload(vm.data_import, function (data) {
                    refresh();
                });
            }
        };

        function importData (data_import_id) {
            DataImport.update({id: data_import_id}, {id: data_import_id}, function (data) {
                refresh();
            });
        };

        function deleteFile (data_import_id) {
            DataImport.delete({id: data_import_id}, function (data) {
                refresh();
            });
        };

        function selectFile () {
            vm.show_file_parameters = true;
        }

    }

})();


// var homeControllers = angular.module('homeControllers', [])
// homeControllers.controller('homeController', ['$scope','MessageService',
//     function($scope, MessageService) {
      
//     }
// ]);

// app.controller('messageController', ['$scope', '$interval', '$alert','Message', 'MessageService', function($scope, $interval, $alert, Message, MessageService) {
//     $scope.message = new Message();

//     $scope.receiveMessage = function(message) {
//         $scope.message = message;
//         $scope.alert = $alert({container: "#messageContainer", duration: 5, title: $scope.message.title, content: $scope.message.content, placement: 'top', type: $scope.message.type, show: true});
//     }

//     MessageService.addObserver($scope.receiveMessage);
// }]);

// var subjectControllers = angular.module('subjectControllers', [])
// subjectControllers.controller('subjectController', ['$scope', '$location', '$routeParams', '$route', 'Subject', 'MessageService', 'RedirectService',
//     function($scope, $location, $routeParams, $route, Subject, MessageService, RedirectService) {
//         $scope.subjects = [];
//         $scope.subject = new Subject();

//         if (!($routeParams.id === undefined)) {
//             $scope.subject = Subject.get({
//                 id: $routeParams.id
//             });

//         } else {
//             Subject.query(function(data) {
//                 $scope.subjects = data;
//             });
//         } 

//         $scope.createSubject = function() {
//             $scope.subject.$save(function() {
//                     MessageService.sendMessage("Created!", "Subject was created with success!", "success");
//                     RedirectService.redirect("/subjects");
//                 },
//                 function(err) {
//                     MessageService.sendMessage("Fail!", "Subject was NOT created with success!", "error");
//                     RedirectService.redirect("/subjects");
//                 });
//         };

//         $scope.updateSubject = function() {
//             $scope.subject.$update(function() {
//                     MessageService.sendMessage("Updated!", "Subject was updated with success!", "success");
//                  RedirectService.redirect("/subjects");
                    
//                 },
//                 function(err) {
//                     MessageService.sendMessage("Fail!", "Subject was NOT updated with success!", "error");
//                     RedirectService.redirect("/subjects");
//                 });
//         }

//         $scope.deleteSubject = function(id) {
            
//             Subject.destroy({id: id}, function() {
//                     MessageService.sendMessage("Deleted!", "Subject was deleted with success!", "success");
//                  RedirectService.redirect("/subjects");
//                 },
//                 function(err) {
//                     MessageService.sendMessage("Fail!", "Subject was NOT deleted with success!", "error");
//                     RedirectService.redirect("/subjects");
//                 });
//         }
//     }
// ]);

