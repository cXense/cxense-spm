# Cxense SDK for iOS

Cxense SDK is a software development kit designed and developed specifically for iOS platform. It provides set of APIs
that allows using Cxense servers' functionality in mobile application through native APIs.

## Requirements
- iOS 10.0+
- Xcode 13.0
- Swift 5.5

## Installation

### CocoaPods

```ruby
pod 'CxenseSDK', '~>1.9.8'
```

### Swift Package Manager

```swift
let package = Package(
    ...
    dependencies: [
        .package(
            url: "https://github.com/cXense/cxense-spm.git", 
            from: "1.9.8"
        )
    ],
    targets: [
        .target(
            name: "MyApp",
            dependencies: ["CxenseSDK"]
        )
    ]
)
```

## Import

***Swift:***
```swift
import CxenseSDK
```

***Objective-C:***
```objectivec
@import CxenseSDK;
```

## Configuration

Before Cxense SDK can be used in the application it require to be configured. Configuration can be easily provided by creating instance of special class called 'Configuration'. It contains set of methods vital for SDK's execution. It requires two main properties to be set - username and API key.

You can provide them by instantiating `Configuration` class:

***Swift:***
```swift
let config = Configuration(withUserName: "api@user.com", apiKey: "qwerty=12345")
```

***Objective-C:***
```objectivec
CXConfiguration *config = [[CXConfiguration alloc] initWithUserName:@"api@user.com" apiKey:@"qwerty=12345"];
```

*User name and API key can be obtained from \*.cxense.com portal.*

`Configuration` class provides control over other multiple options through which you can modify SDK's behaviour. All available for configuration options are listed below:
- `userName` (required) - Email of the user which has API access.
- `apiKey` (required) - API key of the user with API access.
- `persistentCookie` (default: once generated unique identifier) - Unique identifier to identify and track the user (see below for details).
- `dispatchInterval` (default: 30 sec) - Defines amount of seconds between tries which dispatch loop will perform in attempt to send reported events.
- `outdatedTimeout` (default: 7 days) - Defines amount of seconds during which all dispatched events will be stored in local database after successful sending.
- `networkRestriction` (default: none) - Defines network conditions upon which dispatch loop can send events.
- `dispatchMode` (default: online) - Defines dispatch mode of dispatch loop.
- `userAgent` (default: WKWebView default user agent) - User-Agent string that will be added as http header to each API call.
- `autoMetaInfTrackingEnabled` (default: true) - Shows whether automatic meta-information tracking is enabled or not. Under meta-information following items are meant: **app name**, **app version**, **sdk version**. In case this flag is enabled, all specified parameters will be send as events' custom parameters.
- `dmpPushPersistentId` - Identifier of persistent query which points to "/dmp/push" API. If set, all performance events will be pushed through DMP pixel automatically. They are pushed through "/dmp/push/" API directly by default.
- `consentOptions` - List of options that indicate consent on data processing.

### Persistent cookie
By default, the value for the persistentCookie configuration property is generated once upon initialization of the Cxense SDK. You can also use your ID for users, and for anonymous users use the value 'anonymous', 'default', etc.

> Do not change the Configuration.persistentCookie property after initializing the Cxense SDK, this will have no effect. To change the Configuration.persistentCookie property after initializing the Cxense SDK, use the methods:
> - `Cxense.replacePersistentCookie(persistentCookie: String)` - to change
> - `Cxense.clearPersistentCookie()` - to set the default


## Initialize

***Swift:***
```swift
do {
    try Cxense.initialize(withConfiguration: config)
} catch {
    ...
}
```

***Objective-C:***
```objectivec
NSError *error;

[CXCxense initializeWithConfiguration:config error:&error];

if (error != nil) {
    ...
}
```

>*Pay attention that 'Cxense.initialize' method can throw an error if provided instance contains invalid configuration.*

## Events tracking

Cxense SDK allows tracking events of two types:
- page view
- performance

**Page view** event is collection of data that describes the visit (time and length of visit; previous, current and next page URL; etc) and the visitor (browser, OS, location, IP address, etc). It is also reffered as 'traffic event'.

**Performance event** describes what the user did while visiting the page.

### Event queue

All events are added to the queue and dispatched asynchronously in the background task. Dispatch loop collects all events ready-to-be-send automatically and sends them according to its own schedule. But what if you do not want to be on its schedule? Then the SDK provides special function to do manual dispatch in attempt to force reported events to be send. To do that you can use following function:

***Swift:***
```swift
Cxense.flushEventQueue()
```

***Objective-C:***
```objectivec
[CXCxense flushEventQueue];
```

You can also get the state of the event queue:

***Swift:***
```swift
let status: QueueStatus = Cxense.queueStatus()
```

***Objective-C:***
```objectivec
CXQueueStatus *status = [CXCxense queueStatus];
```

***QueueStatus structure:***
```swift
@objc(CXQueueStatus)
public class QueueStatus: NSObject {

  /// Contains identifiers of events that were successfully sent to the server and was not cleared yet.
  public let sentEvents: Set<String>

  /// Contains identifiers of events that were not sent for certain reason (failure or just dispatch loop did not get them yet).
  public let notSentEvents: Set<String>
}
```

### Page View Events
Page view events are events that mean that some piece of content was shown to the user. For example, some news article was shown to the user. Page view events are aggregated by Cxense Insight. All collected page view events are available for analysis in Insight's web interface.

Use `PageViewEvent` class to track page view events in your application. Instances of the class can be easily created using following `PageViewEventBuilder`:

***Swift:***
```swift
// SiteId - identifier of the site for which current event will be reported
let builder = PageViewEventBuilder.makeBuilder(withName: "ZooScreen", siteId: "1234567890");
```

***Objective-C:***
```objectivec
// SiteId - identifier of the site for which current event will be reported
CXPageViewEventBuilder *builder = [CXPageViewEventBuilder makeBuilderWithName:@"ZooScreen" siteId:@"1234567890"];
```

**Builder functions for setting parameters:**

- `addUserProfileParameter(forKey key: String, withValue value: String)` - Add user profile parameter to the event.
  >*Note: event's user profile parameters keys are prefixed with **cp_u_** string automatically. You do not need to prefix them manually.*

- `addCustomParameter(forKey key: String, withValue value: String)` - Add custom parameter to the event.
  >*Note: event's custom parameters keys are prefixed with **cp_** string automatically. You do not need to prefix them manually.*

- `addExternalUserId(_ id: String, withType userType: String)` - Add external user identifier.
  >*Note: pay attention that you can add only 5 external ids per event.*

- `setLocation(loc: String)` - Set location of the page. Must be a syntactically valid URL, or else the event will be dropped.
  

- `setReferrer(ref: String)` - Set referrer.
  

- `setContentId(cid: String)` - Set identifier of tracked content.
  >*Note: **contentId** & **location** properties are mutually exclusive. Please use either content identifier or page's address.*

**Dispatching a page view event:**

***Swift:***
```swift
do {
    Cxense.reportEvent(try builder.build())
} catch {
    ...
}
```

***Objective-C:***
```objectivec
NSError *error;
CXPageViewEvent *event = [builder build:&error];

if (error != nil) {
...
}

[CXCxense reportEvent:event];
```

### Performance Events

Performance events are events that means that user have performed some action in the application like 'Add item to the cart'. Performance events are aggregated by Cxense DMP and all collected events of that type are available for analysis in DMP's web interface.

Use `PerformanceEvent` class to track performance events in your application. Instances of the class can be easily created using `PerformanceEventBuilder`:

***Swift:***
```swift
let builder = PerformanceEventBuilder.makeBuilder(withName: "UserClickedOnButton#123", type: "click", origin: "xyz-sample", siteId: "1234567890", andUserIds: [DMPUserIdentifier(identifier: "abcdefg12345", type: "xyz")])
```

***Objective-C:***
```objectivec
CXDmpUserIdentifier* userId = [[CXDmpUserIdentifier alloc] initWithIdentifier:@"abcdefg12345" type:@"xyz"];
CXPerformanceEventBuilder* builder = [CXPerformanceEventBuilder makeBuilderWithName:@"UserClickedOnButton#123" type:@"click" origin:@"xyz-sample" siteId:@"1234567890" andUserIds:@[userId]];
```

**Builder functions for setting parameters:**

- `setTime(_ interval: TimeInterval)` - Set exact time of an event.
  

- `setEventId(_ eid: Int)` - Set a value uniquely identifying of event.
  >*Note: pay attention that multiple events on the same screen / page must have distinct **eventId** values.*

- `setPageViewEventId(_ pvId: Int)` - Set a value uniquely identifying of page view event.
  

- `setPrnd(_ pvId: String)` - Set an alternative identifier of associated page view event.
  >*Note: **prnd** value (which is pv event's identifier) can be retrieved from the **rnd** parameter of the pageview event instance.*

- `addSegmentId(_ segmentId: String)` - Add identifier of the segment to event.


- `setSegmentIds(_ ids: [String])` - Set segments identifiers to event.
  >*Note: pay attention that this method will overwrite segment ids that were previously added by **addSegmentId** function.*
  
- `addCustomParameter(_ param: DMPCustomParameter)` - Add custom-parameter to event.
   >*Note: Custom parameters - an optional list of customer-defined parameters. Parameters fed with DMP events follow the same syntactical restrictions and limits as for ordinary custom-parameters for analytics events.*

**Dispatching a performance event:**

***Swift:***
```swift
do {
    Cxense.reportEvent(try builder.build())
} catch {
    ...
}
```

***Objective-C:***
```objectivec
NSError *error;
CXPerformanceEvent *event = [builder build:&error];

if (error != nil) {
...
}

[CXCxense reportEvent:event];
```

### Force send events ###
To dispatch events without adding to the queue, you can use the ```Cxense.forceReportEvent``` method

```swift
Cxense.forceReportEvent(event) { isSent, error in
    ...
}
```

### Track active time

The SDK can track active time for page view events. For example - how long user had read specific article in the application. That can be easily done by using following function with event's name:

***Swift:***
```swift
Cxense.trackActiveTime(forEvent: "MusicBandView")
```

***Objective-C:***
```objectivec
[CXCxense trackActiveTimeForEvent:@"MusicBandView"];
```

## Error handling

To handle errors in the `build` function, you can catch errors with the `IncorrectConfiguration` type:

***Swift:***
```swift
do {
    let event = try builder.build()
} catch {
    switch error {
    case IncorrectConfiguration.valueRequired(let cause):
        ...
    case IncorrectConfiguration.conflictingParameters(let cause, let recommendation):
        ...
    case IncorrectConfiguration.invalidParameter(let cause, let recommendation):
        ...
    case IncorrectConfiguration.freeDiskSpace:
        ...
    default:
        ...
    }
}
```

## Working with DMP

Beside performance events reporting Cxense SDK provides following functionality to the applications:
- access to user's profile
- getting list of segments for the user
- manipulation with user linking

### User profile:

>     userProfile(
>         forUserId: String,
>         identifierType: String,
>         _ groups: [String]? = nil,
>         _ recent: Bool,
>         _ identityTypes: [String]? = nil,
>         _ callback: @escaping (_ user: DMPUser?, _ error: Error?) -> ()
>     )
> 
>Retrieves a suitably authorized slice of a given user's interest profile. The returned profile data will have been gathered from within the network of sites that the client has access to. This includes data from, e.g., custom taxonomies and custom parameters.
>
>*Parameters:*
> - `forUserId`: Identifies the user whose user profile should be returned.
> - `identifierType`: The type of user identifier, i.e., tells us how to interpret id. The value **cx** indicates a Cxense-specific identifier, either an internal cross-site user id returned from an API such as **/traffic/data**, or a site-specific id obtained from **cX.getUserId()** function call from **cx.js**. Customer-specific identifiers via a customer-assigned prefix are also possible.
> - `groups`: A list of strings that specify profile item groups to keep in the returned profile (see below for descriptions of the profile field in the response object). If not specified, all groups available for the user will be returned. Group specifications may enable server-side optimizations on Cxense's side, which can lead to a quicker response.
> - `recent`: Returns quickly if this user has not been seen recently. Cxense stores user profile information in many storage layers, where the most recently seen profiles are the quickest profiles to retrieve. In an interactive session where events are generated (and as a consequence the user profile is updated and considered a fresh profile), it may be more appropriate to return quickly than wait for a complete response on the first page view.
> - `identityTypes`: A set of customer-specific identifier types. If a corresponding customer identifier exists for the user, it will be included in the response.
> - `callback`: function that will be called after retrieving data from the API

### User segment ID's

>     userSegmentIds(
>       forUserIdentifiers: [DMPUserIdentifier],
>       andSiteGroupIds: [String],
>       _ callback: @escaping (_ segments: DMPSegmentsHolder?, _ error: Error?) -> ()
>     )
> 
>Retrieves a list of all segments where the user is a member.
> 
>***Important**: This function behaves differently according to consent options given. If user consent is required, but **segment** option was not given function will return an empty segments list.*
>
>*Parameters:*
> - `forUserIdentifiers`: A list of user identifiers to consult if multiple identities are available.
> - `andSiteGroupIds`: The list of site groups to retrieve segments for.
> - `callback`: function that will be called after retrieving data from the API

### Other functions

```swift
userExternalData(
   withIdentifierType: String,
   andUserId: String? = nil,
   _ callback: @escaping (_ response: [DMPUserData]?, _ error: Error?) -> ()
)

deleteUserExternal(
   withIdentifierType: String,
   andUserId: String,
   _ callback: @escaping (_ error: Error?) -> ()
)

userExternalLink(
   forCxenseId: String,
   identifierType: String,
   _ callback: @escaping (_ userIdentifier: DMPUserIdentifier?, _ error: Error?) -> ()
)

updateUserExternalData(
   forUserId: String,
   identifierType: String,
   profiles: [DMPExternalProfile],
   _ callback: @escaping (_ error: Error?) -> ()
)

setUserExternalLink(
    forUserId: String,
    identifierType: String,
    cxenseId: String,
    _ callback: @escaping (_ userIdentifier: DMPUserIdentifier?, _ error: Error?) -> ()
)
```

## Using personalized content

You can retrieve personalised content recommendations from Cxense Content.

### Create content context

***Swift:***
```swift
let context = ContentContext()

context.url = ...
context.pageclass = ...
context.sentiment = ...
context.recommending = ...
context.categories = ...
context.parameters = ...
context.keywords = ...
context.neighbors = ...
context.referrer = ...
```

***Objective-C:***
```objectivec
CXContentContext *context = [CXContentContext new];

context.url = ...
context.pageclass = ...
context.sentiment = ...
context.recommending = ...
context.categories = ...
context.parameters = ...
context.keywords = ...
context.neighbors = ...
context.referrer = ...
```

### Initialize content widget

***Swift:***
```swift
let widget = Cxense.makeWidget(id: "abcd1234", context: context)
```

***Objective-C:***
```objectivec
CXContentWidget *widget = [CXCxense makeWidgetWithId:@"abcd1234" context:context user:nil];
```

### Get content recommendations

***Swift:***
```swift
widget.fetchItems { (recommendations, error) in
    if let e = error {
        ...
    }
    ...
}
```

***Objective-C:***
```objectivec
[widget fetchItemsWithCallback:^(NSArray<CXContentRecommendation *> * _Nullable recommendations, NSError * _Nullable error) {
    if (error != nil) {
        ...
    }
    ...
}];
```

***ContentRecommendation structure:***
```swift
public class ContentRecommendation {
    public let url: String
    public let clickUrl: String
    public let title: String
    public let data: [String: Any]?
    public let dominantthumbnail: String?
}
```

### Track item click

***Swift:***
```swift
let rec: ContentRecommendation = ...
widget.trackClick(for: rec)
```

***Objective-C:***
```objectivec
CXContentRecommendation *rec = ...;
[widget trackClickFor:rec];
```

## Using persisted queries

Cxense SDK provides support of [Persisted Queries](https://wiki.cxense.com/display/cust/Persisted+Query+Tutorial)

> This feature rely heavily on Swift generics and some underlying mechanisms that are not compatible with Objective C. Hence to that the only option to use Persisted Query API in Objective C project is to convert it to mixed project by developing own Swift wrapper for the API. See following article if you want to find more information on mixed projects: [Using Swift with Cocoa and Objective-C](https://developer.apple.com/library/content/documentation/Swift/Conceptual/BuildingCocoaApps/MixandMatch.html)

>     executePersistedQuery<T: Decodable>(
>         for: String,
>         andPersisted: String,
>         callback:((_ response: T?, _ error: Error?)->())?
>     )
> 
>Execute persisted query.
>
>*Parameters*:
> - `for`: Back end API service. List of all methods can be found here: https://wiki.cxense.com/display/cust/Cxense+API+Methods
> - `andPersisted`: Identifier of persisted query configured on the back end
> - `callback`: Callback closure. Will be invoked as the result of API call


>     executePersistedQuery<T: Encodable, V: Decodable>(
>         for: String,
>         andPersisted: String,
>         with: T,
>         callback:((_ response: V?, _ error: Error?)->())?
>     )
> 
>Execute persisted query with data.
>
>*Parameters*:
> - `for`: Back end API service. List of all methods can be found here: https://wiki.cxense.com/display/cust/Cxense+API+Methods
> - `andPersisted`: Identifier of persisted query configured on the back end
> - `with`: Data for sending to back end service
> - `callback`: Callback closure. Will be invoked as the result of API call
 
## Consent API

GDPR (General Data Protection Regulation, taken into account in EU) requires any operations with user data to be explicitly mentioned and have explicit user consent. For that purpose, the SDK provides special consent API to make easy setting end user consent for data processing.

***Consent options:***
```swift
config.consentOptions = [.consentRequired, .pvAllowed]
```

***ConsentOptions structure:***
```swift
@objc(CXConsentOption)
public enum ConsentOptions: Int {
  /// Required, set if this event was obtained and may only be processed with the user's consent
  case consentRequired

  /// Page view tracking, DMP event tracking and browsing habit collection to understand a user’s interests and profile
  case pvAllowed

  /// Personalisation of content recommendations and suggested content based on user interests and browsing habits
  case recsAllowed

  ///  Audience segmentation, processing of browsing habits and first party data to include users in specific audience segments
  case segmentAllowed

  /// Targeting advertising based on browsing habits and audience segmentation
  case adAllowed

  /// Allowed usage of user-agent and other device-specific data.
  case deviceAllowed
  
  /// Allowed usage of geolocation with page view events
  case geoAllowed
}
```

> Pay attention that if given consent options may affect not only data processing on backend, but also affect SDK's functionality. For example, for applications where user consent is required (.consentRequired option given) following effects are possible:
> - `.pvAllowed`: Controls events reporting. If not given - then no events will be reported.
> - `.segmentAllowed`: Controls segments retrieval. If not given - then empty list of segments will be returned instead of actual.

***Consent version (default: v1):***
```swift
config.consentVersion = ConsentVersion.v2
```

***ConsentVersion structure:***
```swift
@objc(CXConsentVersion)
public enum ConsentVersion: Int {
    case v1
    case v2
}
```