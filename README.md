# EventBus — UT2004

An in-process publish/subscribe event bus for UnrealScript on **Unreal Tournament 2004**. Pure
script, no native code.

A UT99 / OldUnreal 469 port lives at [eventbus-ut99](https://github.com/Tunnelcast/eventbus-ut99).

> Previously named `EventGrid`. It is a bus, not a grid — and the old name collided with Azure Event
> Grid. The UnrealScript package is now `EventBus`; mods still compiled against `EventGrid.u` need
> that package present at load until they are rebuilt.

Use it to decouple parts of a mod that would otherwise have to know about each other: something
publishes an event on a topic, and whoever cares subscribes to it. Nothing needs a direct reference
to anything else.

## What you get

Publish:

```unrealscript
local JsonObject Json;

Json = new class'JsonObject';
Json.AddString("PlayerName", "Cali");

EventBus.SendEvent("v1/player/connected", Json);
```

Subscribe — extend `EventBusSubscriber`, declare your topics, override `ProcessEvent`:

```unrealscript
class MySubscriber extends EventBusSubscriber;

function ProcessEvent(string Topic, JsonObject EventData)
{
    log(Topic @ EventData.GetString("PlayerName"));
}

defaultproperties
{
    SubscriptionTopics(0)="v1/player/"    // prefix: matches connected, disconnected, chat, ...
}
```

Spawn it and it registers itself; destroy it and it unsubscribes. `GetOrCreateEventBus()` finds the
bus (or creates it), so subscribers do not have to be wired up in any particular order.

**Topic matching is by case-insensitive prefix**, not exact match: subscribing to `"v1/player/"`
receives `"v1/player/chat"`. Subscribing to `""` receives everything.

## Install

Depends on [JsonLib](https://github.com/Tunnelcast/jsonlib-ut2004) for the event payload. List both
**before** your own package:

```ini
[Editor.EditorEngine]
EditPackages=JsonLib
EditPackages=EventBus
EditPackages=YourMod
```

The bus and its subscribers are `Info` actors — server-side only, so they do not need to go in
`ServerPackages`.

## Licence

MIT. Provided as-is, no support guarantee.
