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
        var di = $resource('data_imports/:id.json', null, {
                import: {
                    method: 'PUT',
                    url: 'data_imports/:id/import'
            }
        });
        di.prototype.upload = function(success, error) {
            Upload.upload({
                    url: 'data_imports',
                    fields: {
                        col_sep: this.file.type == 'text/csv' ? this.col_sep : null,
                        model: this.model,
                        role_id: this.model == 0 ? this.role : null
                    },
                    file: this.file,
                    fileFormDataName: 'data'
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

})();
