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
    
    foreach AllActors(class'EventGrid', EventGrid)
    {
        EventGrid.Subscribe(self);
        break;
    }
}

function ProcessEvent(string Topic, JsonObject EventData)
{
}