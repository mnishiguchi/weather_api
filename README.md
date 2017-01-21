# Weather Api

In this repository, I will learn about building Rails api apps.

---

## Enforcing a default format

```rb
class ApiController < ApplicationController
  before_action :set_default_format

  private
    def set_default_format
      request.format = :json
    end
end
```

```rb
class Api::V1::LocationsController < ApiController
  # ...
end
```

---

## JWTs vs session cookies
- Both JWTs and session cookies are stateless. If we really want to keep track of
who is logged in; who logged out, we will need to implement a whitelist and blacklist
using database or in-memory state cache.

#### JWT
- Header + Payload + Signature ([docs](https://jwt.io/))
- Encoded with [Base64](https://www.base64decode.org/), anyone can decode a JWT
- Readable by Javascript
- Only the server knows the secret key, and using that key, it verifies that the information is valid
- Must manually add a JWT to a request header on every request
- Need extra caution for XSS and XSRF

#### Rails session cookies
- Encrypted with secret key, only the server can decode a cookie
- HTTP-ONLY - not accessible from Javascript
- Cookies are automatically sent on every request
- Rails provides countermeasures against XSS and CSRF

---

## Knock gem
- Like JWT version of Devise
- Very easy to set up. Read [docs](https://github.com/nsarno/knock).
- User model must have an `authenticate` method, similar to the one added by `has_secure_password`.

---

## ruby-jwt gem
- [docs](https://github.com/jwt/ruby-jwt)

---

## Simulating log in form submission from a single page app

### using cUrl

Log in with password

```bash
$ curl --data "auth[email]=user@example.com&auth[password]=password" http://localhost:3000/api/v1/user_token
{"jwt":"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE0ODUxMTQ1ODMsInN1YiI6MX0.RRkN-X3EGUHhMM3wTfvWujupnmNwXxP9k3bma5SkBYw"}
```

Try to access our api without a JWT

```bash
$ curl -v http://localhost:3000/api/v1/locations/1
*   Trying ::1...
* Connected to localhost (::1) port 3000 (#0)
> GET /api/v1/locations/1 HTTP/1.1
> Host: localhost:3000
> User-Agent: curl/7.43.0

> Accept: */*
>
< HTTP/1.1 401 Unauthorized
< X-Frame-Options: SAMEORIGIN
< X-XSS-Protection: 1; mode=block
< X-Content-Type-Options: nosniff
< Content-Type: text/html
< Cache-Control: no-cache
< X-Request-Id: 943ae954-54ba-4197-a61d-92d27b488e76
< X-Runtime: 0.041746
< Transfer-Encoding: chunked
<
* Connection #0 to host localhost left intact
```

Try to access our api with a JWT

```bash
$ curl -v -H "Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE0ODUxMTQ1ODMsInN1YiI6MX0.RRkN-X3EGUHhMM3wTfvWujupnmNwXxP9k3bma5SkBYw" http://localhost:3000/api/v1/locations/1
*   Trying ::1...
* Connected to localhost (::1) port 3000 (#0)
> GET /api/v1/locations/1 HTTP/1.1
> Host: localhost:3000
> User-Agent: curl/7.43.0
> Accept: */*
> Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE0ODUxMTQ1ODMsInN1YiI6MX0.RRkN-X3EGUHhMM3wTfvWujupnmNwXxP9k3bma5SkBYw

>
< HTTP/1.1 200 OK
< X-Frame-Options: SAMEORIGIN
< X-XSS-Protection: 1; mode=block
< X-Content-Type-Options: nosniff
< Content-Type: application/json; charset=utf-8
< ETag: W/"f6e19543159be2645d531f42e8a400e9"
< Cache-Control: max-age=0, private, must-revalidate
< X-Request-Id: 9ad32672-8c29-4533-98be-bdcf10fb9343
< X-Runtime: 0.102464
< Transfer-Encoding: chunked
<
* Connection #0 to host localhost left intact
{"id":1,"name":"Washington","curent":{"temp":"snowy"}}
```

### pasting a Javascript snippet into a browser's console

```js
const http = new XMLHttpRequest()
const url    = '/api/v1/user_token'
const params = 'auth[email]=user@example.com&auth[password]=password'

http.open('POST', url, true)

// Send the proper header information along with the request
http.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded')

http.onreadystatechange = () => {
  if (http.readyState == 4 && http.status == 201) {
    console.log(http.responseText)
  }
}

http.send(params)
```

```
{"jwt":"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE0ODUxMTcyOTYsInN1YiI6MSwiZW1haWwiOiJ1c2VyQGV4YW1wbGUuY29tIiwiYWRtaW4iOnRydWV9.mIj6ni4a2o_6rItFYWgEmCFG6wKBMsgpyVcpP1VxDWs"}
```

---

## Decoding the token on the browser

```js
window.atob('eyJleHAiOjE0ODUxMTcyOTYsInN1YiI6MSwiZW1haWwiOiJ1c2VyQGV4YW1wbGUuY29tIiwiYWRtaW4iOnRydWV9')
"{"exp":1485117296,"sub":1,"email":"user@example.com","admin":true}"
```

---

## Models

![](erd/erd.jpg)
