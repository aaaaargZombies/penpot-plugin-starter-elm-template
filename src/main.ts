import "./style.css";
import { Elm } from "./Main.elm";

const app = Elm.Main.init({
  node: document.getElementById("app"),
});

if (app?.ports?.toPlugin?.subscribe) {
  app.ports.toPlugin.subscribe(function (msg) {
    parent.postMessage(msg, "*");
  });
} else {
  throw new Error("Missing port from Elm");
}

window.addEventListener("message", (event) => {
  if (app?.ports?.fromPlugin?.send) {
    app.ports.fromPlugin.send(event.data);
  } else {
    throw new Error("Missing port into Elm");
  }
});
