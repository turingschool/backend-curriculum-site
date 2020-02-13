## Adding Javascript to Rails

1. Logically organize your scripts in the `app/assets/javascripts/` folder.
3. Let the Rails asset pipeline combine them all in one minimized `application.js` file.
4. List scripts in the `app/assets/javascripts/application.js` manifest.
5. Add additional js files to precompile to `config/initializers/assets.rb` file
`Rails.application.config.assets.precompile += %w( <file name>.js )`
5. In your view include a javascript file with a javascript include tag:
`<%= javascript_include_tag "<file name>" %>`
