class MutTestSubscription extends Mutator;

var EventGrid EventGrid;

function PostBeginPlay()
{
    Super.PostBeginPlay();
    SpawnTestSubscriber();
}

function SpawnTestSubscriber()
{
    local TestSubscriber TS;

    TS = Spawn(class'TestSubscriber');
    log("SPAWNED TestSubscriber");
}

function EventGrid FindEventGrid()
{
    local EventGrid MyEventGrid;
    
    foreach AllActors(class'EventGrid', MyEventGrid)
        return MyEventGrid;

    return None;
}

function Mutate(string Command, PlayerController PC)
{
    local JsonObject Json;
    local bool bFound;

    if(Command ~= "TestSubscription")
    {
        EventGrid = FindEventGrid();
        bFound = EventGrid != None;
        log("MutTestSubscription: found EventGrid:" $ eval(bFound, "True", "False"));

        Json = new class'JsonObject';
        Json.AddString("TestKey", "TestValue");
        EventGrid.SendEvent("TestTopic", Json);
    }
    
    if(NextMutator != None)
        NextMutator.Mutate(Command, PC);
}

defaultproperties
{
     FriendlyName="Event Grid - Test Mutator"
}