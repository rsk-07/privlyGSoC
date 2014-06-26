/**
 * @fileOverview execute.js Runs the currently defined Jasmine tests.
 **/
 
// (function() {
  
//   var jasmineEnv = jasmine.getEnv();
//   jasmineEnv.updateInterval = 2500;
//   var consoleReporter = new jasmine.ConsoleReporter();
//   jasmineEnv.addReporter(consoleReporter);
//   jasmineEnv.execute();
  
// })();


(function() {
      var jasmineEnv = jasmine.getEnv();
      jasmineEnv.updateInterval = 1000;

      window.htmlReporter = new jasmine.HtmlReporter();

      jasmineEnv.addReporter(htmlReporter);

      jasmineEnv.specFilter = function(spec) {
        return htmlReporter.specFilter(spec);
      };

      window.consoleReporter = new jasmine.ConsoleReporter();

      jasmineEnv.addReporter(consoleReporter);

      var currentWindowOnload = window.onload;

      window.onload = function() {
        if (currentWindowOnload) {
          currentWindowOnload();
        }
        execJasmine();
      };

      function execJasmine() {
        jasmineEnv.execute();
      }

})();