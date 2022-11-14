---
layout: page
title: Build a Ruby Gem
length: 50
tags: ruby, gems, spike
---

## Expectation Setting

In 40 minutes, you:

* Probably won't
    * Walk out with a gem that is super useful in a lot of situations.
    * Know all there is to know about gems, executables, namespacing, etc.
    * Write tests for your gem.
* Probably will
    * Learn some stuff!
    * Have an idea of where to go from here if you want to keep exploring!
* Might
    * Build a gem that does a very simple thing!
    * Publish it so others can install it on their machines!

## Goal

Get from 0 to gem as fast as possible!

I want to see if we can build a thing that we can run from the terminal. If we can do that, I'm convinced you have the tools you need to keep tinkering to make something that's actually interesting! We'll layer in more important pieces later, but to start we're going to move fast and see if we can get a bare bones implementation working.

## Using Bundler to Generate Some Files

### Do you have bundler?

First check to see that you have bundler installed by running:

```
$ bundler -v
```

You should get something like `Bundler version 2.1.4` back. As long as the version is higher than 1.9.0, you should be good. If you didn't get that back, try to run `gem install bundler` and then try again.

### Generating a Skeleton

Now, you'll use bundler to run a command to generate some files that you'll be able to use to create your first gem.

The syntax for this command is `bundler gem --flag(s) gemname`. I want that `gemname` to be unusual enough that I won't have conflicts when I try to publish it. For our purposes, let's write a gem that prints out "Vote for me!" when we run it from the command line. For that, we can use something like the following:

```
bundler gem --exe espinosa2020
```

_Note:_ That `exe` flag means that we are going to generate an executable file, which will allow us to run this gem from the command line. If you wanted to generate a gem that included code that you could just use in other Ruby files, leave this off.

You should get output that looks something like this:

```
Creating gem 'espinosa2020'...
MIT License enabled in config
Code of conduct enabled in config
      create  espinosa2020/Gemfile
      create  espinosa2020/lib/espinosa2020.rb
      create  espinosa2020/lib/espinosa2020/version.rb
      create  espinosa2020/espinosa2020.gemspec
      create  espinosa2020/Rakefile
      create  espinosa2020/README.md
      create  espinosa2020/bin/console
      create  espinosa2020/bin/setup
      create  espinosa2020/.gitignore
      create  espinosa2020/.travis.yml
      create  espinosa2020/.rspec
      create  espinosa2020/spec/spec_helper.rb
      create  espinosa2020/spec/espinosa2020_spec.rb
      create  espinosa2020/LICENSE.txt
      create  espinosa2020/CODE_OF_CONDUCT.md
      create  espinosa2020/exe/espinosa2020
Initializing git repo in /Users/southfork/Desktop/espinosa2020
Gem 'espinosa2020' was successfully created. For more information on making a RubyGem visit https://bundler.io/guides/creating_gem.html
```

### Setting Up Git

Great! Let's get into that directory and take care of some Git housekeeping.

```
$ cd espinosa2020
$ git add ./
$ git commit -m "Initial commit"
$ git branch -m master main
```

Look [here](http://www.kapwing.com/blog/how-to-rename-your-master-branch-to-main-in-git/) for more info on that last one.

### Cleaning Up the Generated Gemspec

There's one more thing we need to do before we can get to the fun parts: update our Gemspec.

When Bundler created our skeleton, it also created a Gemspec for our project. In doing so, it generated some reminders that we'll need to clean up before we can really do anything with this project.

If you open the file with the `.gemspec` extension, you'll see quite a few lines that have `TODO` in them. Let's clean those up now.

This is what my file currently looks like:

```
require_relative 'lib/espinosa2020/version'

Gem::Specification.new do |spec|
  spec.name          = "espinosa2020"
  spec.version       = Espinosa2020::VERSION
  spec.authors       = ["Sal Espinosa"]
  spec.email         = ["sal@turing.edu"]

  spec.summary       = %q{TODO: Write a short summary, because RubyGems requires one.}
  spec.description   = %q{TODO: Write a longer description or delete this line.}
  spec.homepage      = "TODO: Put your gem's website or public repo URL here."
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "TODO: Put your gem's public repo URL here."
  spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
```

I'm going to delete the `allowed_push_host` and `changelog_uri` (we won't need those unless this turns into a larger project), and then add text for the summary, description, homepage, and remaining metadata tags. When I'm done, my file will look like this:

```
require_relative 'lib/espinosa2020/version'

Gem::Specification.new do |spec|
  spec.name          = "espinosa2020"
  spec.version       = Espinosa2020::VERSION
  spec.authors       = ["Sal Espinosa"]
  spec.email         = ["sal@turing.edu"]

  spec.summary       = %q{Vote for me!}
  spec.description   = %q{I'm running for prez!}
  spec.homepage      = "https://github.com/s-espinosa/espinosa2020"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/s-espinosa/espinosa2020"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
```

Notice I used the GitHub link that I'm assuming I'll push to when I'm ready for both the homepage and `source_code_uri`. I'm not currently fancy enough to think I'll need a whole separate webpage for this project.

Okay! We should be ready to go!

## Poking Around

Now that we got all of that out of the way, let's take a quick look around.

### exe

Look inside the exe directory. There is a file there that might be a little different from files you've worked with in the past. First off, notice that it doesn't have a file extension? There's nothing in the file name to tell your computer what kind of file this is. Let's open the file up in our text editor and take a look.

```
#!/usr/bin/env ruby

require "espinosa2020"
```

That second line sure looks like Ruby! But what's going on with the first line?

The combination of the `#!` characters  at the beginning of this file tell Unix that you want to run the remainder of the contents of the file as a script along with giving it the information it needs to figure out how to run the rest of the commands in the file. In this case, we're telling our system that we want to use Ruby to interpret the commands in this file, which means that we can use the M1 Ruby we know in the lines below!

There's just one change we need to make to this file to allow us to run it: we have to tell our system that it's okay to run this as a script. In order to do that we'll need to change the permissions on this file. Run the following command from your command line, replacing `espinosa2020` with the name of the file you have in your `exe` directory.

```
$ chmod +x exe/espinosa2020
```

Now, we should be able to run the code in this file in a way that is similar to the way we run other commands. In order to do that, type the following in your terminal:

```
bundle exec ./exe/espinosa2020
```

Nothing happened? Good! We don't really have any code in there. If you got errors, it might be because you still need to clean something up in your Gemspec. Go back and double check that file for any remaining `TODO`s.

Let's add some code to just see if we can get a better indication that it's working. Inside of the `./exe/espinosa2020` file, add a puts statement.

```
#!/usr/bin/env ruby

require "espinosa2020"
puts "It's working!"
```

Run `bundle exec ./exe/espinosa2020` again to see if it will print `It's working!` to your terminal. If so, we're in good shape.

If that was all that we wanted to do or if our task was equally simple, we could just include code in this file and move forward. However, that's no way to organize more complicated projects. Think of this file like a runner file. We're going to only include the bare minimum we need to get things going in this file.

In most of our M1 projects we've asked you to put your execution code in a `lib` directory. This will be no different. Let's go ahead and poke around in there to see what we find.

### lib

Inside of lib you'll find a directory and a file each with the name of the gem you created. If you open up the file (for me it's called `espinosa2020.rb`), you'll find something that looks like this:

```
require "espinosa2020/version"

module Espinosa2020
  class Error < StandardError; end
  # Your code goes here...
end
```

Look at that! It tells you right there where to put your code!

One quick thing to notice is the `module` at the top level of this code. Modules can be used in a few ways in Ruby. In this case, we're using the module as a way to namespace the classes that we create. Why do this? Mainly because we want to make sure that if we create an `Item` class and one of the people using our gem in a project also creates an `Item` class, Ruby won't be confused between the two.

## Adding Some Code

### lib

Given that bundler set up this nice little file for us and told us to add some code, let's take them up on the offer.

I'm going to adjust the `./lib/espinosa2020.rb` file so that it includes the following:

```ruby
require "espinosa2020/version"

module Espinosa2020
  class Error < StandardError; end

  class Vote
    def for_me
      puts "Vote for me!"
    end
  end
end
```

I replaced the `# Your code goes here...` line with a Vote class that has a single `for_me` method. Now we should be able to use that code in our `exe/espinosa2020` file. Let's go do that now.

### exe

Open `exe/espinosa2020` in your text editor and update it so that instead of printing something it creates an instance of our newly created Vote class and let's it do the printing.

My revised file looks like this:

```
#!/usr/bin/env ruby

require "espinosa2020"
v = Espinosa2020::Vote.new
v.for_me
```

Let's see if we can run that.

```
$ bundle exec ./exe/espinosa2020
```

`Vote for me!` should print out to the terminal. If so, you're almost there!

## Turning Our Bundle of Code Into a Gem

There are two more commands to run in order to get this packaged up as a gem.

```
$ rake build
$ rake install
```

Run those, and then try to type the gem name at your terminal to see what happens. For me, this would be:

```
$ espinosa2020
```

If that works, you've done it! This gem should have been installed on your machine so that you can access it anywhere. Go ahead and open a new terminal window, move to a random directory, and see if you can still type just the gem name to have it run.

## Committing and Publishing

Almost there! Let's start by creating a remote on GitHub and pushing to it.

### Pushing to GitHub

* [Create a new repository on GitHub](https://docs.github.com/en/enterprise/2.13/user/articles/creating-a-new-repository)
* [Link your new remote repository to your local repository](https://docs.github.com/en/github/using-git/adding-a-remote)
* Push to your new remote: `git push --set-upstream origin main`

Check to see if your repo is up to date on GitHub.

### Pushing to RubyGems

Go [here](https://guides.rubygems.org/publishing/#publishing-to-rubygemsorg) to see a more detailed overview of this process.

* [Sign Up for an Account on RubyGems](https://rubygems.org/sign_up)
* Run `ls pkg` to see the full name of the gem you're going to push.
* `gem push pkg/espinosa2020-0.1.0.gem` where `pkg/espinosa2020-0.1.0.gem` is the path to the gem file in the pkg directory.
* Enter your credentials.
* Profit?

Send the name of your gem to a friend and see if they can install successfully! On their computer they should run something like:

```
$ gem install espinosa2020
$ espinosa20202
```

## Additional Resources

* For info on how to build a gem without using bundler to create a skeleton, go [here](https://guides.rubygems.org/make-your-own-gem/)
* For info on how to build a similar gem with some testing and incorporating [Thor](http://whatisthor.com/) to create a CLI, look at [this tutorial](https://bundler.io/guides/creating_gem.html)
* For a different take on building a CLI with Thor, go [here](https://medium.com/magnetis-backstage/how-to-write-your-first-cli-with-thor-9da6636bf744)

## Challenges

* Wrap one of your M1 projects in a gem so you can run it from the command line.
* Create a gem that prints out public information about you from the [GitHub API](https://docs.github.com/en/rest) (e.g. number of repos, username, etc.)
* Create a gem that allows you to encode and decode secret messages.

