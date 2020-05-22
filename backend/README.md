# Backend

start server with ``ruby src/server``

## Docker

Generaten new ```Gemfile.lock```:

```bash
docker run --rm -v "$PWD":/usr/src/app -w /usr/src/app ruby:2.5 bundle install
```

Build container:

```bash
docker build -t fitness_center_backend .
```

Run container:

```bash
docker run -p 3030:3030 -p 50051:50051 -d fitness_center_backend
```
