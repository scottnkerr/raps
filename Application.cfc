<cfcomponent extends="framework">
	<cfscript>
		//set up datasource
		this.datasource="raps";
		
		//set up the session
		this.name = 'raps_0.2';
		this.sessionmanagement = true;
		this.sessiontimeout = createTimeSpan(0,3,0,0);
		
		variables.framework = structNew();
		variables.framework.base = '/app';
//		variables.framework.defaultSection = 'default';
	//	variables.framework.defaultItem = 'login';
		variables.framework.reload = 'fwreinit';
		variables.framework.variables.password = 'true';
		variables.framework.suppressImplicitService = true;
		// set this to true to cache the results of fileExists for performance:
		variables.framework.cacheFileExists = false;
		variables.framework.action = 'event';
		//false for production
		variables.framework.reloadApplicationOnEveryRequest = true;
		variables.framework.maxNumContextsPreserved = 1;
			
	function setupSession() {
		controller( 'security.session' );
	}

	function setupRequest() {
		controller( 'security.authorize' );
	}
	</cfscript>

</cfcomponent>

