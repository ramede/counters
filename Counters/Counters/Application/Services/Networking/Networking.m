
#import "Networking.h"

// MARK: - Base URL
NSString *const baseURL = @"http://127.0.0.1:3000";

// MARK: - Error
NSErrorDomain const CountersErrorDomain = @"counters.network.error.domain";

// MARK: - Headers
NSString * const ContentType = @"Content-Type";
NSString * const JSONContentType = @"application/json";

// MARK: - Handlers
typedef void (^DataCompletionHandler) (NSData * _Nullable data, NSError * _Nullable error);

@interface Networking ()
@property (nonatomic, strong) NSURLSession *client;
@end

@implementation Networking

- (instancetype)init
{
    self = [super init];
    if (self) {
        __auto_type *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        _client = [NSURLSession sessionWithConfiguration:configuration];
    }
    return self;
}

- (NSString *)getBaseURL {
    return baseURL;
}

- (NSURLSessionTask *)jsonRequestURL:(NSURL *)url
                          HTTPMethod:(NSString *)method
                          parameters:(NSDictionary<NSString*, NSString*>* _Nullable)parameters
                   completionHandler:(JSONCompletionHandler)completion
{
    return [self dataRequestURL:url HTTPMethod:method parameters:parameters completionHandler:^(NSData *data, NSError *error) {
        if (error) {
            completion(nil, error);
            return;
        }
        id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        if (error) {
            completion(nil, error);
            return;
        }
        completion(object, nil);
    }];
}

- (NSURLSessionTask *)dataRequestURL:(NSURL *)url
                      HTTPMethod:(NSString *)method
                      parameters:(NSDictionary<NSString*, NSString*>* _Nullable)parameters
               completionHandler:(DataCompletionHandler)completion
{
//    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://127.0.0.1:3000/api/v1/counters"]];
//
//    //create the Method "GET"
//    [urlRequest setHTTPMethod:@"GET"];
//
//    NSURLSession *session = [NSURLSession sharedSession];
//
//    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
//    {
//      NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
//      if(httpResponse.statusCode == 200)
//      {
//        NSError *parseError = nil;
//        NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
//        NSLog(@"The response is - %@",responseDictionary);
//      }
//      else
//      {
//        NSLog(@"Error");
//      }
//    }];
//
//    return dataTask;

    NSLog(@"Value of url = %@", url);
    __auto_type *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = method;

    NSLog(@"Dict is null = %d", parameters == NULL);
    if (parameters != NULL) {
        NSData *JSONData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
        if (JSONData) {
            request.HTTPBody = JSONData;
            [request setValue:JSONContentType forHTTPHeaderField:ContentType];
        }
    }
    return [self.client dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            completion(data, error);
        } else if (!data) {
            completion(nil, [self error:CountersErrorCodeNoData]);
        } else {
            completion(data, nil);
        }
    }];
}


- (NSError *)error:(CountersErrorCode)code
{
    return [NSError errorWithDomain:CountersErrorDomain
                               code:code
                           userInfo:nil];
}

@end
