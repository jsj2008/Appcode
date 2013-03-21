/*
	AUVServices.m
	Creates a list of the services available with the AUV prefix.
	Generated by SudzC.com
*/
#import "AUVServices.h"

@implementation AUVServices

@synthesize logging, server, defaultServer;

@synthesize webservice;


#pragma mark Initialization

-(id)initWithServer:(NSString*)serverName{
	if(self = [self init]) {
		self.server = serverName;
	}
	return self;
}

+(AUVServices*)service{
	return (AUVServices*)[[AUVServices alloc] init];
}

+(AUVServices*)serviceWithServer:(NSString*)serverName{
	return (AUVServices*)[[AUVServices alloc] initWithServer:serverName];
}

#pragma mark Methods

-(void)setLogging:(BOOL)value{
	logging = value;
	[self updateServices];
}

-(void)setServer:(NSString*)value{
	//[server release];
	//server = [value retain];
	[self updateServices];
}

-(void)updateServices{

	[self updateService: self.webservice];
}

-(void)updateService:(SoapService*)service{
	service.logging = self.logging;
	if(self.server == nil || self.server.length < 1) { return; }
	service.serviceUrl = [service.serviceUrl stringByReplacingOccurrencesOfString:defaultServer withString:self.server];
}

#pragma mark Getter Overrides


-(AUVwebservice*)webservice{
	if(webservice == nil) {
		webservice = [[AUVwebservice alloc] init];
	}
	return webservice;
}


@end
			