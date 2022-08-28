class EventGridSubscriber extends Info;

var array<string> SubscriptionTopics;
var EventGrid EventGrid;

function PostBeginPlay()
{
    Super.PostBeginPlay();
    RegisterSelf();
} 

function RegisterSelf()
{
    EventGrid = GetOrCreateEventGrid();
    Eventgrid.Subscribe(self);
}

function EventGrid GetOrCreateEventGrid()
{
    local bool bFound;

    if(EventGrid != None)
        return EventGrid;
    
    foreach AllActors(class'EventGrid', EventGrid)
    {
        bFound = true;
        break;
    }
    
    if(!bFound)
    {
        log("EventGrid not found, creating one");
        EventGrid = Spawn(class'EventGrid');
    }
    
    return EventGrid;
}

function ProcessEvent(string Topic, JsonObject EventData)
{
}