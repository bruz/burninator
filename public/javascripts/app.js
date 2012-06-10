(function(/*! Brunch !*/) {
  'use strict';

  if (!this.require) {
    var modules = {};
    var cache = {};
    var __hasProp = ({}).hasOwnProperty;

    var expand = function(root, name) {
      var results = [], parts, part;
      if (/^\.\.?(\/|$)/.test(name)) {
        parts = [root, name].join('/').split('/');
      } else {
        parts = name.split('/');
      }
      for (var i = 0, length = parts.length; i < length; i++) {
        part = parts[i];
        if (part == '..') {
          results.pop();
        } else if (part != '.' && part != '') {
          results.push(part);
        }
      }
      return results.join('/');
    };

    var getFullPath = function(path, fromCache) {
      var store = fromCache ? cache : modules;
      var dirIndex;
      if (__hasProp.call(store, path)) return path;
      dirIndex = expand(path, './index');
      if (__hasProp.call(store, dirIndex)) return dirIndex;
    };
    
    var cacheModule = function(name, path, contentFn) {
      var module = {id: path, exports: {}};
      try {
        cache[path] = module.exports;
        contentFn(module.exports, function(name) {
          return require(name, dirname(path));
        }, module);
        cache[path] = module.exports;
      } catch (err) {
        delete cache[path];
        throw err;
      }
      return cache[path];
    };

    var require = function(name, root) {
      var path = expand(root, name);
      var fullPath;

      if (fullPath = getFullPath(path, true)) {
        return cache[fullPath];
      } else if (fullPath = getFullPath(path, false)) {
        return cacheModule(name, fullPath, modules[fullPath]);
      } else {
        throw new Error("Cannot find module '" + name + "'");
      }
    };

    var dirname = function(path) {
      return path.split('/').slice(0, -1).join('/');
    };

    this.require = function(name) {
      return require(name, '');
    };

    this.require.brunch = true;
    this.require.define = function(bundle) {
      for (var key in bundle) {
        if (__hasProp.call(bundle, key)) {
          modules[key] = bundle[key];
        }
      }
    };
  }
}).call(this);
(this.require.define({
  "application": function(exports, require, module) {
    (function() {
  var Application;

  Application = {
    initialize: function() {
      var ProjectsView, Router;
      ProjectsView = require('views/projects_view');
      Router = require('lib/router');
      this.projectsView = new ProjectsView();
      this.pageSetup();
      this.router = new Router();
      return typeof Object.freeze === "function" ? Object.freeze(this) : void 0;
    },
    pageSetup: function() {
      return $('.date').datepicker();
    }
  };

  module.exports = Application;

}).call(this);

  }
}));
(this.require.define({
  "collections/collection": function(exports, require, module) {
    (function() {
  var Collection,
    __hasProp = Object.prototype.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  module.exports = Collection = (function(_super) {

    __extends(Collection, _super);

    function Collection() {
      Collection.__super__.constructor.apply(this, arguments);
    }

    return Collection;

  })(Parse.Collection);

}).call(this);

  }
}));
(this.require.define({
  "collections/projects": function(exports, require, module) {
    (function() {
  var Collection, Project, Projects,
    __hasProp = Object.prototype.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  Collection = require('./collection');

  Project = require('../models/project');

  module.exports = Projects = (function(_super) {

    __extends(Projects, _super);

    function Projects() {
      Projects.__super__.constructor.apply(this, arguments);
    }

    Projects.prototype.model = Project;

    return Projects;

  })(Collection);

}).call(this);

  }
}));
(this.require.define({
  "initialize": function(exports, require, module) {
    (function() {
  var application;

  application = require('application');

  $(function() {
    Parse.initialize("rRUG9Y1Q3H0mJxasSpa3LwBemfMfJbPnQ2x33MGv", "Po5ZWBMXhuN4q6eLrUSZwRk725cO9A5SOkLICF9q");
    application.initialize();
    return Backbone.history.start();
  });

}).call(this);

  }
}));
(this.require.define({
  "lib/router": function(exports, require, module) {
    (function() {
  var Router, application,
    __hasProp = Object.prototype.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  application = require('application');

  module.exports = Router = (function(_super) {

    __extends(Router, _super);

    function Router() {
      Router.__super__.constructor.apply(this, arguments);
    }

    Router.prototype.routes = {
      '': 'home',
      'new': 'newProject'
    };

    Router.prototype.home = function() {
      return $('#projects').html(application.projectsView.render().el);
    };

    Router.prototype.newProject = function() {
      var router;
      router = this;
      return $('#project-add').modal().on('hide', function() {
        return router.navigate('');
      });
    };

    return Router;

  })(Backbone.Router);

}).call(this);

  }
}));
(this.require.define({
  "lib/view_helper": function(exports, require, module) {
    (function() {



}).call(this);

  }
}));
(this.require.define({
  "models/model": function(exports, require, module) {
    (function() {
  var Model,
    __hasProp = Object.prototype.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  module.exports = Model = (function(_super) {

    __extends(Model, _super);

    function Model() {
      Model.__super__.constructor.apply(this, arguments);
    }

    return Model;

  })(Parse.Object);

}).call(this);

  }
}));
(this.require.define({
  "models/project": function(exports, require, module) {
    (function() {
  var Model, Project,
    __hasProp = Object.prototype.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  Model = require('./model');

  module.exports = Project = (function(_super) {

    __extends(Project, _super);

    function Project() {
      Project.__super__.constructor.apply(this, arguments);
    }

    Project.prototype.className = 'Project';

    return Project;

  })(Model);

}).call(this);

  }
}));
(this.require.define({
  "views/project_view": function(exports, require, module) {
    (function() {
  var ProjectView, View, template,
    __hasProp = Object.prototype.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  View = require('./view');

  template = require('./templates/project');

  module.exports = ProjectView = (function(_super) {

    __extends(ProjectView, _super);

    function ProjectView() {
      ProjectView.__super__.constructor.apply(this, arguments);
    }

    ProjectView.prototype.template = template;

    ProjectView.prototype.tagName = 'li';

    ProjectView.prototype.getRenderData = function() {
      return {
        name: this.model.get('name')
      };
    };

    return ProjectView;

  })(View);

}).call(this);

  }
}));
(this.require.define({
  "views/projects_view": function(exports, require, module) {
    (function() {
  var ProjectView, Projects, ProjectsView, View, template,
    __hasProp = Object.prototype.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  View = require('./view');

  Projects = require('collections/projects');

  ProjectView = require('./project_view');

  template = require('./templates/projects');

  module.exports = ProjectsView = (function(_super) {

    __extends(ProjectsView, _super);

    function ProjectsView() {
      ProjectsView.__super__.constructor.apply(this, arguments);
    }

    ProjectsView.prototype.template = template;

    ProjectsView.prototype.initialize = function() {
      this.projects = new Projects();
      this.projects.on('reset', this.addAll, this);
      return this.projects.fetch();
    };

    ProjectsView.prototype.addAll = function() {
      return this.projects.each(this.addOne);
    };

    ProjectsView.prototype.addOne = function(project) {
      var view;
      view = new ProjectView({
        model: project
      });
      return this.$('#project-list').append(view.render().el);
    };

    return ProjectsView;

  })(View);

}).call(this);

  }
}));
(this.require.define({
  "views/templates/project": function(exports, require, module) {
    module.exports = Handlebars.template(function (Handlebars,depth0,helpers,partials,data) {
  helpers = helpers || Handlebars.helpers;
  var buffer = "", stack1, foundHelper, self=this, functionType="function", helperMissing=helpers.helperMissing, undef=void 0, escapeExpression=this.escapeExpression;


  buffer += "<a href=\"#\">";
  foundHelper = helpers.name;
  stack1 = foundHelper || depth0.name;
  if(typeof stack1 === functionType) { stack1 = stack1.call(depth0, { hash: {} }); }
  else if(stack1=== undef) { stack1 = helperMissing.call(depth0, "name", { hash: {} }); }
  buffer += escapeExpression(stack1) + "</a>\n";
  return buffer;});
  }
}));
(this.require.define({
  "views/templates/projects": function(exports, require, module) {
    module.exports = Handlebars.template(function (Handlebars,depth0,helpers,partials,data) {
  helpers = helpers || Handlebars.helpers;
  var foundHelper, self=this;


  return "<h3>\n  Projects\n</h3>\n  <a href=\"new\" class=\"add\">Add</a>\n\n<ul id=\"project-list\" class=\"nav nav-tabs nav-stacked\">\n  <li class=\"active\"><a href=\"#\">Link</a></li>\n</ul>\n";});
  }
}));
(this.require.define({
  "views/view": function(exports, require, module) {
    (function() {
  var View,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = Object.prototype.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  require('lib/view_helper');

  module.exports = View = (function(_super) {

    __extends(View, _super);

    function View() {
      this.render = __bind(this.render, this);
      View.__super__.constructor.apply(this, arguments);
    }

    View.prototype.template = function() {};

    View.prototype.getRenderData = function() {};

    View.prototype.render = function() {
      this.$el.html(this.template(this.getRenderData()));
      this.afterRender();
      return this;
    };

    View.prototype.afterRender = function() {};

    return View;

  })(Backbone.View);

}).call(this);

  }
}));
