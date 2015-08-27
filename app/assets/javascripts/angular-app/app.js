// Re: Angular
//https://scotch.io/tutorials/angularjs-best-practices-directory-structure
//https://github.com/johnpapa/angular-styleguide

// Re: Using JWT for authentication
// https://github.com/Foxandxss/rails-angular-jwt-example

// Re: Testing AngularJS apps
// https://quickleft.com/blog/angularjs-unit-testing-for-real-though/

(function() {
    // inject dependency modules
    var app = angular.module('todoApp', []);
    // for compatibility with Rails CSRF protection
    app.config([
        '$httpProvider',
        function($httpProvider) {
            $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
        }
    ]);

    // Extract this to separate file later
    app.controller('TodoListController', function() {
        console.log("ctrl loaded");
        var todoList = this;
        todoList.todos = [{
            text: 'learn angular',
            done: true
        }, {
            text: 'build an angular app',
            done: false
        }];

        todoList.addTodo = function() {
            todoList.todos.push({
                text: todoList.todoText,
                done: false
            });
            todoList.todoText = '';
        };

        todoList.remaining = function() {
            var count = 0;
            angular.forEach(todoList.todos, function(todo) {
                count += todo.done ? 0 : 1;
            });
            return count;
        };

        todoList.archive = function() {
            var oldTodos = todoList.todos;
            todoList.todos = [];
            angular.forEach(oldTodos, function(todo) {
                if (!todo.done) todoList.todos.push(todo);
            });
        };
    });
    // end todoListController

})();