(function() {

    angular
        .module(APP_NAME)
        .factory('Content', Content);

    Content.$inject = ['$http', '$resource', 'Upload'];

    function Content($http, $resource, Upload) {
        var di = $resource('contents/:id.json', {id: '@id'});
        di.prototype.upload = function(success, error) {
            Upload.upload({
                    url: '/contents',
                    data: {
                    	name: this.name,
                    	description: this.description,
                        media: this.media
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

})();