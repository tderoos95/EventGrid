class EventGridSubscriber extends Info;

var array<string> SubscriptionTopics;

function PostBeginPlay()
{
    Super.PostBeginPlay();
    RegisterSelf();
} 

function RegisterSelf()
{
    local EventGrid EventGrid;
    local bool bFound;
    
    foreach AllActors(class'EventGrid', EventGrid)
    {
        EventGrid.Subscribe(self);
        bFound = true;
        break;
    }

    if(!bFound)
    {
        log("EventGrid not found, creating one");
        EventGrid = Spawn(class'EventGrid');
        Eventgrid.Subscribe(self);
    }
}

function ProcessEvent(string Topic, JsonObject EventData)
{
}