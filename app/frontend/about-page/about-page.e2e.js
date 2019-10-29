describe('About Page', function() {
	
	var baseURL = browser.params.url; 

	var aboutLink = element(by.xpath('//span[text()="About"]'));
	var aboutTitle = element(by.css('.usa-hero-callout-alt'));
	var aboutText = element(by.css('.usa-section-dark>p'));
	var howToUseDiscovery = element(by.css('.usa-grid .usa-width-two-thirds'));
	var dataSources = element(by.css('.usa-grid .usa-width-one-third'));
	var discoveryLogo = element(by.css('.discovery-logo'));
	var discoveryLogoText = element(by.css('.discovery-logo >a >strong'));
	var homeLink = element(by.xpath('//span[text()="Home"]'));
	var advancedSearchLink = element(by.xpath('//span[text()="Advanced Search"]'));
	var aboutLink = element(by.xpath('//span[text()="About"]'));
	var contractsLink = element(by.xpath('//span[text()="Contracts"]'));
	var needHelpFooter = element(by.xpath('//h3[text()="Need Help?"]'));
	var discoveryFooter = element(by.xpath('//h3[text()="Discovery"]'));
	var GSAtoolsFooter = element(by.xpath('//h3[text()="Other GSA Tools"]'));
	var opinionMatterFooter = element(by.xpath('//h3[text()="Your Opinion Matters!"]'));
	
	describe('Discovery About Page', function(){
		
		 beforeAll(function() {
			 browser.get(baseURL);
			 browser.sleep(3000);
	     });
		 
		 it('should navigate to About Page @smoke', function(){
			 aboutLink.click();
			 expect(discoveryLogo.isDisplayed()).toBe(true);
			 expect(discoveryLogoText.getText()).toEqual('DISCOVERY');
			 expect(homeLink.isDisplayed()).toBe(true);
			 expect(advancedSearchLink.isDisplayed()).toBe(true);
			 expect(aboutLink.isDisplayed()).toBe(true);
			 expect(contractsLink.isDisplayed()).toBe(true);	 
		 });
		 
		 it('should display text on About Page @smoke', function(){		
			 expect(aboutTitle.isDisplayed()).toBe(true);
			 expect(aboutTitle.getText()).toEqual('About us');
			 expect(aboutText.isDisplayed()).toBe(true);
			 expect(aboutText.getText()).toEqual('Discovery is a market research tool for GSA Contract Vehicles.');
			 expect(howToUseDiscovery.isDisplayed()).toBe(true);
			 expect(dataSources.isDisplayed()).toBe(true);	
		 });
		 
		 it('should display footer on Discovery Landing Page', function(){
			 expect(needHelpFooter.isDisplayed()).toBe(true);
			 expect(discoveryFooter.isDisplayed()).toBe(true);
			 expect(GSAtoolsFooter.isDisplayed()).toBe(true);
			 expect(opinionMatterFooter.isDisplayed()).toBe(true);
		 });
		 
	});
	

});