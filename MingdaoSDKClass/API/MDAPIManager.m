//
//  MDAPIManager.m
//  Mingdao
//
//  Created by Wee Tom on 13-4-26.
//
//

#import "MDAPIManager.h"

// Notification
NSString * const MDAPIManagerNewTokenSetNotification = @"MDAPIManagerNewTokenSetNotification";

// API
NSString * const MDAPILogin = @"/oauth2/access_token";

@interface MDAPIManager ()
@property (strong, nonatomic) NSString *appKey, *appSecret;
@end

@implementation MDAPIManager
static MDAPIManager *sharedManager = nil;
+ (MDAPIManager *)sharedManager
{
    @synchronized(self)
    {
        if  (!sharedManager)
        {
            sharedManager = [[MDAPIManager alloc] init];
        }
    }
    return sharedManager;
}

+ (void)setServerAddress:(NSString *)serverAddress
{
    [[self sharedManager] setServerAddress:serverAddress];
}

+ (void)setAppKey:(NSString *)appKey
{
    [[self sharedManager] setAppKey:appKey];
}

+ (void)setAppSecret:(NSString *)appSecret
{
    [[self sharedManager] setAppSecret:appSecret];
}

- (NSString *)serverAddress
{
    if (!_serverAddress) {
        _serverAddress = MDAPIDefaultServerAddress;
        return _serverAddress;
    }
    return _serverAddress;
}

- (void)setAccessToken:(NSString *)accessToken
{
    if (![_accessToken isEqualToString:accessToken]) {
        _accessToken = accessToken;
        [[NSNotificationCenter defaultCenter] postNotificationName:MDAPIManagerNewTokenSetNotification object:accessToken userInfo:nil];
    }
}

- (void)handleBoolData:(NSDictionary *)dic error:(NSError *)error URLString:(NSString *)urlString handler:(MDAPIBoolHandler)handler
{
    if (error) {
        handler(NO, error);
        return ;
    }
    
    if ([[dic objectForKey:@"count"] boolValue]) {
        handler(YES, error);
    } else {
        handler(NO, error);
    }
}

- (NSString *)localEncode:(NSString *)string
{
    NSMutableString *passwordTmp = [string mutableCopy];
    {
        [passwordTmp replaceOccurrencesOfString:@"%" withString:@"%25" options:NSLiteralSearch range:NSMakeRange(0, [passwordTmp length])];
        [passwordTmp replaceOccurrencesOfString:@"&" withString:@"%26" options:NSLiteralSearch range:NSMakeRange(0, [passwordTmp length])];
        [passwordTmp replaceOccurrencesOfString:@"(" withString:@"%28" options:NSLiteralSearch range:NSMakeRange(0, [passwordTmp length])];
        [passwordTmp replaceOccurrencesOfString:@")" withString:@"%29" options:NSLiteralSearch range:NSMakeRange(0, [passwordTmp length])];
        [passwordTmp replaceOccurrencesOfString:@"?" withString:@"%3F" options:NSLiteralSearch range:NSMakeRange(0, [passwordTmp length])];
        [passwordTmp replaceOccurrencesOfString:@"\"" withString:@"%22" options:NSLiteralSearch range:NSMakeRange(0, [passwordTmp length])];
        [passwordTmp replaceOccurrencesOfString:@"+" withString:@"%2B" options:NSLiteralSearch range:NSMakeRange(0, [passwordTmp length])];
        [passwordTmp replaceOccurrencesOfString:@"," withString:@"%2C" options:NSLiteralSearch range:NSMakeRange(0, [passwordTmp length])];
        [passwordTmp replaceOccurrencesOfString:@"/" withString:@"%2F" options:NSLiteralSearch range:NSMakeRange(0, [passwordTmp length])];
        [passwordTmp replaceOccurrencesOfString:@":" withString:@"%3A" options:NSLiteralSearch range:NSMakeRange(0, [passwordTmp length])];
        [passwordTmp replaceOccurrencesOfString:@";" withString:@"%3B" options:NSLiteralSearch range:NSMakeRange(0, [passwordTmp length])];
        [passwordTmp replaceOccurrencesOfString:@"=" withString:@"%3D" options:NSLiteralSearch range:NSMakeRange(0, [passwordTmp length])];
        [passwordTmp replaceOccurrencesOfString:@"@" withString:@"%40" options:NSLiteralSearch range:NSMakeRange(0, [passwordTmp length])];
        [passwordTmp replaceOccurrencesOfString:@" " withString:@"%20" options:NSLiteralSearch range:NSMakeRange(0, [passwordTmp length])];
        [passwordTmp replaceOccurrencesOfString:@"\t" withString:@"%09" options:NSLiteralSearch range:NSMakeRange(0, [passwordTmp length])];
        [passwordTmp replaceOccurrencesOfString:@"#" withString:@"%23" options:NSLiteralSearch range:NSMakeRange(0, [passwordTmp length])];
        [passwordTmp replaceOccurrencesOfString:@"<" withString:@"%3C" options:NSLiteralSearch range:NSMakeRange(0, [passwordTmp length])];
        [passwordTmp replaceOccurrencesOfString:@">" withString:@"%3E" options:NSLiteralSearch range:NSMakeRange(0, [passwordTmp length])];
        [passwordTmp replaceOccurrencesOfString:@"\n" withString:@"%0A" options:NSLiteralSearch range:NSMakeRange(0, [passwordTmp length])];
        [passwordTmp replaceOccurrencesOfString:@"!" withString:@"%21" options:NSLiteralSearch range:NSMakeRange(0, [passwordTmp length])];
        [passwordTmp replaceOccurrencesOfString:@"^" withString:@"%5E" options:NSLiteralSearch range:NSMakeRange(0, [passwordTmp length])];
        [passwordTmp replaceOccurrencesOfString:@"~" withString:@"%7E" options:NSLiteralSearch range:NSMakeRange(0, [passwordTmp length])];
        [passwordTmp replaceOccurrencesOfString:@"`" withString:@"%60" options:NSLiteralSearch range:NSMakeRange(0, [passwordTmp length])];
        [passwordTmp replaceOccurrencesOfString:@"!" withString:@"%21" options:NSLiteralSearch range:NSMakeRange(0, [passwordTmp length])];
        [passwordTmp replaceOccurrencesOfString:@"$" withString:@"%24" options:NSLiteralSearch range:NSMakeRange(0, [passwordTmp length])];
        [passwordTmp replaceOccurrencesOfString:@"." withString:@"%2E" options:NSLiteralSearch range:NSMakeRange(0, [passwordTmp length])];
        [passwordTmp replaceOccurrencesOfString:@"!" withString:@"%21" options:NSLiteralSearch range:NSMakeRange(0, [passwordTmp length])];
        [passwordTmp replaceOccurrencesOfString:@"*" withString:@"%2A" options:NSLiteralSearch range:NSMakeRange(0, [passwordTmp length])];
        [passwordTmp replaceOccurrencesOfString:@"-" withString:@"%2D" options:NSLiteralSearch range:NSMakeRange(0, [passwordTmp length])];
        [passwordTmp replaceOccurrencesOfString:@"[" withString:@"%5B" options:NSLiteralSearch range:NSMakeRange(0, [passwordTmp length])];
        [passwordTmp replaceOccurrencesOfString:@"]" withString:@"%5D" options:NSLiteralSearch range:NSMakeRange(0, [passwordTmp length])];
        [passwordTmp replaceOccurrencesOfString:@"_" withString:@"%5F" options:NSLiteralSearch range:NSMakeRange(0, [passwordTmp length])];
        [passwordTmp replaceOccurrencesOfString:@"{" withString:@"%7B" options:NSLiteralSearch range:NSMakeRange(0, [passwordTmp length])];
        [passwordTmp replaceOccurrencesOfString:@"|" withString:@"%7C" options:NSLiteralSearch range:NSMakeRange(0, [passwordTmp length])];
        [passwordTmp replaceOccurrencesOfString:@"}" withString:@"%7D" options:NSLiteralSearch range:NSMakeRange(0, [passwordTmp length])];
        [passwordTmp replaceOccurrencesOfString:@"\\" withString:@"%5C" options:NSLiteralSearch range:NSMakeRange(0, [passwordTmp length])];
    }
    return passwordTmp;
}

#pragma mark - 登录/验证接口
- (MDURLConnection *)loginWithUsername:(NSString *)username
                              password:(NSString *)password
                               handler:(MDAPINSDictionaryHandler)handler
{
    return [self loginWithServer:[MDAPIManager sharedManager].serverAddress username:username password:password handler:handler];
}

- (MDURLConnection *)loginWithServer:(NSString *)serverAddress
                            username:(NSString *)username
                            password:(NSString *)password
                             handler:(MDAPINSDictionaryHandler)handler
{
    NSMutableArray *parmas = [[NSMutableArray alloc] init];
    [parmas addParamWithObject:@"json" forKey:@"format"];
    [parmas addParamWithObject:self.appKey forKey:@"app_key"];
    [parmas addParamWithObject:self.appSecret forKey:@"app_secret"];
    [parmas addParamWithObject:@"password" forKey:@"grant_type"];
    [parmas addParamWithObject:@"true" forKey:@"account"];
    //生成UserName令牌签名,首先处理用户名和密码中的特殊字符
    [parmas addParamWithObject:[self localEncode:username] forKey:@"username"];
    [parmas addParamWithObject:[self localEncode:password] forKey:@"password"];
    NSURLRequest *req = [NSURLRequest getWithHost:serverAddress api:MDAPILogin parameters:parmas];

    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:req handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        if (error) {
            handler(nil, error);
            return ;
        }
        
        handler(dic, error);
    }];
    return connection;

}

- (MDURLConnection *)refreshTokenWithRefreshToken:(NSString *)refreshToken
                                          handler:(MDAPINSDictionaryHandler)handler;
{
    NSMutableArray *parmas = [[NSMutableArray alloc] init];
    [parmas addParamWithObject:@"json" forKey:@"format"];
    [parmas addParamWithObject:self.appKey forKey:@"app_key"];
    [parmas addParamWithObject:self.appSecret forKey:@"app_secret"];
    [parmas addParamWithObject:@"refresh_token" forKey:@"grant_type"];
    [parmas addParamWithObject:refreshToken forKey:@"refresh_token"];
    NSURLRequest *req = [NSURLRequest getWithHost:self.serverAddress api:MDAPILogin parameters:parmas];
    
    MDURLConnection *connection = [[MDURLConnection alloc] initWithRequest:req handler:^(MDURLConnection *theConnection, NSDictionary *dic, NSError *error) {
        if (error) {
            handler(nil, error);
            return ;
        }
        
        handler(dic, error);
    }];
    return connection;
}
@end
