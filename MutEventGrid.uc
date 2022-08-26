class MutEventGrid extends Mutator;

var EventGrid EventGrid;

function PreBeginPlay()
{
    EventGrid = Spawn(class'EventGrid');
    log("Spawned EventGrid");
    Super.PreBeginPlay();
}

defaultproperties
{
     FriendlyName="Event Grid"
}