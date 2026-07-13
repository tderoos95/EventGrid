class EventBus extends Info;

struct SubscriptionPair {
    var string Topic;
    var EventBusSubscriber Subscriber;
};

var array<SubscriptionPair> Subscriptions;

function Subscribe(EventBusSubscriber Subscriber)
{
    local int i, NewIndex;

    for(i = 0; i < Subscriber.SubscriptionTopics.length; i++)
    {
        NewIndex = Subscriptions.length;

        Subscriptions.length = NewIndex + 1;
        Subscriptions[NewIndex].Topic = Subscriber.SubscriptionTopics[i];
        Subscriptions[NewIndex].Subscriber = Subscriber;
    }
}

function Unsubscribe(EventBusSubscriber Subscriber)
{
    local int i;

    // Remove this subscriber's entries (and any that went None) so SendEvent never hits a destroyed one.
    for(i = Subscriptions.length - 1; i >= 0; i--)
    {
        if(Subscriptions[i].Subscriber == Subscriber || Subscriptions[i].Subscriber == None)
            Subscriptions.Remove(i, 1);
    }
}

function SendEvent(string Topic, JsonObject EventData)
{
    local int i;

    for (i = 0; i < Subscriptions.length; i++)
    {
        if (Subscriptions[i].Subscriber == None)
            continue;

        if (StartsWith(Topic, Subscriptions[i].Topic))
            Subscriptions[i].Subscriber.ProcessEvent(Topic, EventData);
    }
}

function bool StartsWith(string Text, string Prefix)
{
    return Left(Text, Len(Prefix)) ~= Prefix;
}