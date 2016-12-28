var crosstalk = require("./crosstalk");

function EventCounter() {
  this.count = 0;
  var self = this;
  this.handler = function() {
    self.count++;
  };
}


var evts = new crosstalk.Events();

var counter = new EventCounter();
evts.on("click", counter.handler);

evts.trigger("click");

if (counter.count !== 1) {
  throw new Error("Unexpected click count");
}


var a = crosstalk.var("a");
var a1 = crosstalk.var("a");
if (a !== a1) {
  throw new Error("crosstalk.var('a') didn't return consistent object");
}

a.on("change", counter.handler);
a.on("change", function(e) {
  if (e.extraInfo !== "yes") {
    throw new Error("Extra info wasn't found");
  }
});
a.set("foo", {extraInfo: "yes"});

if (counter.count !== 2) {
  throw new Error("Unexpected click count 2");
}
if (a.get() !== "foo") {
  throw new Error("Unexpected value of a");
}

a.set("foo");
if (counter.count !== 2) {
  throw new Error("Click count changed when no-op set was performed");
}

var success = false;
try {
  crosstalk.var(null);
  success = true;
} catch(e) {
}
if (success) {
  console.error("Didn't expect var(null) to succeed");
}

var selCounter = new EventCounter();
var selGroup = crosstalk.group("selection_tests");
var sel = selGroup.var("selection");
sel.on("change", selCounter.handler);

if (typeof(sel.get()) !== "undefined") {
  throw new Error("Unexpected default value for selection");
}

crosstalk.selection.add(selGroup, null);
crosstalk.selection.add(selGroup, []);
if (typeof(sel.get()) !== "undefined") {
  throw new Error("selection.add didn't no-op");
}

crosstalk.selection.add(selGroup, ["one"]);
if (sel.get().toString() !== ["one"].toString()) {
  throw new Error("selection.add: " + sel.get().toString());
}
crosstalk.selection.add(selGroup, ["one", "two"]);
if (sel.get().toString() !== ["one", "two"].toString()) {
  throw new Error("selection.add 2: " + sel.get().toString());
}

crosstalk.selection.remove(selGroup, ["one"]);
if (sel.get().toString() !== ["two"].toString()) {
  throw new Error("selection.remove: " + sel.get().toString());
}
crosstalk.selection.remove(selGroup, ["one", "two"]);
if (sel.get().toString() !== [].toString()) {
  throw new Error("selection.remove 2: " + sel.get().toString());
}
crosstalk.selection.remove(selGroup, null);
crosstalk.selection.remove(selGroup, []);
if (sel.get().toString() !== [].toString()) {
  throw new Error("selection.remove no-op: " + sel.get().toString());
}

sel.set(["one", "one", "two", "three", "four", "four"]);
crosstalk.selection.toggle(selGroup, ["four", "five", "five"]);
if (sel.get().toString() !== ["one", "one", "two", "three", "five"].toString()) {
  throw new Error("selection.toggle: " + sel.get().toString());
}
if (selCounter.count !== 6) {
  throw new Error("Unexpected selection change count: " + selCounter.count);
}
