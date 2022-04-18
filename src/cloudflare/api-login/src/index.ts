interface Login {
  email: string;
  password: string;
}

async function handleRequest(request: Request) {
  const { headers } = request;
  const contentType = headers.get('content-type') || '';
  let json = "{}";

  if( request.method !== 'POST' ) {
    return new Response(json, {
      status: 400,
      statusText: 'must be a POST',
    })
  }

  console.log(request.method);
  console.log(contentType);
  console.log(request.url);

  if( contentType === 'application/x-www-form-urlencoded' ) {
    const text = await request.text();
    return new Response(text, {
      status: 400,
      statusText: 'fail',
    })
  }

  const login: Login = await request.json();
  console.log(JSON.stringify(login));

    json = JSON.stringify(login);

  return new Response(json, {
    status: 200,
    statusText: 'success',
    headers: { 'content-type': 'application/json' },
  })
};

addEventListener('fetch', event => {
  event.respondWith(handleRequest(event.request))
});
