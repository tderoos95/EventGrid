class TestSubscriber extends EventGridSubscriber;

const TestTopic = "TestTopic";

function ProcessEvent(string Topic, JsonObject EventData)
{
    local string Data;

    log("ProcessEvent: " $ Topic);

    if(Topic ~= TestTopic)
    {

        log("Received test topic");
        Data = EventData.GetValue("TestKey");
        log("Received event data: " $ Data);
    }
}

defaultproperties
{
    SubscriptionTopics[0] = TestTopic
}