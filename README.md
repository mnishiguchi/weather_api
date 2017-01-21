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

## Models

![](erd/erd.jpg)
