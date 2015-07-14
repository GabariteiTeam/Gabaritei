module.exports = function(config){
  config.set({

    basePath : '../',

    plugins : [
            'karma-chrome-launcher',
            'karma-firefox-launcher',
            'karma-phantomjs-launcher',
            'karma-jasmine',
            'karma-nested-reporter',
            'karma-coverage',
            'karma-htmlfile-reporter',
            'karma-spec-reporter'
            ],
      reporters: ['nested', 'coverage', 'spec'],
      
    
    coverageReporter: {
      type : 'html',
      dir : 'coverage/'
    },

    preprocessors: {
      'app/assets/javascripts/gabaritei-*': ['coverage']
    },

    files : [
      'vendor/assets/bower_components/angular/angular.js',
      'vendor/assets/bower_components/angular-route/angular-route.js',
      'vendor/assets/bower_components/angular-resource/angular-resource.js',
      'vendor/assets/bower_components/angular-mocks/angular-mocks.js',
      'app/assets/javascripts/gabaritei-*',
      'test-angular/unit/**/*.js'
    ],


    autoWatch : false,
    singleRun : true,

    frameworks: ['jasmine'],

    browsers : ['PhantomJS'],

    junitReporter : {
      outputFile: 'test_out/unit.xml',
      suite: 'unit'
    }

  });
};