class MutTestSubscription extends Mutator;

var EventBus EventBus;

function PostBeginPlay()
{
    Super.PostBeginPlay();
    SpawnTestSubscriber();
}

function SpawnTestSubscriber()
{
    local TestSubscriber TestSubscriber;

    TestSubscriber = Spawn(class'TestSubscriber');
    EventBus = TestSubscriber.GetOrCreateEventBus();
    
    log("Spawned TestSubscriber", 'EventBusTest');
    log("Found EventBus:" $ eval(EventBus != None, "Yes", "No"), 'EventBusTest');

}

function Mutate(string Command, PlayerController PC)
{
    local string FloodAmount;
    local int FloodAmountInt;
    local int i;

    if(Command ~= "TestSubscription")
    {
        TestSubscription();
    }
    else if(StartsWith(Command, "FloodTestSubscription"))
    {
        FloodAmount = Mid(Command, Len("FloodTestSubscription") + 1);
        FloodAmountInt = Int(FloodAmount);

        if(FloodAmountInt <= 0)
        {
            PC.ClientMessage("Flood amount must be greater than 0");
            return;
        }

        PC.ClientMessage("Flooding test subscription with " $ FloodAmount $ " events");

        for(i = 0; i < FloodAmountInt; i++)
            TestSubscription();
        
        PC.CLientMessage("Flooded TestSubscription " $ FloodAmount $ " times");
    }
    
    if(NextMutator != None)
        NextMutator.Mutate(Command, PC);
}

function TestSubscription()
{
    local JsonObject Json;

    Json = new class'JsonObject';
    Json.AddString("MyTopic", "Hello World");
    EventBus.SendEvent("TestTopic", Json);
}

function bool StartsWith(string Text, string Prefix)
{
    return Left(Text, Len(Prefix)) ~= Prefix;
}

defaultproperties
{
     FriendlyName="**Event Grid - Test Mutator"
}