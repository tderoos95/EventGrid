class TestSubscriber extends EventGridSubscriber;

const TestTopic = "MyTopic";

function ProcessEvent(string Topic, JsonObject EventData)
{
    log("ProcessEvent: " $ Topic);

    if(Topic ~= TestTopic)
    {

        log("Received test topic");
        log("Received event data: " $ EventData.ToString());
    }
}

defaultproperties
{
    // Unfortunately it is not possible to use constants here.
    // For example: if you have "const TestTopic = "MyTopic" and assign
    // it to SubscriptionTopics, the string "TestTopic" is added, instead
    // of the value inside the constant.
    SubscriptionTopics(0)="MyTopic"
}