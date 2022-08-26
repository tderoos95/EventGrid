class EventGrid extends Info;

struct SubscriptionPair {
    var string Topic;
    var EventGridSubscriber Subscriber;
};

var array<SubscriptionPair> Subscriptions;

function Subscribe(EventGridSubscriber Subscriber)
{
    local int i, NewIndex;
    
    log("Subscribe " $ Subscriber.SubscriptionTopics.Length $ " topics");

    for(i = 0; i < Subscriber.SubscriptionTopics.length; i++)
    {
        NewIndex = Subscriptions.length;

        Subscriptions.length = NewIndex + 1;
        Subscriptions[NewIndex].Topic = Subscriber.SubscriptionTopics[i];
        Subscriptions[NewIndex].Subscriber = Subscriber;
    }

    log("Subscribed " $ Subscriptions.length $ " topics");	
}

function Push(array<SubscriptionPair> Subscriptions, SubscriptionPair Pair)
{
    local int NewIndex;

    log("Subscribing event grid to " $ Pair.Topic);

    
    Subscriptions[NewIndex] = Pair;
}

// todo Publisher class or not?
function SendEvent(string Topic, JsonObject EventData)
{
    local int i;

    log("SendEvent: " $ Topic);

    for (i = 0; i < Subscriptions.length; i++)
    {
        log("Subscriber: " $ Subscriptions[i].Topic);
        log("Compare to: " $ Topic);

        if (Subscriptions[i].Topic == Topic)
            Subscriptions[i].Subscriber.ProcessEvent(Topic, EventData);
    }
}