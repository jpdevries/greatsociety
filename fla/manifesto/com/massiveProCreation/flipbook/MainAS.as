﻿package com.massiveProCreation.flipbook
	import flash.system.*;
			
			Security.loadPolicyFile('http://greatsociety.s3.amazonaws.com/crossdomain.xml');
			Security.allowDomain('http://greatsociety.com');
			Security.allowDomain('http://c0654.paas1.tx.modxcloud.com');
			Security.allowDomain('http://c0650.paas2.tx.modxcloud.com');
			Security.allowDomain('http://tgs.greatsociety.modxcloud.com');			
			Security.allowDomain('http://greatsociety.s3.amazonaws.com');			
			
			// call constructor of super class		