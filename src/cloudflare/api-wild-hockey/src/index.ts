async function handleRequest(_request: Request) {
  console.log('calling method');
    const response = await fetch('https://fixturedownload.com/feed/json/nhl-2021/minnesota-wild', {
        method: 'GET',
        redirect: 'follow',
        headers: {
          "Content-Type": "application/json",
        },
    });
    console.log('apiCall was made.');
    const json = await response.json();
    console.log(json);
  return new Response(JSON.stringify(json), {
    headers: { 'content-type': 'application/json' },
  })
};

addEventListener('fetch', event => {
  event.respondWith(handleRequest(event.request))
});
