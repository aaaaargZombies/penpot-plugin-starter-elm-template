type MsgToPlugin =
  | { kind: "Change" }
  | { kind: "Ready" }
  | { kind: "State"; content: number };

type MsgFromPlugin = { kind: "Status" };

const unreachable = (_: never) => {
  throw new Error("This should be unreachable");
};

console.log("Hello from the plugin!");

penpot.ui.open("Penpot plugin starter Elm template", "");

const sendMessage = (msg: MsgFromPlugin) => {
  penpot.ui.sendMessage(msg);
};

const update = (msg: MsgToPlugin): void => {
  switch (msg.kind) {
    case "Ready":
      console.log("Interface Ready!");
      break;

    case "Change":
      console.log("The model has changed.");
      sendMessage({ kind: "Status" });
      break;

    case "State":
      console.log("The model is now: ", msg.content);
      break;

    default:
      unreachable(msg);
      break;
  }
};

penpot.ui.onMessage(update);
