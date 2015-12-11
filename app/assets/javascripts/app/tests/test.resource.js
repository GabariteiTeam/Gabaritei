(function() {

    angular
        .module(APP_NAME)
        .factory('Test', Test);

    Test.$inject = ['$resource'];

    function Test($resource) {
        return $resource('tests/:id.json', {id: '@id'}, {
            update: {
                method: 'PUT'
            },
            searchQuestions: {
                url: 'tests/:id/search_questions',
                method: 'GET',
                isArray: true
            },
            addQuestions: {
                url: 'tests/:id/add_questions',
                method: 'PUT'
            },
            removeQuestion: {
                url: 'tests/:id/remove_question/:question_id',
                method: 'PUT'
            },
            submitResponses: {
                method: 'POST', 
                url: 'tests/:id/submit/responses' 
            },
            getSummary: {
                method: 'GET',
                url: 'tests/:id/summary'
            }
        });
    }

})();
