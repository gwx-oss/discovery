let SpecReporter = require('jasmine-spec-reporter').SpecReporter;
var HtmlReporter = require('protractor-beautiful-reporter');

exports.config = {
  //seleniumAddress: 'http://localhost:4444/wd/hub',
  	directConnect: true,
	
    multiCapabilities : [
       {'browserName' : 'chrome'
       }
    ],
    
    params: {
    	url : 'https://discovery.gsa.gov',
    	    //'https://discovery-dev.app.cloud.gov',
    },
    
	specs: 
	        //['../landing-page/landing-page.e2e.js'],		   
        	//['../about-page/about-page.e2e.js'],
        	//['../contracts-page/contracts-page.e2e.js'],
	        ['../advanced-search-page/advanced-search-page.e2e.js'],
	        //['../vendors-page/vendors-page.e2e.js'],
	
	
	suites:{
	     regression: ['../landing-page/landing-page.e2e.js', '../about-page/about-page.e2e.js', '../contracts-page/contracts-page.e2e.js', 
	    	 '../advanced-search-page/advanced-search-page.e2e.js', '../vendors-page/vendors-page.e2e.js']
	},

	  
	//chromeDriver: '../node_modules/protractor/node_modules/webdriver-manager/selenium/chromedriver.exe',
	  
	onPrepare: function () {
	    browser.driver.manage().window().maximize();
	    jasmine.getEnv().addReporter(new SpecReporter({
	        displayFailuresSummary: true,
	        displayFailuredSpec: true,
	        displaySuiteNumber: true,
	        displaySpecDuration: true,
	        showstack: false
	      }));
	      // Add a screenshot reporter and store screenshots to `/tmp/screenshots`:
	     jasmine.getEnv().addReporter(new HtmlReporter({
	        baseDirectory: '../report/screenshots',
	        preserveDirectory: false,
	        screenshotsSubfolder: 'images',
	        jsonsSubfolder: 'jsons',
	        docName: 'Discovery-Report.html'
	     }).getJasmine2Reporter());
	  
	},
	    
	jasmineNodeOpts: {
	   showColors: true, 
	   defaultTimeoutInterval: 30000,    
	   print: function() {}	        
	}
	
	
};