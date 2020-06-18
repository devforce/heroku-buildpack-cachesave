# heroku-buildpack-cachesave

Copy files to cache. Paths are read from `.buildcache` file in your project source code.

You should use this, if your project is pulling a lot of dependencies during
each build. If you store them into cache and during build you just check if
they haven't changed, your build time will reduce dramatically.

Heroku's buildpacks have ways to cache things already, but they're done fairly
inconsistently, and sometimes the built in ways don't do enough, specifically
with ruby dealing with webpacker in the `assets:precompile` step
https://github.com/heroku/heroku-buildpack-ruby/pull/892#issuecomment-621249249

## Usage example

Set buildpacks so that cacheload is first, then ends with cachesave and cacheclean

```
https://github.com/devforce/heroku-buildpack-cacheload
heroku/ruby
heroku/pgbouncer
https://github.com/devforce/heroku-buildpack-cachesave
https://github.com/devforce/heroku-buildpack-cacheclean
```

Then specify the directories you want to cache between builds

`.buildcache`:

```
~/.cache/yarn
code/server/node_modules
code/client/node_modules
code/client/bower_components
```

## Troubleshooting

**How to clear the cache?**

Use `heroku-repo` plugin.

```
$ heroku plugins:install https://github.com/heroku/heroku-repo.git
$ heroku repo:purge_cache -a appname
```
