import "phoenix_html";
import {Socket} from "phoenix";

if (window.userToken) {
  let socket = new Socket("/socket", {params: {token: window.userToken}});

  socket.connect()
  let channel = socket.channel("topic:subtopic", {})
  channel.join()
    .receive("ok", resp => { console.log("Joined successfully", resp) })
    .receive("error", resp => { console.log("Unable to join", resp) })
}
