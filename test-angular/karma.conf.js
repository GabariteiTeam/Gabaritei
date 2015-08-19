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
            'karma-spec-reporter',
            'karma-ng-html2js-preprocessor'
            ],
      reporters: ['nested', 'coverage', 'spec'],
      
    
    coverageReporter: {
      type : 'html',
      dir : 'coverage/'
    },

    preprocessors: {
      'app/assets/javascripts/app/**/*.js': ['coverage'],
      'public/templates/**/*.html': ['ng-html2js']
    },

    ngHtml2JsPreprocessor: {
      // strip this from the file path
      stripPrefix: 'public/',
      moduleName: 'htmltemplates'
    },

    files : [
      'vendor/assets/bower_components/angular/angular.js',
      'vendor/assets/bower_components/angular-route/angular-route.js',
      'vendor/assets/bower_components/angular-resource/angular-resource.js',
      'vendor/assets/bower_components/angular-mocks/angular-mocks.js',
      'vendor/assets/bower_components/angular-animate/angular-animate.js',
      'vendor/assets/bower_components/angular-strap/dist/angular-strap.js',
      'vendor/assets/bower_components/ng-file-upload/ng-file-upload.js',
      'vendor/assets/bower_components/ng-tags-input/ng-tags-input.js',
      'app/assets/javascripts/app/**/*.js',
      'test-angular/unit/**/*.js',
      'public/templates/**/*.html',

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