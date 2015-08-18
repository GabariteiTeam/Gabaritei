/**
 * @ngdoc service
 * @name gabariteiApp.service:DataImport
 * @description
 *
 * This resource manages the data import page.
 **/

(function() {

    angular
        .module(APP_NAME)
        .factory('DataImport', DataImport);

    DataImport.$inject = ['$http', '$resource', 'Upload'];

    function DataImport($http, $resource, Upload) {
        var di = $resource('/data_imports/:id.json', null, {
            import: {
                method: 'PUT',
                url: '/data_imports/:id/import'
            }
        });
        di.upload = function(params, success, error) {
            Upload.upload({
                    url: '/data_imports',
                    fields: params,
                    file: params.file,
                    fileFormDataName: 'data'
                })
                .progress(function(evt) {

                })
                .success(function(data) {
                    if (success) success(data);
                })
                .error(function(data) {
                    if (error) error(data);
                });
        };
        di.models = function(success, error) {
            $http.get('/data_imports/models.json')
                .success(function(data) {
                    if (success) success(data);
                })
                .error(function(data) {
                    if (error) error(data);
                });
        };
        return di;
    }

})();
