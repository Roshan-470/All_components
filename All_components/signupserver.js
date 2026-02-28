const express = require("express");
const mongoose = require("mongoose");
const bcrypt = require("bcrypt");
const cors = require("cors");

const app = express();

app.use(express.json());
app.use(cors());


mongoose.connect("mongodb://127.0.0.1:27017/test");


const User = mongoose.model("User",{

name:String,
email:String,
password:String

});



// SIGNUP

app.post("/signup", async (req,res)=>{

const {name,email,password} = req.body;

const user = await User.findOne({email});

if(user){

return res.json({

message:"User exists"

});

}

const hash = await bcrypt.hash(password,10);

await User.create({

name,
email,
password:hash

});

res.json({

message:"Signup success"

});

});




// LOGIN

app.post("/login", async (req,res)=>{

const {email,password} = req.body;

const user = await User.findOne({email});

if(!user){

return res.json({

message:"User not found"

});

}

const match = await bcrypt.compare(password,user.password);


if(match){

res.json({

message:"Login success"

});

}

else{

res.json({

message:"Wrong password"

});

}

});


app.listen(5000);
