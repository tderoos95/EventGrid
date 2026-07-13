class EventBusSubscriber extends Info;

var array<string> SubscriptionTopics;
var EventBus EventBus;

function PostBeginPlay()
{
    Super.PostBeginPlay();
    RegisterSelf();
} 

function RegisterSelf()
{
    EventBus = GetOrCreateEventBus();
    EventBus.Subscribe(self);
}

function EventBus GetOrCreateEventBus()
{
    local bool bFound;

    if(EventBus != None)
        return EventBus;
    
    foreach AllActors(class'EventBus', EventBus)
    {
        bFound = true;
        break;
    }
    
    if(!bFound)
    {
        log("EventBus not found, creating one");
        EventBus = Spawn(class'EventBus');
    }
    
    return EventBus;
}

function ProcessEvent(string Topic, JsonObject EventData)
{
}

event Destroyed()
{
    // Drop our subscriptions so a destroyed subscriber is never dispatched to (and doesn't leak entries).
    if(EventBus != None)
        EventBus.Unsubscribe(self);

    Super.Destroyed();
}