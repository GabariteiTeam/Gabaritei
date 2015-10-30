(function() {

    angular
        .module(APP_NAME)
        .factory('Content', Content);

    Content.$inject = ['$http', '$resource', 'Upload'];

    function Content($http, $resource, Upload) {
        var ctnt = $resource('contents/:id.json', {id: '@id'});
        ctnt.prototype.$save = function(success, error) {
            upload(this, '/contents/', 'POST', success, error);
        }
        ctnt.prototype.$update = function (success, error) {
            upload(this, '/contents/' + this.id, 'PUT', success, error);
        }
        function upload(content, url, method, success, error) {
            if (content.medium.is_attachment == 'true') {
                content.medium.reference = "";
            } else {
                content.medium.data = null;
            }
            Upload.upload({
                url: url,
                method: method,
                data: {
                    name: content.name,
                    description: content.description,
                    shareable: content.shareable,
                    category_id: content.field_id ? content.field_id : content.subject_id,
                    category_type: content.field_id ? "Field" : "Subject",
                    medium: content.medium
                }
            })
            .success(function(data) {
                if (success) success(data);
            })
            .error(function(data) {
                if (error) error(data);
            });
        };
        return ctnt;
    }

})();