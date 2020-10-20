const express = require("express"); // express
const app = express(); // app
const PORT = process.env.PORT || 8080;

app.get("*",(req,res) => {
    let now =new Date(Date.now());
    res.send(`Hello. It's currently ${now}`);
})

app.listen(PORT, function() {
    console.log(`🌎  ==> API Server now listening on PORT ${PORT}!`);
});