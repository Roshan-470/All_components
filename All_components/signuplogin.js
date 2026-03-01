async function signup(){

const data = {

name:document.getElementById("name").value,

email:document.getElementById("email").value,

password:document.getElementById("password").value

};

const res = await fetch("http://localhost:5000/api/signup",{

method:"POST",

headers:{

"Content-Type":"application/json"

},

body:JSON.stringify(data)

});

const msg = await res.json();

alert(msg);

}

async function login(){

const data = {

email:document.getElementById("email").value,

password:document.getElementById("password").value

};

const res = await fetch("http://localhost:5000/api/login",{

method:"POST",

headers:{

"Content-Type":"application/json"

},

body:JSON.stringify(data)

});

const msg = await res.json();

alert(msg);

if(msg=="Login success"){

window.location.href="dashboard.html";

}

}
