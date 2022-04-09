function toCelsius(x) {
  return (5.0/9.0) * (x - 32.0);
}

function toFahrenheit(x) {
  return  x * (9.0/5.0) + 32.0;
}

async function apiCall(url) {
  const init = {
    headers: {
      'content-type': 'application/json;charset=UTF-8',
    },
  };
  const response = await fetch(url, init);
  const results = await gatherResponse(response);
  return new Response(results, init);
}

const redirectMap = new Map([
  ['/test1', 'https://mysite.com/newlocation1'],
  ['/test2', 'https://mysite.com/newlocation2'],
  ['/test3', 'https://mysite.com/newlocation3'],
  ['/test4', 'https://mysite.com/newlocation4'],
])

addEventListener('fetch', event => {
  event.respondWith(handleRequest(event.request))
});

const html = `
<html>
  <head>
    <title>my title</title>
    <style>
    @import url(https://fonts.googleapis.com/css2?family=Comfortaa&display=swap);
body {
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
    font-family: -apple-system, BlinkMacSystemFont, Segoe UI, Roboto, Oxygen, Ubuntu, Cantarell, Fira Sans, Droid Sans, Helvetica Neue, sans-serif;
    margin: 0;
    background: linear-gradient(90deg, #4b6cb7, #182848);
}

code {
    font-family: source-code-pro, Menlo, Monaco, Consolas, Courier New, monospace
}

.form-icon {
    font-size: 14px;
}

.login {
    font-family: Comfortaa, cursive;
    margin: auto;
    padding: 8% 0 0;
    width: 360px
}

.form {
    background: #fff;
    border-radius: 10px;
    margin: 0 auto 100px;
    max-width: 360px;
    padding: 45px;
    position: relative;
    text-align: center;
    z-index: 1;
}

.form input {
    background: #f2f2f2;
    border: 0;
    border-radius: 5px;
    box-sizing: border-box;
    font-family: Comfortaa, cursive;
    font-size: 14px;
    margin: 0 0 15px;
    outline: 0;
    padding: 15px;
    width: 100%;
}

.form input:focus {
    background: #dbdbdb
}

.form button {
    background: #4b6cb7;
    border: 0;
    border-radius: 5px;
    color: #fff;
    cursor: pointer;
    font-family: Comfortaa, cursive;
    font-size: 14px;
    outline: 0;
    padding: 15px;
    text-transform: uppercase;
    transition: all .3 ease;
    width: 100%
}

.form button:active {
    background: #395591
}

.form span {
    color: #4b6cb7;
    font-size: 75px;
}
    </style>
  </head>
  <body>

          <div class="login">
            <div class="form">
                <form name="login-form" class="login-form" action="/login" method="GET" data-bitwarden-watching="1">
                    <span class="material-icons">lock</span>
                    <div class="input-group mb-3">
                <div class="input-group-prepend">
                 <span class="input-group-text">
                  <i class="fa fa-user form-icon"></i>
                 </span>
                </div>
                <input type="text" class="form-control" placeholder="Email" id="email" name="email" />
             </div>
             <div class="input-group mb-3">
               <div class="input-group-prepend">
                 <span class="input-group-text">
                   <i class="fa fa-lock form-icon"></i>
                 </span>
               </div>
               <input type="password" class="form-control" placeholder="Password" id="password" name="password" />
             </div>
                    <button type="submit">login</button>
                </form>
            </div>
        </div>
  </body>
</html>
`

async function handleRequest(request) {
  //return new Response('10 degress Celsius to Fahrenheit is ' + toFahrenheit(10), {
  return new Response(html, {
    headers: { 'content-type': 'text/html' },
  })
};

// addEventListener('fetch', async event => {
//   event.respondWith(handleRequest(event.request))
// })

// async function handleRequest(request) {
//   let requestURL = new URL(request.url)
//   let path       = requestURL.pathname.split('/redirect')[1]
//   let location   = redirectMap.get(path)

//   if (location) {
//     return Response.redirect(location, 301)
//   }

//   return fetch(request)
// }
