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

    DataImport.$inject = ['$resource', 'Upload'];

    function DataImport($resource, Upload) {
        var di = $resource('data_imports/:id.json', {id: '@id'}, {
                import: {
                    method: 'PUT',
                    url: 'data_imports/:id/import'
                },
                update: {
                    method: 'PUT',
                    transformRequest: sanitizeUpdateRequest
                }
        });
        di.prototype.upload = function(success, error) {
            Upload.upload({
                    url: '/data_imports',
                    data: {
                        data: this.file,
                        model: this.model,
                        role_id: this.model == 0 ? this.role : null
                    }
                })
                .success(function(data) {
                    if (success) success(data);
                })
                .error(function(data) {
                    if (error) error(data);
                });
        };
        return di;
    }

    function sanitizeUpdateRequest(data) {
        var permittedParameters = {
            id: data.id,
            model: data.model,
            role_id: data.model == 0 ? data.role.id : null
        };
        return angular.toJson(permittedParameters);
    }

})();
