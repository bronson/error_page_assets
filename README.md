# Error Page Assets

Let the asset pipeline generate your static error pages.

This gem lets you include Sprockets-generated CSS and JS files,
complete with cache-busting digests, in `public/404.html` and friends.
You can even use layouts.

No monkeypatching, no Rails engines, no routing, just idiomatic code.
The asset pipeline will generate static files so your
web server shows your custom error pages even when your app is down hard.


## Installation

Add this line to your Gemfile:

```ruby
gem 'error_page_assets'
```

Move your error pages into the asset pipeline

```sh
git mv public/404.html app/assets/html/404.html.erb
git mv public/422.html app/assets/html/422.html.erb
git mv public/500.html app/assets/html/500.html.erb
```

And tell the asset pipeline to compile your error pages.
In `config/application.rb`:

```ruby
config.assets.precompile += %w[404.html 422.html 500.html]
```


## Usage

Whenever assets are precompiled (i.e. during each deploy),
your error pages will be generated and saved in `/public`.

```sh
# (public/404.html doesn't exist)
rails assets:precompile
# (public/404.html is your newest code)
```

Your error pages are automatically generated along with the
rest of your assets each time you deploy.

### Rails Helpers

Now you can update your error pages to use Rails helpers:

```erb
old:
  <link href="/css/application.css" media="all" rel="stylesheet"/>
  <script src="/js/application.js"></script>
new:
  <%= stylesheet_link_tag 'application', media: 'all', digest: true %>
  <%= javascript_include_tag "application" %>
```


## Layouts

The Asset pipeline knows how to include stylesheets in your html,
but it doesn't know how to render layouts.  If you'd like your
static error pages to use layouts too, use the
[render anywhere](https://github.com/yappbox/render_anywhere) gem.


## Roadmap

* Do we still need to use digest:true?
* Use an initializer to automatically add error pages to the sprockets config?
* Rails generator to move your error pages?


## Alternatives

* Inspired by: http://icelab.com.au/articles/precompiled-rails-static-404-and-500-pages/
* Rails Engine: https://github.com/marcusg/dynamic_error_pages
* Dynamic Route: https://github.com/eric1234/better_exception_app


## License

Pain-free MIT.


## Contributing

My app isn't localized so I haven't bothered with `I18n.available_locales`.
If you want localization, please file an issue.

To make this gem less imperfect, please submit your issues and patches on
[GitHub](https://github.com/bronson/error_page_assets/).
