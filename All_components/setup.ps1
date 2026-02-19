# Create folders
New-Item middleware -ItemType Directory -Force
New-Item ejs -ItemType Directory -Force
New-Item js -ItemType Directory -Force
New-Item css -ItemType Directory -Force
New-Item utils -ItemType Directory -Force


# asyncWrap.js
@"
module.exports = function asyncWrap(fn){
    return function(req,res,next){
        Promise.resolve(fn(req,res,next)).catch(next);
    }
}
"@ | Set-Content middleware/asyncWrap.js


# ExpressError.js
@"
class ExpressError extends Error{
    constructor(statusCode,message){
        super();
        this.statusCode = statusCode;
        this.message = message;
        this.name = "ExpressError";
    }
}
module.exports = ExpressError;
"@ | Set-Content middleware/ExpressError.js


# errorHandler.js
@"
module.exports = (err,req,res,next)=>{
    console.error(err);
    let {statusCode=500,message="Internal Server Error"} = err;
    res.status(statusCode).send(
        `<h1>\${statusCode}</h1>
         <p>\${message}</p>
         <a href='/'>Go Home</a>`
    );
}
"@ | Set-Content middleware/errorHandler.js


# validateListing.js
@"
const Joi = require('joi');

const listingSchema = Joi.object({
 listing:Joi.object({
   title:Joi.string().required(),
   description:Joi.string().required(),
   price:Joi.number().min(0).required(),
   location:Joi.string().required(),
   country:Joi.string().required()
 }).required()
});

module.exports = listingSchema;
"@ | Set-Content middleware/validateListing.js


# boilerplate.ejs
@"
<!DOCTYPE html>
<html>
<head>
<title>Wanderlust</title>
<link rel='stylesheet' href='/css/style.css'>
</head>
<body>

<%- include('navbar') %>

<main>
<%- body %>
</main>

<%- include('footer') %>

<script src='/js/validation.js'></script>

</body>
</html>
"@ | Set-Content ejs/boilerplate.ejs


# navbar.ejs
@"
<nav>
<h2>Wanderlust Navbar</h2>
</nav>
"@ | Set-Content ejs/navbar.ejs


# footer.ejs
@"
<footer>
<p>© 2026 Wanderlust</p>
</footer>
"@ | Set-Content ejs/footer.ejs


# validation.js
@"
(()=>{
'use strict';
const forms=document.querySelectorAll('.needs-validation');
Array.from(forms).forEach(form=>{
form.addEventListener('submit',event=>{
if(!form.checkValidity()){
event.preventDefault();
event.stopPropagation();
}
form.classList.add('was-validated');
},false);
});
})();
"@ | Set-Content js/validation.js


# style.css
@"
body{
font-family:Arial;
background:#f8f9fa;
}
"@ | Set-Content css/style.css


# mongooseConnection.js
@"
const mongoose=require('mongoose');

async function connectDB(){
try{
await mongoose.connect('mongodb://127.0.0.1:27017/wanderlust');
console.log('MongoDB connected');
}catch(err){
console.log(err);
}
}

module.exports=connectDB;
"@ | Set-Content utils/mongooseConnection.js


# README.md
@"
# Express Reusable Components

Reusable middleware, EJS layout, validation and MongoDB connection.
"@ | Set-Content README.md


Write-Host "All files and detailed code created successfully"
