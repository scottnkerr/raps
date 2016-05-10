<cfcomponent><cfscript>

	function init( fw ) {
		variables.fw = fw;
	}

	function session( rc ) {
		// set up the user's session
		session.auth = {};
		session.auth.isLoggedIn = false;
		session.auth.fullname = 'Guest';
	}
	
	function authorize( rc ) {
		// check to make sure the user is logged on
		if (isdefined("session.auth.isLoggedIn")) {
			//writeDump(variables.fw.getFullyQualifiedAction());
			//abort;
			if ( not session.auth.isLoggedIn and 
					not listfindnocase( 'login', variables.fw.getSection() ) and
					not listfindnocase( 'pushapp', variables.fw.getFullyQualifiedAction() ) and
					not listfindnocase( 'main.purgeProposals', variables.fw.getFullyQualifiedAction() ) and
					not listfindnocase( 'main.error', variables.fw.getFullyQualifiedAction() ) ) {
				variables.fw.redirect('login');
			}
		}
		else {
			session.auth.isLoggedIn = false;
			if (not listfindnocase( 'login', variables.fw.getSection() )) {
			variables.fw.redirect('login');
			}
		}
	}

</cfscript></cfcomponent>