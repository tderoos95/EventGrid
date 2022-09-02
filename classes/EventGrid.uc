class EventGrid extends Info;

struct SubscriptionPair {
    var string Topic;
    var EventGridSubscriber Subscriber;
};

var array<SubscriptionPair> Subscriptions;

function Subscribe(EventGridSubscriber Subscriber)
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

// todo Publisher class or not?
function SendEvent(string Topic, JsonObject EventData)
{
    local int i;

    for (i = 0; i < Subscriptions.length; i++)
    {
        if (StartsWith(Topic, Subscriptions[i].Topic))
            Subscriptions[i].Subscriber.ProcessEvent(Topic, EventData);
    }
}

function bool StartsWith(string Text, string Prefix)
{
    return Left(Text, Len(Prefix)) ~= Prefix;
}