class TestSubscriber extends EventGridSubscriber;

const TestTopic = "TestTopic";

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
    SubscriptionTopics[0] = TestTopic
}