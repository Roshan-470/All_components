const express = require("express");
const mongoose = require("mongoose");
const bcrypt = require("bcrypt");
const cors = require("cors");

const app = express();

app.use(express.json());
app.use(cors());

mongoose.connect("mongodb://127.0.0.1:27017/test");

const User = mongoose.model("User",{

email:String,
password:String

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

const isMatch = await bcrypt.compare(password,user.password);

if(isMatch){

res.json({

message:"Login Successful"

});

}

else{

res.json({

message:"Wrong Password"

});

}

});

app.listen(5000,()=>{

console.log("Server running");

});
