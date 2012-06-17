# Burninator

A burnchart-centric project management tool.

## Demo

See it in action at http://bruz.github.com/burninator

## Deployment 

Point an HTTP server capable of serving static content (Apache, Nginx, etc.) at the public folder. The application uses [Parse](https://parse.com) as the datastore so there's no need to run a separate back-end server.

The application is configured to use the author's Parse account, but can be easily switched to a different Parse account by changing this line in app/initialize.coffee to include your application ID and JavaScript key:

    Parse.initialize("rRUG9Y1Q3H0mJxasSpa3LwBemfMfJbPnQ2x33MGv", "Po5ZWBMXhuN4q6eLrUSZwRk725cO9A5SOkLICF9q")

## Development

This project uses [Brunch](http://brunch.io/) for asset compilation and serving during development and to build for deployment.

Main languages are [CoffeeScript](http://coffeescript.org/), [Stylus](http://learnboost.github.com/stylus/) and [Handlebars](http://handlebarsjs.com/).

### Installing dependencies

1. Install [Node.js](http://nodejs.org)
2. Install [Node Package Manager](http://npmjs.org/) - if you installed Node.js
with the Windows or OS X installer this should have been included
3. Install [Brunch](http://brunch.io/):

    npm install brunch

4. In the project root run this to install the necessary Node.js packages:

    npm install

### Running

Start the Brunch server:

    brunch watch --server

The app will now be available at http://localhost:3333. Brunch will watch the project files and recompile them whenever there are changes (CoffeeScript -> JavaScript for example).

### Building for deployment

Build the project with minified JS and CSS assets:

    brunch build -m

The deployment assets will now be in the public folder.

## Libraries Used

* jQuery 1.7.2
* Backbone 0.9.2
* Underscore 1.3.1
* HTML5Boilerplate 3.0.3
* Twitter Bootstrap 2.0.4
* Morris.js 0.2.9
* Raphael 2.10
* Parse 1.0.3
* Date.js 1.0-apha1
