//
//  ZindRouteModel.m
//  Zind
//
//  Created by lzackx on 2021/3/24.
//


#import "ZindRouteModel.h"


const NSString * _Nonnull const ZindDefaultRouteModelString = @""
"{"
"	\"url\": \"\","
"	\"parameters\": {"
"		\"public\": {"
"			\"router_type\": 0,"
"			\"app\": \"\","
"			\"environment\": 0,"
"			\"muid\": \"\","
"			\"platform\": \"\","
"			\"safearea_top\": 0,"
"			\"safearea_bottom\": 0,"
"			\"version\": \"\","
"			\"system_version\": \"\","
"			\"ua\": \"\""
"		},"
"		\"private\": {}"
"	}"
"}";


@implementation ZindRouteModel
@end

@implementation ZindParameters
@end

@implementation ZindPublic
+ (NSDictionary *)modelCustomPropertyMapper {
	return @{
		@"routerType": @"router_type",
		@"safeareaTop": @"safearea_top",
		@"safeareaBottom": @"safearea_bottom",
		@"systemVersion": @"system_version",
	};
}
@end

